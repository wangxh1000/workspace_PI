module Db

class QueryManager
  require "win32ole"

  attr_accessor :connection, :data, :fields

  def initialize()
    @connection = nil
    @data = nil
    @fields = nil
  end

  def open
    connection_string = "Provider=SQLOLEDB.1;"
    connection_string << "Persist Security Info=False;"
    connection_string << "Trusted_Connection=yes;"
    connection_string << "Initial Catalog=Platformintegrity_ATE;"
    connection_string << "Data Source=devdbtfs.cb.careerbuilder.com,2633;"
    connection_string << "Network Library=dbmssocn"

    WIN32OLE.ole_initialize
    @connection = WIN32OLE.new('ADODB.Connection')
    @connection.Open(connection_string)
  end

  def query(sql)
    recordset = WIN32OLE.new('ADODB.Recordset')
    recordset.Open(sql, @connection)
    @fields = []
    recordset.Fields.each do |field|
      @fields << field.Name
    end
    begin
      @data = recordset.GetRows.transpose
    rescue
      @data = []
    end
    recordset.Close
  end

  def queryGB(sql)
    if sql=~ Re_cn
      sql = utf8_to_gb(sql)
    end
    recordset = WIN32OLE.new('ADODB.Recordset')
    recordset.Open(sql, @connection)
    @fields = []
    recordset.Fields.each do |field|
      @fields << field.Name
    end
    begin
      @data = recordset.GetRows.transpose
    rescue
      @data = []
    end
    recordset.Close
  end

  def execute(sql)
    @connection.Execute(sql)
  end

  def executeGB(sql)
    if sql=~ Re_cn
      sql = utf8_to_gb(sql)
    end
    @connection.Execute(sql)
  end

  def close
    @connection.Close
  end

  def utf8_to_gb(s)
    p 'conv to gb18030'
    Iconv.conv("GB18030//IGNORE","UTF-8//IGNORE",s)
  end

  def gb_to_utf8(s)
    p 'conv to utf8'
    Iconv.conv("UTF-8//IGNORE","GB18030//IGNORE",s)
  end

end

end
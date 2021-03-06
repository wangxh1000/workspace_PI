class SandboxController < ApplicationController
  require 'query/query_manager'
  require 'query/query_builder'

  def sandbox
    query_builder = QueryBuilder.new
    query_manager = Db::QueryManager.new

    query_manager.open

    sql = query_builder.build_sandbox_sql
    query_manager.query(sql)
    logger.info(sql)

    @fields_pivot = query_manager.fields_pivot
    @result_pivot = query_manager.data

    query_manager.close
  end


end

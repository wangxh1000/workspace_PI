class TeamController < ApplicationController
  require 'query/query_manager'
  require 'query/query_builder'

  def team
    query_builder = QueryBuilder.new
    query_manager = Db::QueryManager.new

    query_manager.open

    sql = query_builder.build_pivot_for_team('2014-12-17 00:00', '2014-12-30 19:00')
    query_manager.query(sql)
    logger.info(sql)
    @fields = query_manager.fields
    @result = query_manager.data

    query_manager.close
  end
end

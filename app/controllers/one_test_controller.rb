class OneTestController < ApplicationController
  require 'query/query_manager'
  require 'query/query_builder'

  def one_test
    query_builder = QueryBuilder.new
    query_manager = Db::QueryManager.new

    query_manager.open

    sql = query_builder.build_pivot_for_onetest(params[:test_name_query])
    query_manager.query(sql)
    logger.info(sql)
    @fields_pivot = query_manager.fields
    @result_pivot = query_manager.data

    sql = query_builder.build_history_for_onetest(params[:test_name_query])
    query_manager.query(sql)
    logger.info(sql)
    @fields_history = query_manager.fields
    @result_history = query_manager.data

    query_manager.close
  end
end

class QueryBuilder

  def build_sandbox_sql()
    sql = ""
    sql << "SELECT TOP 10 "
    sql << "LogDate, TestSuiteOwner, TestSuite, Result, TimeTakenSeconds, ReportingMachine "
    sql << "FROM SeleniumTestSuites "
    sql << "Where Result NOT IN (\'ExcludedFromTestRun\', \'Ignored\') "
  end

end
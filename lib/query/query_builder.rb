class QueryBuilder

  def build_sandbox_sql()
    sql =
        %Q[
          SELECT TOP 10
            LogDate, TestSuiteOwner, TestSuite, Result, TimeTakenSeconds, ReportingMachine
          FROM SeleniumTestSuites
          Where Result NOT IN (\'ExcludedFromTestRun\', \'Ignored\')
        ]
  end

  def build_pivot_for_onetest(test_name)
    sql =
        %{
          SELECT  logday as Day ,
                  Failed ,
                  Passed ,
                  ExcludedFailed ,
                  ExcludedPassed
          FROM    ( SELECT    LEFT(logdate, 8) AS logday ,
                              result
                    FROM      [Platformintegrity_ATE].[dbo].[SeleniumTestSuites]
                    WHERE     TestSuite LIKE \'%#{test_name}%\'
                              AND type = \'SauceLabs\'
                  ) AS D PIVOT( COUNT(result) FOR result IN ( Failed, ExcludedFailed,
                                                              Passed, ExcludedPassed ) ) as P
          ORDER BY logday DESC
        }
  end

  def build_history_for_onetest(test_name)
    sql =
        %{
          SELECT  Top 60 LogDate as Time ,
                  result ,
                  timetakenseconds as timeTaken
          FROM    [Platformintegrity_ATE].[dbo].[SeleniumTestSuites]
          WHERE   TestSuite LIKE \'%#{test_name}%\'
                  AND type = \'SauceLabs\'
          ORDER BY logdate DESC
        }
  end

  def build_pivot_for_team(start_time, end_time)
    sql =
        %{
          SELECT  TestSuiteOwner ,
                  Failed ,
                  Passed ,
                  ExcludedFailed ,
                  ExcludedPassed
          FROM    ( SELECT    TestSuiteOwner ,
                              result
                    FROM      [Platformintegrity_ATE].[dbo].[SeleniumTestSuites]
                    WHERE     TestSuite LIKE '%ATEDRONE02%'
                              AND type = \'SauceLabs\'
                              AND StartTime BETWEEN \'#{start_time}\' AND \'#{end_time}\'
                  ) AS D PIVOT( COUNT(result) FOR result IN ( Failed, ExcludedFailed,
                                                              Passed, ExcludedPassed ) ) as P
          ORDER BY failed DESC;
        }
  end

end
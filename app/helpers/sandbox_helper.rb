module SandboxHelper

  def format_testsuiteowner(testsuiteowner)
    testsuiteowner.downcase.gsub(/@careerbuilder.com/, '')
  end

  def format_timetakenseconds(timetakenseconds)
    "%.2f" % timetakenseconds
  end

  def format_date(date)
    result = ''
    result << date.to_s[0..3] << '-'
    result << date.to_s[4..5] << '-'
    result << date.to_s[6..7] << ' '
    result << date.to_s[8..9]
  end

end

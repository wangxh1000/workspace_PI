module OneTestHelper

  def fail_item?(item)
    item.include?'Fail'
  end

  def row_class(item)
    if fail_item?(item)
      'error'
    else
      'success'
    end
  end

end

class BaseOperation < SimpleTools::Operation
  def t(key)
    I18n.t(key)
  end
end
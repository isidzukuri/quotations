module ApplicationHelper
  def flash_class(level)
    case level.to_sym
      when :alert then "alert alert-error"
      when :error then "alert alert-error"
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
    end
  end
end

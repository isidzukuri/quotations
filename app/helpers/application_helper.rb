module ApplicationHelper
  def flash_class(level)
    case level.to_sym
      when :error then "alert alert-error"
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :warning then "alert alert-warning"
    end
  end
end

module ApplicationHelper
  def flash_helper(level)
    case level.to_sym
      when :notice then "alert-primary"
      when :success then "alert-success"
      when :error then "alert-danger"
      when :alert then "alert-warning"
      else "alert-info"
    end
  end

  def user_avatar(user)
    'user.png'
  end
end

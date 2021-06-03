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
    if user.avatar?
      user.avatar.url
    else
      asset_pack_path('media/images/user.png')
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.file.present?
      user.avatar.thumb.url
    else
      asset_pack_path('media/images/user.png')
    end
  end

  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_pack_path('media/images/event.jpg')
    end
  end
end

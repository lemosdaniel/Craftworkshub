module AvatarHelper
  def avatar_path(object, options = {})
    ActiveStorage::Current.url_options = {host: 'localhost', port: '3000'}
    object.avatar.url
  end
end

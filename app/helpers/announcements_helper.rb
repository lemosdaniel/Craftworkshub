module AnnouncementsHelper
  def unread_announcements(user)
    last_announcement = Announcement.order(published_at: :desc).first
    return if last_announcement.nil?

    # Highlight announcements for anyone not logged in, cuz tempting
    if user.nil? || user.announcements_last_read_at.nil? || user.announcements_last_read_at < last_announcement.published_at
      "unread-announcements"
    end
  end

  def unread_notification(user)
    notification = user.notifications.includes(:event).last
    return if notification.nil?

    # Highlight announcements for anyone not logged in, cuz tempting
    if notification.nil? || notification.read_at.nil?
      "unread-announcements"
    end
  end

  def announcement_class(type)
    {
      "new" => "text-success",
      "update" => "text-warning",
      "fix" => "text-danger",
    }.fetch(type, "text-success")
  end
end

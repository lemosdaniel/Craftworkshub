module ApplicationHelper
  def star_rating(rating, max_stars = 5)
    full_stars = "⭐" * rating
    empty_stars = "☆" * (max_stars - rating)
    [full_stars, empty_stars]
  end

  def create_event_and_notification(user, message)
    event = Noticed::Event.create!(
      record: user,
      params: { message: message}
    )

    Noticed::Notification.create!(
      recipient: user,
      event: event
    )
  end
end

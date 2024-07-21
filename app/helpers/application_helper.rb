module ApplicationHelper
  def star_rating(rating, max_stars = 5)
    full_stars = "⭐" * rating
    empty_stars = "☆" * (max_stars - rating)
    [full_stars, empty_stars]
  end
end

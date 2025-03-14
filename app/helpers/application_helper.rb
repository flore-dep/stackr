module ApplicationHelper
  def random_rgb_color
    3.times.map { 200 + rand(56) }.join(", ")
  end
end

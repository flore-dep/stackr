# require_relative "../../config/environment"

object = []
(1..12).each do |m|
  sub = []
  date = Time.new(2025, m, 1)
  sub.push(date)
  licenses = License.where("start_date <= ? AND end_date > ?", date, date)
  cost = 0
  licenses.each do |l|
    cost += l.plan.formula[1]
  end
  sub.push(cost)
  object.push(sub)
end

p object

puts '-----------'

object = []
(1..12).each do |m|
  date = Time.new(2025, m, 1)
  Team.all.each do |team|
    sub = []
    sub.push(date)
    sub.push(team.name)
    licenses = team.licenses.where("start_date <= ? AND end_date > ?", date, date)
    cost = 0
    licenses.each do |l|
      cost += l.plan.formula[1]
    end
    sub.push(cost)
    object.push(sub)
  end
end

p object


object = {}
Team.all.each do |team|
  obj = []
  (1..12).each do |m|
    sub = []
    date = Time.new(2025, m, 1)
    sub.push(date)
    licenses = team.licenses.where("start_date <= ? AND end_date > ?", date, date)
    cost = 0
    licenses.each do |l|
      cost += l.plan.formula[1]
    end
    sub.push(cost)
    obj.push(sub)
  end
  object[team.name] = obj
end

puts "-"*200
p object["Marketing"]

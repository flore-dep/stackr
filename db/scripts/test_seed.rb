require_relative "../../config/environment"


puts "tools"
p github = Tool.where(name:"GitHub").count
p github = Tool.where(name:"GitHub").first
puts "plan"
p plan = Plan.where(tool: github).count
p plan = Plan.where(tool: github).first
puts "scope"
p scope = Scope.where(plan: plan).count
p scope = Scope.where(plan:plan).first
puts "licenses"
p License.where(plan: plan)
# p License.where(plan: plan).each do |l|
#   puts "------"
#   p l
# end


# p tech = Team.where(name:"Tech").first
# p tech.tools.count
# tech.tools.each  { |t|
#   puts t.name
# }

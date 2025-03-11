require_relative "../../config/environment"

puts "TESTS SCOPES"
team = Team.create!(name: "some other teamss", organization: Organization.first)

puts "🟢 VALID"
p Scope.new(team: team, plan: Tool.first.plans.first).tap(&:valid?).errors.full_messages

puts "❌ INVALID"
p Scope.new(plan: Tool.first.plans.first).tap(&:valid?).errors.full_messages
p Scope.new(team: team).tap(&:valid?).errors.full_messages
p Scope.new(team: Scope.first.team, plan: Scope.first.plan).tap(&:valid?).errors.full_messages


# Destroy here
team.destroy

require_relative "../../config/environment"


puts "TESTS ORGANIZATIONS"

puts "🟢 VALID"
p Organization.new(name: "some name").tap(&:valid?).errors.full_messages

puts "❌ INVALID"
p Organization.new().tap(&:valid?).errors.full_messages
p Organization.new(name: "").tap(&:valid?).errors.full_messages
p Organization.new(name: "he").tap(&:valid?).errors.full_messages
p Organization.new(name: Organization.first.name).tap(&:valid?).errors.full_messages


puts "DESTROYS"

organization = Organization.create(name: "some name")
team = Team.create(name: "Marketing", organization: organization)
puts "Before : Organizations #{Organization.count} - Teams #{Team.count}"
organization.destroy
puts "after : Organizations #{Organization.count} - Teams #{Team.count}"
puts "Organization exists: #{Organization.exists?(organization.id)}"
puts "Team exists: #{Team.exists?(team.id)}"

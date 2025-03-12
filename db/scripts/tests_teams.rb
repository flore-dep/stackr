require_relative "../../config/environment"

puts "TESTS TEAMS"

puts "🟢 VALID"
p Team.new(name: "NEW TEAM", organization: Organization.first).tap(&:valid?).errors.full_messages

puts "❌ INVALID"
p Team.new().tap(&:valid?).errors.full_messages
p Team.new(name: "NEW TEAM").tap(&:valid?).errors.full_messages
p Team.new(organization: Organization.first).tap(&:valid?).errors.full_messages
p Team.new(name: "", organization: Organization.first).tap(&:valid?).errors.full_messages
p Team.new(name: Team.first.name, organization: Team.first.organization).tap(&:valid?).errors.full_messages

puts "DESTROYS"

require_relative "../../config/environment"


puts "TESTS ORGANIZATIONS"

puts "🟢 VALID"
p Organization.new(name: "some name").tap(&:valid?).errors.full_messages

puts "❌ INVALID"
p Organization.new().tap(&:valid?).errors.full_messages
p Organization.new(name: "").tap(&:valid?).errors.full_messages
p Organization.new(name: "he").tap(&:valid?).errors.full_messages
p Organization.new(name: Organization.first.name).tap(&:valid?).errors.full_messages

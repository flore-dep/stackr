require_relative "../../config/environment"

puts "TESTS TOOLS"

puts "🟢 VALID"
p Tool.new(name: "New test app", category: "Communication").tap(&:valid?).errors.full_messages

puts "❌ INVALID"
p Tool.new(category: "Communication").tap(&:valid?).errors.full_messages
p Tool.new(name: "Test app").tap(&:valid?).errors.full_messages
p Tool.new(name: "", category: "Communication").tap(&:valid?).errors.full_messages
p Tool.new(name: "Test app", category: "").tap(&:valid?).errors.full_messages
p Tool.new(name: "Test app", category: "some false category").tap(&:valid?).errors.full_messages
p Tool.new(name: Tool.first.name, category: "Communication").tap(&:valid?).errors.full_messages

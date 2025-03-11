require_relative "../../config/environment"

puts "TESTS TOOL"

puts "🟢 VALID"
# p Tool.new(name: "Frontapp", category: "Mailer", formulas: {free: 0, business: 15, enterprise: 50}, access_types: ["User", "Admin"]).tap(&:valid?).errors.full_messages
# p Tool.new(name: "Marketing", organization: Organization.first)

puts "❌ INVALID"

require_relative "../../config/environment"

puts "TESTS PLANS"

tool = Tool.create!(name: "Some random name 2", category: "Communication")

puts "🟢 VALID"
p Plan.new(organization: Organization.first, tool: tool, formula: JSON.parse(tool.formulas).to_a.sample, status: "Approved").tap(&:valid?).errors.full_messages

puts "❌ INVALID"
p Plan.new(organization: Organization.first, formula: JSON.parse(tool.formulas).to_a.sample, status: "Approved").tap(&:valid?).errors.full_messages
p Plan.new(tool: tool, formula: JSON.parse(tool.formulas).to_a.sample, status: "Approved").tap(&:valid?).errors.full_messages
p Plan.new(organization: Organization.first, tool: tool, status: "Approved").tap(&:valid?).errors.full_messages
p Plan.new(organization: Organization.first, tool: tool, formula: JSON.parse(tool.formulas).to_a.sample).tap(&:valid?).errors.full_messages


# Destroy here
tool.destroy

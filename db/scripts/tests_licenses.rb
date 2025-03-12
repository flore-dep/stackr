require_relative "../../config/environment"

# ENVIRONNEMENT
user = User.first
user_license = user.licenses.first
user_plan = user_license.plan
user_tool = user_plan.tool


puts "TESTS LICENSES"

puts "🟢 VALID"
user_license.update!(end_date: "2025-02-01")
p License.new( user: User.first, start_date: "2025-02-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages

puts "❌ INVALID"
p License.new( user: User.first, start_date: "2025-01-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( start_date: "2025-01-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: User.first, status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: User.first, start_date: "2025-01-01", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: User.first, start_date: "2025-01-01", status: "Approved", plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: User.first, start_date: "2025-01-01", status: "Approved", access_type: user_tool.access_types.sample).tap(&:valid?).errors.full_messages

p License.new( user: User.first, start_date: "2025-02-01", status: "other", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: User.first, start_date: "2025-02-01", status: "Approved", access_type: "Other", plan: user_plan).tap(&:valid?).errors.full_messages


p License.new( user: User.first, start_date: "2025-01-01", end_date: "2026-01-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: User.first, start_date: "2025-02-01", end_date: "2025-01-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
user_license.update!(end_date: nil)
p License.new( user: User.first, start_date: "2025-02-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages

require_relative "../../config/environment"

# ENVIRONNEMENT
user = User.first
user_license = user.licenses.first
user_plan = user_license.plan
user_tool = user_plan.tool


puts "TESTS LICENSES"

puts "🟢 VALID"
p License.new( user: user, start_date: "2026-01-01", end_date: "2027-01-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: user, start_date: "2024-01-01", end_date: "2025-01-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages

puts "❌ INVALID"

# presence
p License.new(start_date: "2026-01-01", end_date: "2027-01-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: user, end_date: "2027-01-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: user, start_date: "2026-01-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: user, start_date: "2026-01-01", end_date: "2027-01-01", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: user, start_date: "2026-01-01", end_date: "2027-01-01", status: "Approved", plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: user, start_date: "2026-01-01", end_date: "2027-01-01", status: "Approved", access_type: user_tool.access_types.sample).tap(&:valid?).errors.full_messages

# inclusions
p License.new( user: user, start_date: "2026-01-01", end_date: "2027-01-01", status: "Other", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: user, start_date: "2026-01-01", end_date: "2027-01-01", status: "Approved", access_type: "Other", plan: user_plan).tap(&:valid?).errors.full_messages

# dates
p License.new( user: user, start_date: "2026-01-01", end_date: "2026-01-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: user, start_date: "2026-01-02", end_date: "2026-01-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages

# dates overlap
p License.new( user: user, start_date: "2024-01-01", end_date: "2027-01-01", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: user, start_date: "2024-01-01", end_date: "2025-01-02", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages
p License.new( user: user, start_date: "2025-12-31", end_date: "2026-12-31", status: "Approved", access_type: user_tool.access_types.sample, plan: user_plan).tap(&:valid?).errors.full_messages

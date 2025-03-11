puts "Cleaning Database..."
License.destroy_all
Scope.destroy_all
Plan.destroy_all
Tool.destroy_all
User.destroy_all
Team.destroy_all
Organization.destroy_all
puts "Database cleaned"

puts "Creating Organization..."
organization = Organization.create!(name: "Stackr Inc")
puts "Created Organization"

puts "Creating Team..."
team = Team.create!(
  name: "Tech",
  organization: organization)
puts "Created Team"


puts "Creating User..."
user = User.create!(
  first_name: "John",
  last_name: "Stackerman",
  email: "john@test.com",
  password: "test12345",
  role: "Founder",
  team: team,
  start_date: "2025-01-01"
)
user = User.create!(
  first_name: "David",
  last_name: "Managerman",
  email: "david@test.com",
  password: "test12345",
  role: "Manager",
  team: team,
  start_date: "2025-01-01"
)
user = User.create!(
  first_name: "Josh",
  last_name: "Employeeman",
  email: "josh@test.com",
  password: "test12345",
  role: "Employee",
  team: team,
  start_date: "2025-01-01"
)
puts "Created User"

puts "Creating Tool..."
tool = Tool.create!(
  name: "Frontapp",
  category: "Mailer",
  formulas: {
    free: 0,
    business: 15,
    enterprise: 50
  },
  access_types: ["User", "Admin"]
  )
  puts "Created Tool"

  puts "Creating Plan..."
  plan = Plan.create!(
    organization: organization,
    tool: tool,
    formula: { business: 15 },
    status: "Approved"
  )
  puts "Created Plan"


  puts "Creating Scope..."
  scope = Scope.create!(
    team: team,
    tool: tool,
    plan: plan
  )
  puts "Created Scope"

  puts "Creating License..."
  license = License.create!(
    user: user,
    scope: scope,
    start_date: "2025-01-01",
    status: "Approved",
    access_type: "User",
    plan: plan
  )
  puts "Created License"

puts "Seeding complete"

puts "Cleaning Database..."
User.destroy_all
Team.destroy_all
Organization.destroy_all
puts "Database cleaned"

puts "Creating Organization..."
orga = Organization.create!(name: "Stackr Inc")
puts "Created Organization"

puts "Creating Team..."
team = Team.create!(name: "Tech", organization_id: orga.id)
puts "Created Team"


puts "Creating User..."
User.create!(
  first_name: "John",
  last_name: "Stackerman",
  email: "john@test.com",
  password: "test12345",
  role: "Founder",
  organization_id: team.organization_id,
  team_id: team.id
)
puts "Created User"

puts "Seeding complete"

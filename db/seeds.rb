require 'faker'
require "csv"
require 'json'

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

puts "Creating Teams..."

marketing = Team.create!(name: "Marketing", organization: organization)
sales = Team.create!(name: "Sales", organization: organization)
operations = Team.create!(name: "Operations", organization: organization)
human_ressources = Team.create!(name: "Human ressources", organization: organization)
tech = Team.create!(name: "Tech", organization: organization)
data = Team.create!(name: "Data", organization: organization)
produit = Team.create!(name: "Produit", organization: organization)
founders = Team.create!(name: "Founders", organization: organization)
teams = [marketing, sales, operations, human_ressources, tech, data, produit]
puts "Created Team"

puts "Creating Users..."

collaborators = []

teams.each do |team|
  10.times do
    user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "test12345", role: "Employee", team: team, start_date: "2025-01-01")
    collaborators << user
  end

  user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "test12345", role: "Manager", team: team, start_date: "2025-01-01")
  collaborators << user
end

3.times do
  user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "test12345", role: "Founder", team: founders, start_date: "2025-01-01")
  collaborators << user
end

puts "Created Users"

puts "Creating Tools..."
categories = ["Productivity", "Project Management", "Communication", "CRM"]
filepath = File.expand_path("seeds.csv", __dir__)
CSV.foreach(filepath) do |row|
  puts "#{row[0]}"
  tool = Tool.create!(name: row[0], category: categories.sample)
end

puts "Created Tools"

puts "Creating Plans..."
Tool.all.each do |tool|
  plan = Plan.create!(organization: organization, tool: tool, formula: JSON.parse(tool.formulas).to_a.sample, status: "Approved")
end

puts "Created Plans"

puts "Creating Scopes..."

teams.each do |team|
  5.times do
    scope = Scope.create!(team: team, plan: Plan.all.sample)
  end
end

puts "Created Scopes"

puts "Creating Licenses..."

Scope.all.each do |scope|
  scope.team.users.each do |user|
    license = License.create!( user: user, scope: scope, start_date: "2025-01-01", status: "Approved", access_type: "User", plan: scope.plan)
  end

end

puts "Created Licenses"

puts "Seeding complete"

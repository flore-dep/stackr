require 'faker'
require "csv"
require 'json'
require "open-uri"
require 'tty-progressbar'

# Cloudinary storage (passer en false pour faire des tests)
cloudinary_storage = true

# Clean DB
puts "Cleaning Database..."
License.destroy_all
Scope.destroy_all
Plan.destroy_all
Review.destroy_all
Tool.all.each { |tool| tool.logo.purge_later }
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

# Set organization
team_size = 10
founder_size = 2
total_users = teams.length * team_size + founder_size +1
bar = TTY::ProgressBar.new("Users :bar :percent", total: total_users, width: 50, complete: "█", incomplete: "░")

# Create users per team
teams.each do |team|
  team_size.times do
    user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "test12345", role: "Employee", team: team, start_date: "2025-01-01")
    bar.advance
  end
  user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "test12345", role: "Manager", team: team, start_date: "2025-01-01")
  bar.advance
end

# Create founders
User.create!(first_name: "John", last_name: "Stackrman", email: "js@stackr.com", password: "test12345", role: "Founder", team: founders, start_date: "2025-01-01")
bar.advance
founder_size.times do
  user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "test12345", role: "Founder", team: founders, start_date: "2025-01-01")
  bar.advance
end

puts "Created Users"

puts "Creating Tools..."
categories = ["Productivity", "Project Management", "Communication", "CRM"]
filepath = File.expand_path("seeds.csv", __dir__)
total_tools = File.foreach(filepath).count
bar = TTY::ProgressBar.new("Tools :bar :percent - :tool", total: total_tools, width: 50, complete: "█", incomplete: "░")

# Create tools
CSV.foreach(filepath) do |row|
  tool = Tool.create!(name: row[0], category: categories.sample, description: row[1], long_description: row[2], website: row[3])
  if cloudinary_storage
    begin
      file = URI.open(row[4])
      tool.logo.attach(io: file, filename: "default_logo.jpg", content_type: "image/jpeg")
    rescue OpenURI::HTTPError, Errno::ENOENT => e
      puts "⚠️ Erreur lors du téléchargement du logo"
      next
    end
  end
  bar.advance(tool: row[0])
end

puts "Created Tools"

puts "Creating Reviews..."
Tool.all.each do |tool|
  10.times do
    review = Review.create(username: "#{Faker::Name.first_name}#{Faker::Name.last_name}",content: Faker::Quotes::Shakespeare.hamlet_quote,rating: (0..5).to_a.sample, tool: tool)
  end
end
puts "Created Reviews"

puts "Creating Plans..."
Tool.all.each do |tool|
  plan = Plan.create!(organization: organization, tool: tool, formula: JSON.parse(tool.formulas).to_a.sample, status: "Approved")
end

puts "Created Plans"

puts "Creating Scopes..."

main_plan_count = Plan.all.count - 5
main_plans = []
subset_plans = []
i = 0
Plan.all.each do |plan|
  if i <= main_plan_count
    main_plans << plan
  else
    subset_plans << plan
  end
  i += 1
end

teams.each do |team|
  plans = main_plans.dup
  5.times do
    plan = plans.sample
    scope = Scope.create!(team: team, plan: plan)
    plans.delete(plan)
  end
end

puts "Created Scopes"

puts "Creating Licenses..."

# Creation des licenses scopées
Scope.all.each do |scope|
  scope.team.users.each do |user|
    license = License.create!( user: user, scope: scope, start_date: "2025-01-01", end_date: "2026-01-01", status: "Approved", access_type: "User", plan: scope.plan)
  end
end

# Creation de licenses individuelles confirmed pour l'équipe marketing
marketing.users.each do |user|
  subset_plans.each do |plan|
    license = License.create!( user: user, start_date: "2025-01-01", end_date: "2026-01-01", status: "Approved", access_type: "User", plan: plan)
  end
end

# Creation de licenses individuelles pending/declined pour l'équipe sales
sales.users.each do |user|
  subset_plans.each do |plan|
    ["Declined","Pending"].each do |status|
      license = License.create!( user: user, start_date: "2025-01-01", end_date: "2026-01-01", status: status, access_type: "User", plan: plan)
    end
  end
end


puts "Created Licenses"

puts "Seeding complete"

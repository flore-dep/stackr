require_relative "../../config/environment"

puts "TESTS USERS"

puts "🟢 VALID"
p User.new(first_name: "Serge", last_name: "Blanco", email: "test@test.com", password: "test12345", role: "Founder", team: Team.first, start_date: "2025-01-01").tap(&:valid?).errors.full_messages
p User.new(first_name: User.first.first_name, last_name: "Blanco", email: "test@test.com", password: "test12345", role: "Founder", team: Team.first, start_date: "2025-01-01").tap(&:valid?).errors.full_messages
p User.new(first_name: "Serge", last_name: User.first.last_name, email: "test@test.com", password: "test12345", role: "Founder", team: Team.first, start_date: "2025-01-01").tap(&:valid?).errors.full_messages


puts "❌ INVALID"
p User.new(first_name: "Serge", last_name: "Blanco", email: "test@test.com", password: "test12345", role: "Founder", team: Team.first).tap(&:valid?).errors.full_messages
p User.new(first_name: "Serge", last_name: "Blanco", email: "test@test.com", password: "test12345", role: "Founder", start_date: "2025-01-01").tap(&:valid?).errors.full_messages
p User.new(first_name: "Serge", last_name: "Blanco", email: "test@test.com", password: "test12345", team: Team.first, start_date: "2025-01-01").tap(&:valid?).errors.full_messages
p User.new(first_name: "Serge", email: "test@test.com", password: "test12345", role: "Founder", team: Team.first, start_date: "2025-01-01").tap(&:valid?).errors.full_messages
p User.new(last_name: "Blanco", email: "test@test.com", password: "test12345", role: "Founder", team: Team.first, start_date: "2025-01-01").tap(&:valid?).errors.full_messages
p User.new(first_name: "", last_name: "Blanco", email: "test@test.com", password: "test12345", role: "Founder", team: Team.first, start_date: "2025-01-01").tap(&:valid?).errors.full_messages
p User.new(first_name: "Serge", last_name: "", email: "test@test.com", password: "test12345", role: "Founder", team: Team.first, start_date: "2025-01-01").tap(&:valid?).errors.full_messages
p User.new(first_name: "Serge", last_name: "Blanco", email: "test@test.com", password: "test12345", role: "", team: Team.first, start_date: "2025-01-01").tap(&:valid?).errors.full_messages
p User.new(first_name: "Serge", last_name: "Blanco", email: "test@test.com", password: "test12345", role: "other", team: Team.first, start_date: "2025-01-01").tap(&:valid?).errors.full_messages
p User.new(first_name: "Serge", last_name: "Blanco", email: "test@test.com", password: "test12345", role: "other", team: Team.first, start_date: "2025-01-01").tap(&:valid?).errors.full_messages
p User.new(first_name: "Serge", last_name: "Blanco", email: "test@test.com", password: "test12345", role: "Founder", team: Team.first, start_date: "2025-01-01", end_date: "2025-01-01").tap(&:valid?).errors.full_messages
p User.new(first_name: "Serge", last_name: "Blanco", email: "test@test.com", password: "test12345", role: "Founder", team: Team.first, start_date: "2025-01-01", end_date: "2024-01-01").tap(&:valid?).errors.full_messages
p User.new(first_name: User.first.first_name, last_name: User.first.last_name, email: "test@test.com", password: "test12345", role: "Founder", team: Team.first, start_date: "2025-01-01").tap(&:valid?).errors.full_messages

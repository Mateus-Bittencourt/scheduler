# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# puts '==> Cleaning database...'
# Appointment.destroy_all
# Professional.destroy_all
# User.destroy_all
# puts '==> Database cleaned.'

puts '==> Creating base user...'
User.create!(
  name: 'Lorem User',
  email: 'loremuser@example.com'
)
puts '==> Base user created.'


puts '==> Creating professionals...'
professionals_data = [
  { name: 'Dr. Ana Souza', specialty: 'Cardiologia' },
  { name: 'Dr. Bruno Alves', specialty: 'Fisioterapia' },
  { name: 'Dra. Carolina Lima', specialty: 'Nutrição' },
  { name: 'Dr. Daniel Ferreira', specialty: 'Psicologia' },
  { name: 'Dra. Elisa Rocha', specialty: 'Dermatologia' }
]

professionals_data.each do |data|
  Professional.create!(data)
  print '.'
end

puts "\n==> Professionals created."
puts '============================'
puts '✅ Seeding finished!'
puts "Total Users: #{User.count}"
puts "Total Professionals: #{Professional.count}"
puts '============================'
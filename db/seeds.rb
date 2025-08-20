# db/seeds.rb

# V I B E S 
# -------------------------------------------------------------------------------------
# puts '==> Cleaning database...'
Appointment.destroy_all
Professional.destroy_all
User.destroy_all
# puts '==> Database cleaned.'

# -------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------
puts '==> Ensuring base user exists...'
user = User.find_or_create_by!(email: 'loremuser@example.com') do |u|
  u.name = 'Lorem User'
end
puts '==> Base user ready.'

# -------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------
puts '==> Ensuring professionals exist...'
professionals_data = [
  { name: 'Dr. Emily Carter', specialty: 'Cardiology' },
  { name: 'Dr. Michael Chen', specialty: 'Physical Therapy' },
  { name: 'Dr. Jessica Davis', specialty: 'Nutrition' },
  { name: 'Dr. Christopher Rodriguez', specialty: 'Psychology' },
  { name: 'Dr. Sarah Miller', specialty: 'Dermatology' },
  { name: 'Dr. David Wilson', specialty: 'Orthopedics' },
  { name: 'Dr. Laura Moore', specialty: 'Gynecology' },
  { name: 'Dr. James Taylor', specialty: 'Ophthalmology' },
  { name: 'Dr. Olivia Anderson', specialty: 'Pediatrics' },
  { name: 'Dr. Robert Thomas', specialty: 'General Practice' }
]

professionals_data.each do |data|
  Professional.find_or_create_by!(name: data[:name]) do |p|
    p.specialty = data[:specialty]
  end
  print '.'
end
puts "\n==> Professionals ready."

# -------------------------------------------------------------------------------------
# Creating appointments in bulk to test pagination.
# -------------------------------------------------------------------------------------
puts '==> Seeding appointments for the next 15 business days...'

# 1. Select the professionals for whom we'll create appointments (using the new names).
professionals_to_seed = Professional.where(name: ['Dr. Emily Carter', 'Dr. Christopher Rodriguez', 'Dr. Sarah Miller'])

# 2. Iterate over the next 15 days, starting from tomorrow.
(Date.current.tomorrow..15.days.from_now).each do |day|
  # 3. Skip weekends.
  next if day.saturday? || day.sunday?

  # 4. Iterate through business hours in 30-minute intervals (9:00 AM to 4:30 PM).
  (9..16).each do |hour|
    [0, 30].each do |minute|
      start_time = day.to_datetime.change(hour: hour, min: minute)

      # 5. Create an appointment for a random professional from our selected list.
      Appointment.find_or_create_by!(
        professional: professionals_to_seed.sample,
        start_time: start_time
      ) do |appointment|
        appointment.user = user
      end
      print '.'
    end
  end
end

puts "\n==> Appointments seeded."
puts '============================'
puts '✅ Seeding finished!'
puts "Total Users: #{User.count}"
puts "Total Professionals: #{Professional.count}"
puts "Total Appointments: #{Appointment.count}"
puts '============================'
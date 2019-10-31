# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

data = {
  countries: [
    {
      name: 'Kenya',
      continent: 'Africa'
    },
    {
      name: 'Japan',
      continent: 'Asia'
    },
    {
      name: 'Brazil',
      continent: 'North America'
    }
  ]
}

# Create country seed data
Country.delete_all

data[:countries].each do |country_data|
  Country.create!(country_data)
end

puts 'Seeding completed...'



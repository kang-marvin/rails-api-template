class Country < ApplicationRecord

  CONTINENTS = ['Africa', 'Asia', 'Europe', 'North America', 'South America', 'Oceania', 'Antarctica']

  validates_presence_of [:name, :continent]

  validates_inclusion_of :continent, in: Country::CONTINENTS
end

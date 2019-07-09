require('pry')
require_relative('./models/bounty')

Bounty.delete_all

bounty1 = Bounty.new( {
  'name' => 'Harrold',
  'bounty_value' => 100,
  'homeworld' => 'Jupiter',
  'collected_by' => 'Anakin'
  })
bounty1.save

bounty2 = Bounty.new( {
  'name' => 'Steven',
  'bounty_value' => 1000,
  'homeworld' => 'Mars',
  'collected_by' => 'Anna'
  })
bounty2.save

bounty3 = Bounty.new( {
  'name' => 'Barth',
  'bounty_value' => 5,
  'homeworld' => 'Pluto',
  'collected_by' => 'Trill'
  })
bounty3.save

bounty1.name = 'New Harrold'
bounty1.homeworld = 'Earth'
bounty1.update

binding.pry
nil

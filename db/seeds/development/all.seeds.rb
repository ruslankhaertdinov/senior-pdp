u = FactoryGirl.create(:user, email: "user@example.com", city: "Kazan")
FactoryGirl.create_list(:article, 3, user: u, free: [true, false].sample)

CITIES = %w(Abakan Baksan Chelyabinsk Dalmatovo Elista Frolovo Grozny Irkutsk Kazan Leninogorsk
            Moscow Naginsk Orsk Penza Rostov Saransk Tambov Ufa Vologda Yakutsk Zainsk)

CITIES.each.with_index(1) do |city, index|
  print "Crearing user ##{index}... "
  user = FactoryGirl.create(:user, email: "user-#{city.downcase}@example.com", city: city)
  puts "done."

  print "Crearing user articles... "
  FactoryGirl.create_list(:article, 3, user: user, free: [true, false].sample)
  puts "done."
end

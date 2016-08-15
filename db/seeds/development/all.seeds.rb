FactoryGirl.create(:user, email: "user@example.com", city: "Kazan")

CITIES = %w(Abakan Baksan Chelyabinsk Dalmatovo Elista Frolovo Grozny Irkutsk Kazan Leninogorsk
            Moscow Naginsk Orsk Penza Rostov Saransk Tambov Ufa Vologda Yakutsk Zainsk)
CITIES.each.with_index(1) do |city, index|
  puts "Crearing user ##{index} ..."
  user = FactoryGirl.create(:user, email: "user-#{city.downcase}@example.com", city: city)
  puts "Crearing user articles ..."
  FactoryGirl.create_list(:article, 3, user: user)
end

FactoryGirl.define do
  factory :restaurant do
    camis 30012345
    dba "Ready Set Bake"
    cuisine
    building_number "1"
    street "Tent"
    boro "MANHATTAN"
    zipcode 12345
    phone_number 2121234567
    current_grade "A"
    current_grade_date Date.today - 1.month
  end
end

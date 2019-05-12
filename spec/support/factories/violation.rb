FactoryGirl.define do
  factory :violation do
    code "08C"
    description "Pesticide use not in accordance with label or applicable laws. Prohibited chemical used/stored. Open bait station used."
    is_critical false
  end
end

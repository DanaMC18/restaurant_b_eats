FactoryGirl.define do
  factory :inspection do
    score 10
    grade "A"
    grade_date Date.today - 1.week
    inspection_date Date.today - 1.week
    record_date Date.today
    inspection_type
    restaurant

    trait :with_violations do
      after(:create) do |inspection|
        inspection.violations << create(:violation)
        inspection.save
        inspection.reload
      end
    end
  end

end

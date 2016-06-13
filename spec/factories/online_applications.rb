FactoryGirl.define do
  factory :online_application do
    married false
    min_threshold_exceeded false
    benefits true
    children 0
    refund false
    probate false
    ni_number 'AB123456C'
    date_of_birth Time.zone.parse('10/03/1976')
    first_name 'Peter'
    last_name 'Smith'
    address '102 Petty France, London'
    postcode 'SW1H 9AJ'
    email_contact false
    phone_contact false
    post_contact false

    trait :refund do
      refund true
      date_fee_paid 20.days.ago
    end

    trait :et do
      form_name 'ET'
    end

    trait :extra_savings_question_required do
      min_threshold_exceeded true
      max_threshold_exceeded false
    end
  end
end

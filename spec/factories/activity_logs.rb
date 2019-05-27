FactoryBot.define do
  factory :activity_log do
    log_type { [:login, :logout].sample }
    performed_at { Date.today }
    # performer_type member
    # performer_id member
  end
end

FactoryBot.define do
  factory :regular_user, class: User do
    username { 'test' }
    password { 'password' }
    password_confirmation { 'password' }
    after(:create) { |user| user.roles = [create(:member)] }
  end
end

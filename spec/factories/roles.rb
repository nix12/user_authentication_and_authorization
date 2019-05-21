FactoryBot.define do
  factory :admin, class: Role do
    name { 'admin' }
  end

  factory :moderator, class: Role do
    name { 'moderator' }
  end

  factory :member, class: Role do
    name { 'member' }
  end

  factory :visitor, class: Role do
    name { 'visitor' }
  end
end

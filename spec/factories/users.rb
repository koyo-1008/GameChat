FactoryBot.define do
  factory :user do #factory :testuser, class: User do のようにクラスを明示すればモデル名以外のデータも作れます。
    name { "test" }
    nickname { "testUser1 "}
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testuser" }
  end
end
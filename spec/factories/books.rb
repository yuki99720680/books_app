FactoryBot.define do
  factory :book do
    title { 'Test Book' }
    memo { 'Trying out Capybara' }
    author { 'm-kimura' }
    picture { File.open(Rails.root.join('spec/files/test.png')) }
  end
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end

  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"]) if Rails.env.test?
  end
end

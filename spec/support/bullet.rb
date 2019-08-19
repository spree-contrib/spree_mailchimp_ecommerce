RSpec.configure do |config|
  config.before(:each) do
    Bullet.enable = true
    Bullet.bullet_logger = true
    Bullet.raise = true
  end
end

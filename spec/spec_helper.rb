require 'rubygems'
require 'guard'
require 'rspec'

Dir["#{File.expand_path('..', __FILE__)}/support/**/*.rb"].each { |f| require f }

puts "Please do not update/create files while tests are running."

RSpec.configure do |config|
  config.color_enabled = true
  config.add_setting :mute_ui, :default => true
  
  config.before(:each) do
    mute_ui! if RSpec.configuration.mute_ui?
    ENV["GUARD_ENV"] = 'test'
    @fixture_path = Pathname.new(File.expand_path('../fixtures/', __FILE__))
  end
  
  config.after(:each) do
    ENV["GUARD_ENV"] = nil
  end
  
end

def mute_ui!
  [:info, :error, :debug].each { |method| Guard::UI.stub!(method) }
end
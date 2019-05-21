require 'yaml'
require 'pry'
require 'capybara/cucumber'
require 'ffaker'
require 'selenium-webdriver'
require 'report_builder'
# require 'credit_card_validations'

include Capybara::DSL

EL = YAML.load_file('data/elements.yml')
Destination = YAML.load_file('data/destinations.yml')
if ENV['chrome']
    $browser = "Google Chrome"
    Capybara.default_driver = :chrome
    Capybara.register_driver :chrome do |app|
    client = Selenium::WebDriver::Remote::Http::Default.new 
    client.timeout = 200
      Capybara::Selenium::Driver.new(app, browser: :chrome, switches:['--disable-infobars','--disable-print-preview', 'start-maximized', '--incognito'], :http_client => client)
    end
end
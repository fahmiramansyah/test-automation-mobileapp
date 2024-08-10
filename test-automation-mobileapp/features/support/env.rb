$LOAD_PATH.unshift File.expand_path('../../page_object', __FILE__)

require 'appium_lib'
require 'appium_lib_core'
require "capybara/cucumber"
require "capybara/rspec"
require 'appium_capybara'
require 'capybara'
require "selenium-webdriver"
require "dotenv"
require "site_prism"
require "httparty"
require "uri"
require "net/http"
require "nokogiri"
require "open-uri"
require "net/http/post/multipart"
require "logger"
require "uri"
require 'logger'
require 'webdrivers'
require 'json'
# require 'faker'
require 'report_builder'
require 'date'
require 'yaml'
require 'pry'
require 'airborne'
require 'touch_action'
require 'slack-ruby-client'
require 'slack-ruby-block-kit'
require 'base64'
require 'quickchart'

include Airborne


# $wait = Selenium::WebDriver::Wait.new :timeout => 60

# ========================= APPIUM CAPYBARA =========================

Dotenv.load
Dotenv.overload(".env.#{ENV['ENV']}")

def get_config_data(key)
  config_data = YAML.load_file("config/data-target-"+ENV["TARGET"].downcase+".yml")
  return config_data[key]
end

@tags = Array.new
$passed=0
$failed=0
$scenario_count=0
$scenario_name=""
$feature_count=0
$feature_name=""
$start_time = Time.now.to_i
$report_format = "report-test-"+Time.at($start_time).strftime("%Y%m%d-%H%M")+"-#{ENV['TARGET'].downcase}"

desired_caps_android = {
    platformName:               "Android",
    # platformVersion:            "12.0",
    # deviceName:                 "Pixel6",
    automationName:             "Appium",
    newCommandTimeout:          "3600",
    connectHardwareKeyboard:    true,
    # ignoreHiddenApiPolicyError: true,
    # autoGrantPermissions: true,
    # noReset: true,
    app:                        File.expand_path("features/app/colornote.apk")
}

desired_caps_ios = {
    platformName:               "iOS",
    platformVersion:            "15.0",
    deviceName:                 "iPhone 13",
    bundleId:                   "com.machtwatch.mobile.#{ENV['TARGET']}",
    # bundleId:                   "com.machtwatch.mobile",
    automationName:             "XCUITest",
    newCommandTimeout:          "3600",
    connectHardwareKeyboard:    true,
    ignoreHiddenApiPolicyError: true,
    # noReset: true,
    # autoGrantPermissions: true,
    # isHeadless: true,
    app:                        File.expand_path("features/app/uf-jamtangan-#{ENV['TARGET']}.zip")
}

url = "http://localhost:4723/wd/hub"

$caps_android = desired_caps_android
$caps_ios = desired_caps_ios

Capybara.register_driver(:android) do |app|
    appium_lib_options = {
      server_url: url
    }
    all_options = {
      appium_lib: appium_lib_options,
      caps: desired_caps_android
    }
    Appium::Capybara::Driver.new app, all_options
end

Capybara.register_driver(:ios) do |app|
    appium_lib_options = {
      server_url: url
    }
    all_options = {
      appium_lib: appium_lib_options,
      caps: desired_caps_ios
    }
    Appium::Capybara::Driver.new app, all_options
end

Capybara.configure do |config|
    config.default_max_wait_time = 60
    config.default_driver = :android
    config.server_host = '0.0.0.0'
    config.server_port = 56844
  end

def loadDriver
    if @tags.include? "@android"
        driver = 'android'.to_sym
    else
        driver = 'ios'.to_sym
    end
    # Capybara.current_driver = driver
    $capy_driver = Capybara.current_session.driver
end

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

at_exit do
  end_time = Time.now.to_i
  $duration = Time.at(end_time - $start_time).utc.strftime('%H:%M:%S')
  ReportBuilder.configure do |config|
    config.input_path = 'features/support/reports/result-cucumber.json'
    config.report_path = "features/support/reports/"+($report_format)
    config.report_title = "Test Result"
    config.additional_info = {
      App: get_config_data('APP_NAME'),
      Environment: ENV['TARGET'].upcase,
      Tags: $tags_run.join(", "),
      "Platform": platform_detail,
      "Run at": Time.now.strftime("%d-%m-%Y %H.%M")
    }
    config.include_images = true
  end
  ReportBuilder.build_report

  if ENV['SLACK_NOTIF']=='yes'
    send_slack_notif
  end

  if $failed > 0
    Kernel.exit(0)
  end
end

def take_screenshot(scenario)
    scenario_name = scenario.name.gsub /[^\w\-]/, ' '
    time = Time.now.strftime("%Y-%m-%d %H%M")
    screenshot_path = 'features/support/failed_png/' + time + ' - ' + scenario_name + '.png'
    Capybara.current_session.driver.save_screenshot(screenshot_path)
    image = open(screenshot_path, 'rb', &:read)
    encoded_image = Base64.encode64(image)
    embed(encoded_image, 'image/png;base64', 'SCREENSHOT')
end

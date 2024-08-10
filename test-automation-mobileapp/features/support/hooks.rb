require_relative '../page_object/test/pages/page_load'

Before do |scenario|
    @tags = scenario.source_tag_names
    loadDriver
    @page=Page.new(@tags)
end

After do |scenario|
    scenario_count(scenario)
    take_screenshot(scenario) if scenario.failed?
    sleep 1
    Capybara.current_session.driver.quit
end

AfterConfiguration do |config|
    $tags_run = config.tag_expressions
end

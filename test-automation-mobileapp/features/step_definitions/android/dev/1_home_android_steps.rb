Given('user access app Colornote') do
  @page.home_page.validateBeginningScreen
end

When('user click next beginning screen') do
  @page.home_page.clickNextBeginningScreen
end

Then('user sees permission page') do
  @page.home_page.validatePermissionReq
end

When('user click next permission request') do
  @page.home_page.clickNextPermissionReq
end

Then('user click allow permission') do
  @page.home_page.clickAllowPermissionReq
end

When('system show tutorial feature') do
  @page.home_page.validateTutorialFeature
end

Then('user click skip tutorial') do
  @page.home_page.clickSkipTutorial
end

When('user sees homepage colornote') do
  @page.home_page.validateHomeColornote
end

Then('user click Add note') do
  @page.home_page.clickAddNote
end

When("user input {string}") do |notes|
  @page.home_page.inputNotes(notes)
end

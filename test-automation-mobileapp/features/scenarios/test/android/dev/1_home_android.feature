@android @home @regression @sanity @dev
Feature: colornote - automation test mobile app

  @test
  Scenario: User access app Colornote to write notes
    Given user access app Colornote
    When user click next beginning screen
    And user sees permission page
    And user click next permission request
    And user click allow permission
    Then system show tutorial feature
    And user click skip tutorial
    And user sees homepage colornote
    And user click Add note
    And user input "Halo, I'm Fahmi"

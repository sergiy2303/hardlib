Feature: User registration related functionality

  @javascript
    Scenario: User should be able to successfully login
      Given I have a user "Dave"
      When I am already logged in as user "Dave"

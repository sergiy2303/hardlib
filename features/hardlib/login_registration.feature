Feature: User registration related functionality

  @javascript
    Scenario: User should be able to successfully register
      When I am trying to register user "Dave"

  @javascript
    Scenario: User should be able to successfully register
      When I am trying to register user "Dave" via invalid credentials
      Then I should see the next error messages:
        | message                | section                    |
        | is invalid             | user_email                 |
        | can't be blank         | user_first_name            |
        | can't be blank         | user_last_name             |
        | doesn't match Password | user_password_confirmation |

  @javascript
    Scenario: User should be able to successfully login
      Given I have a user "Dave"
      When I am already logged in as user "Dave"

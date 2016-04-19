Feature: User registration related functionality

  @javascript
    Scenario: User should be able to see error messages
              User should be able to successfully register
              User should be able to edit account information
              User should be able to move back from edit page
      When I am trying to register user "Dave" via invalid credentials
      Then I should see the next error messages:
        | message                | section                    |
        | is invalid             | user_email                 |
        | can't be blank         | user_first_name            |
        | can't be blank         | user_last_name             |
        | doesn't match Password | user_password_confirmation |
      When I am trying to register user "Dave" via valid credentials
      Then I am trying to edit user "Dave" infirmation via invalid credentials
       And I should see the next error messages:
        | message                | section                    |
        | is invalid             | user_email                 |
        | can't be blank         | user_first_name            |
        | can't be blank         | user_last_name             |
        | doesn't match Password | user_password_confirmation |
       And I press link "Back"
      Then I should be in root page
      Then I am trying to edit user "Dave" infirmation via valid credentials

  @javascript
    Scenario: User should be able to change password
      Given I have a user "Dave"
       When I am already logged in as user "Dave" with "p@ssw0rd" password
       Then I am trying to change user "Dave" with "P@ssw0rd1" password
        And I logout
       When I am already logged in as user "Dave" with "P@ssw0rd1" password

  @javascript
    Scenario: User should see error mesages when he trying
              User should be able to successfully login to login with invalid email or password
      Given I have a user "Dave"
       When I am trying to login with invalid password for user "Dave"
       Then I should see message "Incorrect email or password" in the "form-signin" section
        And I press button with class "close"
        And I am trying to login with invalid email for user "Dave"
       Then I should see message "Incorrect email or password" in the "form-signin" section
        And I press button with class "close"
       When I am already logged in as user "Dave" with "p@ssw0rd" password

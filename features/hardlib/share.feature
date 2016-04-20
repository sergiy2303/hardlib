Feature: User share related functionality

  Background:
    Given I have a user "Dave"
      And I have a user "John"
     And User "Dave" have folowing project structure:
      | Project | Chapter   | Part                   |
      | Secret  | Chapter 1 | About secret keys      |
      | Secret  | Chapter 2 | About outh tokens      |
      | Secret  | Chapter 3 | About XHR http request |

  @javascript
  Scenario: User should be able to share project
            User should not be able to share project self
            User shpuld not be able to share project twice for the same user
    When I am already logged in as user "Dave" with "p@ssw0rd" password
    Then I follow to "My projects" page
     And I am trying to share project "Secret" with user "John"
    Then I should be in projects page
    When I logout
    When I am already logged in as user "John" with "p@ssw0rd" password
     And I follow to "From share" page
     Then I should see in the "shared-projects" section:
      | content          |
      | Secret           |
      | Test description |


Feature: User project related functionality

  @javascript
  Scenario: User should be able to create project
            User should be able to create chapter
            User should be able to create part
    Given I have a user "Dave"
     When I am already logged in as user "Dave" with "p@ssw0rd" password
      And I follow to "My projects" page
     Then I am trying to create project:
      | Title | Description                     |
      | First | Some decription for new project |
      And I should see in the "my-projects" section:
      | content                         |
      | First                           |
      | Some decription for new project |
     Then I press link "First" with element
     When I am trying to create chapter:
      | Title                 |
      | New title for new Age |
     Then I should see in the "project-chapters" section:
      | content               |
      | New title for new Age |
      And I press link "New title for new Age" with element
     When I am trying to create part:
      | Title  | Body                   |
      | Part 1 | Some body for the part |
     Then I should see in the "chapter-parts" section:
      | content                |
      | Part 1                 |
      | Some body for the part |
      And I press link "Part 1" with element
     Then I should see in the "show-part" section:
      | content                |
      | Part 1                 |
      | Some body for the part |
     And User "Dave" should have:
      | projects | chapters | parts |
      | 1        | 1        | 1     |

  @javascript
  Scenario: User should be able to delete project
            User should be able to delete chapter
            User should be able to delete part
    Given I have a user "Dave"
      And User "Dave" have folowing project structure:
        | Project | Chapter   | Part                   |
        | Secret  | Chapter 1 | About secret keys      |
        | Secret  | Chapter 1 | About outh tokens      |
        | Secret  | Chapter 2 | About XHR http request |
     When I am already logged in as user "Dave" with "p@ssw0rd" password
      And I follow to "My projects" page
      And I am opening "Secret>Chapter 1"
     Then I am trying to delete part "About secret keys"
      And I press link "Back"
     When I am trying to delete chapter "Chapter 1"
      And I press link "Back"
     Then I am trying to delete project "Secret"
      And User "Dave" should not have items

  @javascript
  Scenario: User should be able to edit part
    Given I have a user "Dave"
      And User "Dave" have folowing project structure:
        | Project | Chapter   | Part              |
        | Secret  | Chapter 1 | About secret keys |
        | Secret  | Chapter 1 | About outh tokens |
     When I am already logged in as user "Dave" with "p@ssw0rd" password
      And I follow to "My projects" page
      And I am opening "Secret>Chapter 1"
     Then I am trying to edit part "About secret keys" with title "Test" and text "Hello test"

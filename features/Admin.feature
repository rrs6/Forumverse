Feature: Admin account
  As a      forum administrator
  I want to be able to delete and edit threads, questions and answers of non-admin users, as well as delete non-admin users
  So that   I can have full control over the forum and make sure that all questions and answers follow the forum's policies and guidelines

  # All mentioned users are non-admin users except when otherwise specified

  Scenario: Removal of an answer from an existing thread
    Given I am logged as an admin
    And   I am at the page of the discussion with question "How to print in JavaScript?", made by user John
    And   The only answer to the question is "I don't know", made by Mary

    When  I select the option to delete Mary's answer
    And   I confirm my intention to delete
    Then  I'm still at the page of the discussion with question "How to print in JavaScript?", made by user John
    And   I see a confirmation message of the deletion
    And   In the place of Mary's former answer, I see a message telling that the answer was deleted by an admin

    When  I log in with a non-admin account
    And   I go to the page of the discussion with question "How to print in JavaScript?", made by user John
    Then  In the place of an answer by Mary, I see a message telling that Mary's answer was deleted by an admin

  Scenario: Removal of an existing discussion thread
    Given I am logged as an admin
    And   I am at the page of the discussion with question "How to print in C#?", made by user Johnathan
    And   The only answer to the question is "Just check the docs…", made by Maryanne

    When  I select the option to delete the discussion
    And   I confirm my intention to delete
    Then  I am redirected to the start page of the forum
    And   I see a confirmation message of the deletion

    When  I search for a discussion with question "How to print in C#?"
    Then  A discussion with that name does not show up as a result

  Scenario: Editing of an answer from another user
    Given I am logged as an admin
    And   I am at the page of the discussion with question "Is it cold where you guys live?", made by user Joseph
    And   The first answer to the question is "No, I live in Recife", made by Anne
    And   The second and last answer to the question is "Yes, I live in South Carolina, Belleview Avenue, 123", made by Mathew

    When  I select the option to edit Mathews's answer
    And   I edit it to "Yes, I live in South Carolina"
    And   I confirm the edition
    Then  I'm still at the page of the discussion with question "Is it cold where you guys live?", made by user Joseph
    And   The first answer to the question is "No, I live in Recife", made by Anne
    And   The second and last answer to the question is "Yes, I live in South Carolina", made by Mathew
    And   Next to Mathew's anwer, I can see a message telling that the answer was edited by an admin

    When  I log in with a non-admin account
    And   I go to the page of the discussion with question "Is it cold where you guys live?", made by user Joseph
    Then  The first answer to the question is "No, I live in Recife", made by Anne
    And   The second and last answer to the question is "Yes, I live in South Carolina", made by Mathew
    And   Next to Mathew's anwer, I can see a message telling that the answer was edited by an admin

  Scenario: Exclusion of a non-admin user
    Given I am logged as an admin
    And   There is a user Julius in the forum whose registered email is julius12345@gmail.com
    And   I am at the page of the discussion with question "How to print in Ruby?", made by Julius
    And   The only answer to the question is "This guy is asking "How to print in" questions for every language! He is trolling", made by Madeline

    When  I select the option to exclude user Julius
    And   I confirm my intention to exclude
    Then  I am redirected to the start page
    And   I see a confirmation message of the deletion

    When  I search for a discussion with question "How to print in Ruby?"
    Then  A discussion with that name does not show up as a result

    When  I try to create a new user account using the email julius12345@gmail.com
    Then  The forum will not allow me to do so

  Scenario: Fail to edit another admin's answer
    Given I am logged as an admin
    And   I am at the page of the discussion with question "How to print in Python?", made by user Williams
    And   The only answer to the question is "Use the print function.", made by Kaori, an admin user
    When  I try to edit Kaori's answer
    Then  I can't edit because Kaori is an admin user
    And   The only answer to the question is still "Use the print function.", made by Kaori

Feature: Search by title
As any user      I want to search a thread by title, which exists in the forum
So that general users can search these discussions by title

Scenario: Search for a publication based on the title, which was found
 Given I'm on the screen that allows searching for a publication by title.
 And   I see the title field to be filled in.
 And   There are two publications entitled “World Cup 98” and “World War I”, stored in the system.
 When  I fill in the name field with “98 World Cup”.
 And   I select the option “Search”.
 Then  On another screen, I can see the search result as the publication “98 World Cup”.

 Scenario: Searching for a publication based on the title, which was not found.
 Given I'm on the screen that allows searching for a publication by title.
 And   I see the title field to be filled in.
 And   There are two publications titled “Electric Cars” and “World War I”, stored in the system.
 When  I fill in the name field with “98 World Cup”.
 And   I select the option “Search”.
 Then  On the same screen, the system displays a message indicating that the system does not contain any publications with the title.



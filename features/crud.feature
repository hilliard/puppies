Feature: Using the database in our tests


   Scenario: Creating a new order in the database
     Given I know how many orders I have
     When I create a new order
     Then I should have 1 additional order

  Scenario: Read an order object from the database
    Given I have an order for "George Washington"
    When I read that order
    Then the order should have the name "George Washington"

  Scenario: Updating an order object
    Given I have an order for "Goofy"
    When I update the name to "Minnie"
    Then I should have a record for "Minnie"
    And I should not have a record for "Goofy"

  Scenario: Delete an order object
    Given I have an order for "Daisey Duck"
    When I delete that order
    Then I should not have a record for "Daisey Duck"

  Scenario: Delivered on date should be set when a puppy is processed
    Given I have a pending adoption for "Dog Lover"
    When I process that adoption
    Then the adoption delivered on date should be set to the current time
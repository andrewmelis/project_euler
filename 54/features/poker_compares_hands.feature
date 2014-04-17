Feature: poker hand evaluator evaluates hands correctly

  As a user
  I want the app to correctly evaluate my hand
  So that I can compare my hand to others

  Scenario: Pair of Fives
    Given a hand with the following cards:
      | rank | suit |
      | 5    | h    |
      | 5    | c    |
      | 6    | s    |
      | 7    | s    |
      | K    | d    |
    Then the rank should be a pair of fives
  
  Scenario: Pair of Eights
    Given a hand with the following cards:
      | rank | suit |
      | 2    | c    |
      | 3    | s    |
      | 8    | s    |
      | 8    | d    |
      | T    | d    |
    Then the rank should be a pair of eights

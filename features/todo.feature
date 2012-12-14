Feature: My simple to-do app works
  In order to keep track of what I need to do
  I want a to-do list that I can keep on my computer
  And manipulate via the command line

  Scenario: App has help info
    When I get help for "todo"
    Then the exit status should be 0

  Scenario: Add a new task
    Given the file "/tmp/todo.txt" doesn't exist
    When I successfully run `todo -f /tmp/todo.txt new 'Some new task'`
    Then I successfully run `todo -f /tmp/todo.txt list`
    And the stdout should contain "Some new task"

  Scenario: Mark a task as done
    Given the file "/tmp/todo.txt" doesn't exist
    When I successfully run `todo -f /tmp/todo.txt new 'Some new task'`
    Then I successfully run `todo -f /tmp/todo.txt done 1`
    Then I successfully run `todo -f /tmp/todo.txt list`
    And the stdout should contain "Some new task"
    And the stdout should contain "C"

  Scenario: The task list is in our home directory by default
    Given there is no task list in my home directory
    When I successfully run `todo new 'Some new task'`
    Then the task list should exist in my home directory
    When I successfully run `todo list`
    Then the stdout should contain "Some new task"


Feature: Transforming JSX into Javascript
  Background:
    Given a fixture app "app"
    Given a successfully built app at "app"

  Scenario: A simple JSX file
    When I cd to "build"
    Then the following files should exist:
      | assets/javascripts/plain_jsx.js |
    When I run `cat assets/javascripts/plain_jsx.js`
    Then the stdout from "cat assets/javascripts/plain_jsx.js" should contain exactly:
      """
      /** @jsx React.DOM */
      
      React.createElement("div", null);

      """
    And the exit status should be 0

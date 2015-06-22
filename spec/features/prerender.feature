Feature: Prerendering a component
  Background:
    Given a fixture app "app"
    Given a successfully built app at "app"

  Scenario: Rendering Helloworld
    When I cd to "build"
    Then the following files should exist:
      | index.html |
    When I run `cat index.html`
    Then the output should contain "Hello </span>"
    And the output should contain "World</span>"

Feature: Transforming JSX into Javascript when it is written in Coffeescript
  Background:
    Given a fixture app "app"
    Given a successfully built app at "app"

  Scenario: A JSX file written in coffeescript
    When I cd to "build"
    Then the following files should exist:
      | assets/javascripts/coffeescript.js |
    When I run `cat assets/javascripts/coffeescript.js`
    Then the stdout from "cat assets/javascripts/coffeescript.js" should contain exactly:
      """

      /** @jsx React.DOM */

      (function() {
        this.app.components.test = React.createClass({displayName: 'test',
          render: function() {
            return React.DOM.div(null, 
            TestComponent({data: this.props.someData})
          );
          }
        });

      }).call(this);

      """
    And the exit status should be 0

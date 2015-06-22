/*globals React, Turbolinks*/

// Unobtrusive scripting adapter for React
;(function(document, window) {
  // jQuery is optional. Use it to support legacy browsers.
  var $ = (typeof window.jQuery !== 'undefined') && window.jQuery;

  // create the  namespace
  window.ReactRailsUJS = {
    CLASS_NAME_ATTR: 'data-react-class',
    PROPS_ATTR: 'data-react-props',
    RAILS_ENV_DEVELOPMENT: true, //<%= Rails.env == "development" %>,
    // helper method for the mount and unmount methods to find the
    // `data-react-class` DOM elements
    findDOMNodes: function(searchSelector) {
      // we will use fully qualified paths as we do not bind the callbacks
      var selector;
      if (typeof searchSelector === 'undefined') {
        var selector = '[' + window.ReactRailsUJS.CLASS_NAME_ATTR + ']';
      } else {
        var selector = searchSelector + ' [' + window.ReactRailsUJS.CLASS_NAME_ATTR + ']';
      }

      if ($) {
        return $(selector);
      } else {
        return document.querySelectorAll(selector);
      }
    },

    mountComponents: function(searchSelector) {
      var nodes = window.ReactRailsUJS.findDOMNodes(searchSelector);

      for (var i = 0; i < nodes.length; ++i) {
        var node = nodes[i];
        var className = node.getAttribute(window.ReactRailsUJS.CLASS_NAME_ATTR);

        // Assume className is simple and can be found at top-level (window).
        // Fallback to eval to handle cases like 'My.React.ComponentName'.
        var constructor = window[className] || eval.call(window, className);
        var propsJson = node.getAttribute(window.ReactRailsUJS.PROPS_ATTR);
        var props = propsJson && JSON.parse(propsJson);

        React.render(React.createElement(constructor, props), node);
      }
    },

    unmountComponents: function(searchSelector) {
      var nodes = window.ReactRailsUJS.findDOMNodes(searchSelector);

      for (var i = 0; i < nodes.length; ++i) {
        var node = nodes[i];

        React.unmountComponentAtNode(node);
      }
    }
  };

  // functions not exposed publicly
  function handleTurbolinksEvents () {
    var handleEvent;
    var unmountEvent;

    if ($) {
      handleEvent = function(eventName, callback) {
        $(document).on(eventName, callback);
      };

    } else {
      handleEvent = function(eventName, callback) {
        document.addEventListener(eventName, callback);
      };
    }

    if (Turbolinks.EVENTS) {
      unmountEvent = Turbolinks.EVENTS.BEFORE_UNLOAD;
    } else {
      unmountEvent = 'page:receive';
      Turbolinks.pagesCached(0);

      if (window.ReactRailsUJS.RAILS_ENV_DEVELOPMENT) {
        console.warn('The Turbolinks cache has been disabled (Turbolinks >= 2.4.0 is recommended). See https://github.com/reactjs/react-rails/issues/87 for more information.');
      }
    }
    handleEvent('page:change', function() {window.ReactRailsUJS.mountComponents()});
    handleEvent(unmountEvent, function() {window.ReactRailsUJS.unmountComponents()});
  }

  function handleNativeEvents() {
    if ($) {
      $(function() {window.ReactRailsUJS.mountComponents()});
      $(window).unload(function() {window.ReactRailsUJS.unmountComponents()});
    } else {
      document.addEventListener('DOMContentLoaded', function() {window.ReactRailsUJS.mountComponents()});
      window.addEventListener('unload', function() {window.ReactRailsUJS.unmountComponents()});
    }
  }

  if (typeof Turbolinks !== 'undefined' && Turbolinks.supported) {
    handleTurbolinksEvents();
  } else {
    handleNativeEvents();
  }
})(document, window);

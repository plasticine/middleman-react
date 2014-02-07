###* @jsx React.DOM ###

@app.components.test = React.createClass
  render: ->
    `<div>
      <TestComponent data={this.props.someData} />
    </div>`

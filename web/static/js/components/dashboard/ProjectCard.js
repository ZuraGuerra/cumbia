import React from "react"
import { Card, Button, Icon } from "reactbulma"

export default class ProjectCard extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    return (
      <Card>
        <Button large>
          <Icon large>
            <i className="fa fa-plus"/>
          </Icon>
        </Button>
      </Card>
    )
  }
}

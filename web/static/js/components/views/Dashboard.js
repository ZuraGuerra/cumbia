import React from "react"
import { Section, Card, Button, Icon } from "reactbulma"
import ProjectCard from "../dashboard/ProjectCard"

export default class Dashboard extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    let projects = [
      {
        "id": 1,
        "name": "Test",
        "description": "laksjfafsa",
        "tags": ["asdf", "qwerty"]
      }
    ]
    function renderProjectCards(projects) {
      return projects.map((project) => {
        <ProjectCard project={project} />
      })
    }
    console.log("KEK", this.props.projects)
    return (
      <Section>
        <Card>
          <Button large>
            <Icon large>
              <i className="fa fa-plus"/>
            </Icon>
          </Button>
        </Card>
        {renderProjectCards(this.props.projects)}
      </Section>
    )
  }
}

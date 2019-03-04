# Better Together

[![Build Status](https://travis-ci.com/better-together-org/better-together.svg?branch=master)](https://travis-ci.com/better-together-org/better-together)

[Request a Slack Invite](https://better-together-coop-invites.herokuapp.com/) | [LinkedIn](https://www.linkedin.com/company/better-together-coop/)

Better Together is a cooperative community building organization and platform. The members of our community network are working together to build a better tomorrow. We promote local resilience by encouraging people to communicate with and support one another by sharing knowledge, skills, resources and time.

This project is currently in the design phase and is undergoing preliminary development. We are currently looking for people and organizations to join and help build the platform.

## Cooperative Organization Structure
Better Together was founded to collaboratively design, build and maintain a community platform owned and operated by its members. Better Together is a community platform where you not only belong, you have a real say in the direction that it takes. By operating as a cooperative, members will make decisions together democratically through discussions and voting. 

## Partner Organizations
Better together is proud to partner with its member organizations to support the development of the platform. If you would like to become a development partner, please get in touch.

<a href="http://alpha.joatu.org/" target="_blank" title="Joatu"><img width="300" src="app/assets/images/partners/joatu.png" alt="Joatu" /></a>
<a href="https://citsci.geog.mcgill.ca/" target="_blank" title="DRAW: Data Rescue Archives and Weather"><img width="300" src="app/assets/images/partners/DRAW.png" alt="DRAW: Data Rescue Archives and Weather"/></a>

## Project Architecture
The Better Together platform is designed to be a modular system. It can either be deployed as a standalone application for full functionality, or one or more of its independent gems can be integrated into third-party applications for a subset of its features.

### Better Together
- Main wrapper application for the platform
- Access to all the platform features from all specific domain applications

### Better Together Core
- Includes the core components and features shared by all domain-specific repositories
- Provides mechanisms to both join and invite people to groups or other entities
- Includes `Person`, `Group`, `Membership`, and `Invitation` entities

### Feature-specific plugins
#### Communicate Together
- Depends on Better Together Core
- Communication and social interaction component
- Responsible for information publishing (Pages), discussions (Discussions, Posts, Comments)

#### Organize Together
- Depends on Better Together Core
- Planning and Scheduling component
- Responsible for collaborative organization features, including Projects, Planning, and Scheduling
- Will aid in finding available times and places

#### Trade Together
- Depends on Better Together Core
- Asset management and trade component
- Responsible for managing inventory of assets (items), as well as trade among members

#### Decide Together
- Depends on Better Together Core
- Decision making and history component

# Better Together

[![Build Status](https://travis-ci.com/better-together-org/better-together.svg?branch=master)](https://travis-ci.com/better-together-org/better-together)

[Join Us!](mailto:better.together.coop@gmail.com?subject=Invitation) | [LinkedIn](https://www.linkedin.com/company/better-together-coop/)

# We Are Better Together

We are a community of and for community builders. Our members are working together to build a better tomorrow. We promote local resilience by encouraging people to communicate with and support one another and share their knowledge, skills, resources and time. 

The Better Together Community Engine is currently in the design phase and is undergoing preliminary development. We are currently looking for people and organizations to join and help build the platform.

## Cooperative Organization Structure
Better Together was founded to collaboratively design, build and maintain a community platform owned and operated by its members. Better Together is a cooperative community where you belong and make the decisions. By operating as a cooperative, members will make decisions together through proposals, discussions and voting. 

## Partner Organizations
Better together is proud to partner with its member organizations to support the development of the platform. If you would like to become a development partner, please get in touch.

<a href="http://alpha.joatu.org/" target="_blank" title="Joatu"><img width="300" src="app/assets/images/partners/joatu.png" alt="Joatu" /></a>
<a href="https://citsci.geog.mcgill.ca/" target="_blank" title="DRAW: Data Rescue Archives and Weather"><img width="300" src="app/assets/images/partners/DRAW.png" alt="DRAW: Data Rescue Archives and Weather"/></a>

## Project Architecture
The Better Together platform is designed to be a modular system. It can either be deployed as a standalone application for full functionality, or one or more of its independent plugins can be integrated into third-party applications for a subset of its features.

### Better Together
- Main wrapper application for the platform

### Better Together Community Engine
- Access to all the platform features from all specific domain applications

#### Gather Together
- Provides mechanisms to both join and invite people to groups or other entities
- People can create, join, and invite others to groups.

#### Communicate Together
- Communication and social interaction component
- Responsible for information publishing (Pages), discussions (Discussions, Posts, Comments)

#### Organize Together
- Planning and Scheduling
- Responsible for collaborative organization features, including Projects, Planning, and Scheduling
- Will aid in finding available times and places

#### Trade Together
- Asset management and trade component
- Responsible for managing inventory of assets (items), as well as trade among members

#### Decide Together
- Decision making and history component

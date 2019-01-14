# Better Together
Better Together is a social platform for all. It is made up of a number of modular repositories that may be used on their own for a subset of features.

This project is currently in the design phase and is undergoing preliminary development. We are currently looking for people and organizations who are interested in contributing to this project.

## Project Architecture
### Better Together
- Main wrapper application for the platform
- Access to all the platform features from all specific domain applications
### Better Together Core
- Responsible for the core components and features shared by all domain-specific repositories
- Includes `Person` and `Group` entities, and provides the ability to invite to and join certain entities, such as groups.
### Domain-specific repositories
#### Communicate Together
- Depends on Better Together Core
- Communication and social interaction component
- Responsible for information publishing (Pages), discussions (Discussions, Posts, Comments)
#### Organize Together
- Depends on Better Together Core
- Planning and Scheduling component
- Responsible for collaborative organization features, including Projects, Planning, and Scheduling.
- Will aid in finding available times and places
#### Trade Together
- Depends on Better Together Core
- Asset management and trade component
- Responsible for managing inventory of assets (items), as well as trand among members and potentially a storefront component at some point

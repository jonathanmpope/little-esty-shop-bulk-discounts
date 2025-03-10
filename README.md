# Little Esty Shop - Bulk Discounts

## Background and Description

"Little Esty Shop" was a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

Bulk Discounts was built on top of the original group project to create a new class of items that. This project included building RESTful routes for database object creation lifecycle (create, edit, destroy, update). Complex Active Record queries are used to calculate new invoice sums based on the use of bulk discounts to invoices. 

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku
- Continuous Integration / Continuous Deployment is not allowed
- Any gems added to the project must be approved by an instructor

## Setup

This project requires Ruby 2.7.4.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

## Notes from Group
1. Line 19 on application.html.erb needs to be commented out, due to the excessive API requests made by other tests. Please comment this line out, before        running  rspec. 

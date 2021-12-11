# Github Scrapper with Rails

### Project Dependencies

* Ruby 3.0.3
* Rails 6.1.4.1
* Bundler 2.2.22
* Postgresql 13.5
* Redis 6.2

## Project setup on local machine

* $ `Clone this project`
* $ `Enter the cloned project`
* $ `cp .env.sample .env`
* Adjust env environment settings accordingly
* You can set USE_FAKE_BITLY environment variable to any truthy value so that system will use a mock version of it through webmock setup

## Running the project with docker

This project uses [dip](https://github.com/bibendi/dip) utility to provision services. If you have dip installed (`gem install dip`) you can have the project up and running with one-line command: `dip provision`

If you are not using **dip**, you can use **docker-compose** commands as usual. These are the suggested commands for launching the app for the first time:

* docker-compose down --volumes --remove-orphans
* docker-compose build
* docker-compose run --rm app bundle install
* docker-compose run --rm app bundle exec rake db:drop db:create db:migrate db:seed
* docker-compose up

## On the web

* This project is also available on the [web](https://hugo-github-scrapper.herokuapp.com/). Go to: https://hugo-github-scrapper.herokuapp.com/

### TODO

* Separate domain and architecture implementation
* Add github event listening **feature** so that system will be able to notify when a synchronization is required to be updated with github url
* Add Rate Limit API response
* Improve web user interface (which includes improving navigability)
* Add system wide logging
* Add caching mechanism to avoid unnecessary external requests on shorten url service and scrapping github for same user
* Add some database constraints such as uniqueness for github url
* Improve user form validation
* Add loading spinners of some sort to improve user experience on waiting for profile scrapping

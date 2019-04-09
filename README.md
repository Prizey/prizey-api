# Prizey API

[![Maintainability](https://api.codeclimate.com/v1/badges/f1939d029861799b00a7/maintainability)](https://codeclimate.com/repos/5c7eb4c98824ec558100ea9c/maintainability)
[![CircleCI](https://circleci.com/gh/SeasonedSoftware/brazil-lab-api/tree/master.svg?style=svg)](https://circleci.com/gh/SeasonedSoftware/brazil-lab-api/tree/master)

## Installing

#### Standalone

1. Clone the repository
2. `bin/bundle`
3. `bin/rails db:create db:migrate`
4. `bin/rails db:seed`
5. `bin/rails s`

#### Docker

1. Clone the repository
2. `docker-compose build`
3. `docker-compose run rails bin/rails db:create db:migrate`
4. `docker-compose run rails bin/rails db:seed`
5. `docker-compose up`

## Running specs

#### Standalone

1. `bin/rspec`

#### Docker

1. `docker-compose run rails bin/rspec`

## Running Rubocop before creating a new Pull Request

#### Standalone

1. `bin/rubocop -a`

#### Docker

1. `docker-compose run rails bin/rubocop -a`

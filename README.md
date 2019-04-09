# Prizey API

[![Maintainability](https://api.codeclimate.com/v1/badges/2c4bf28d85a3dab722ed/maintainability)](https://codeclimate.com/repos/5cacf7104719e67715007ce3/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/2c4bf28d85a3dab722ed/test_coverage)](https://codeclimate.com/repos/5cacf7104719e67715007ce3/test_coverage)

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

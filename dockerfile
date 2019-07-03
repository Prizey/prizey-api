FROM ruby:2.5.5
# Install VIM to edit credentials.yml.enc file
RUN apt-get update && apt-get install -y vim
ENV EDITOR="vim"
# Install container dependencies
RUN apt-get update && apt-get install -y libc-ares2 libv8-3.14.5 postgresql-client nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/
# Set the work directory inside container
RUN mkdir /app
WORKDIR /app
# Copy the Gemfile inside the container
COPY Gemfile /app/
# Install dependencies
RUN gem install bundler -v '2.0.2'
# Copy all the rest inside work directory
COPY . /app
# Access /app and install gems
RUN cd app/
RUN bin/bundle install --jobs 32 --retry 4

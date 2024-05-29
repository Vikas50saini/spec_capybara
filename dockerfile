# Use an official Ruby runtime as a parent image
FROM ruby:3.1.2

# Set environment variables
ENV BUNDLER_VERSION=2.3.4
ENV HEADLESS_MODE=true

# Install necessary packages and Google Chrome
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  curl \
  gnupg \
  unzip \
  wget

# Install Google Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update -qq \
    && apt-get install -y google-chrome-stable

# Set the working directory
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN gem install bundler -v $BUNDLER_VERSION && bundle install

# Copy the rest of the application code into the container
COPY . .

# Set the command to run tests
CMD ["bundle", "exec", "parallel_rspec", "spec", "-n", "4"]

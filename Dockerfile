FROM ruby:2.4.1

ENV app /app
RUN mkdir -p $app

WORKDIR $app
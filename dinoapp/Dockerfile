FROM ruby AS base

FROM base AS release
WORKDIR /app
ADD . /app
CMD ["ruby", "web/server.rb"]

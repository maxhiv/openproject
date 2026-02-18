FROM ruby:4.0.0-slim AS base
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm git curl && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local deployment true && bundle config set --local without 'development test' && bundle install

FROM node:22-slim AS frontend-build
WORKDIR /frontend
COPY frontend/package.json frontend/package-lock.json* ./
RUN npm ci
COPY frontend/ ./
RUN npm run ng build -- --configuration production

FROM base AS final
COPY . .
COPY --from=frontend-build /frontend/dist/control-plane-frontend/browser/ public/app/
RUN bundle exec rails assets:precompile 2>/dev/null || true
EXPOSE 5000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

FROM ruby@sha256:04ee51b10b2807e227c3c025e0a0f485dee1a6e3e1b8d3d35b949fa6ddcadabd

WORKDIR /app

RUN apt-get update -qq && apt-get install -y \
    build-essential libpq-dev curl \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY . .

RUN useradd -m appuser
RUN chown -R appuser:appuser /app
USER appuser

CMD ["sidekiq", "-r", "./worker.rb"]


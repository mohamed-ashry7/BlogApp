#! /bin/bash
lib/wait-for-it.sh db:3306 -t 0
rm -f tmp/pids/server.pid
bundle exec rails db:create db:migrate
bundle exec puma

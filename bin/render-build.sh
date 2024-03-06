set -o errexit
bundle install
builds exec rake db:migrate

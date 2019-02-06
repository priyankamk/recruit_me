# how?????
# - setup config for activerecord

options = if ENV['DATABASE_URL']
  # heroku
else
  # local environment
  {
    adapter: 'postgresql',
    database: 'recruitme'
  }
end

ActiveRecord::Base.establish_connection(options)
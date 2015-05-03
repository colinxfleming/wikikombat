# Sinatra Skeleton

Quick and dirty frame to spin up a singleview sinatra + frontend ajax + activerecord postgres + minitest CRUD app up in a hurry. As a bonus, 

(I realized I was losing a lot of good ideas by not having a template I could just start writing ruby into.)

This is deployed at [Wiki Kombat](http://wikikombat.herokuapp.com).

## Deployment Prep 

First: 
    $ git clone git@github.com:colinxfleming/sinatra-skeleton.git
    $ cp config/config.yml.example config/config.yml 

Then, in config/config.yml:
    change the title to your app title
    change dev_db to your development postgres database
    $ createdb $DB # where db is whatever dev_db in config.yml is set as; rake db:create is a little wonky

Then: 
    add optional gems to app.rb; don't fuss with the big block of config settings
    actually write the app
    make any models and helper methods in their respective folders

Once you're ready for showtime, from the CLI: 
    $ heroku create $APP_NAME # creates a heroku app @
    $ heroku run rake db:migrate
    $ heroku set title='TITLE OF APP' # set other env vars if necessary
    $ heroku run rake db:seed # if necessary

## Whatever

Whatever.
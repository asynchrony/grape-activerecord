grape-activerecord

This gem is modeled after sinatra-activerecord and it's main purpose is
to make sure that AR database connections are released correctly.

USAGE:

  Add the following line to your Gemfile and run bundle.

     gem :grape-activerecord

  In your Grape::API class you will want to include the following:

     class YourGrapeAPP < Grape::API
       include Grape::ActiveRecordExtension

       # your route logic below
     end

Your application will now have the Grape #after filter setup to call
ActiveRecord::clear_active_connections!

The gem also provides some useful database rake tasks:

  * rake db:create_migration  # create an ActiveRecord migration
  * rake db:migrate           # migrate the database (use version with VERSION=n)
  * rake db:rollback          # roll back the migration (use steps with STEP=n)
  * rake db:schema:dump       # dump schema into file
  * rake db:schema:load       # load schema into database

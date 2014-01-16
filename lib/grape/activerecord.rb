require 'active_record'
require 'logger'
require 'active_support/core_ext/string/strip'

load 'grape/activerecord/rake.rb'

module Grape

  module ActiveRecordExtension

    protected

    def self.included(app)
      db_config = YAML.load(ERB.new(File.read("config/database.yml")).result)[(ENV['RACK_ENV'] || :development).to_s]
      ActiveRecord::Base.default_timezone = :utc
      ActiveRecord::Base.establish_connection(db_config)

      # re-connect if database connection dropped
      app.before { ActiveRecord::Base.verify_active_connections! if ActiveRecord::Base.respond_to?(:verify_active_connections!) }
      app.after  { ActiveRecord::Base.clear_active_connections! }
    end
  end
end

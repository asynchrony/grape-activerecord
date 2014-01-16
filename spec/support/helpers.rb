module Helpers
  def establish_database_connection
    change{ActiveRecord::Base.connected?}.to(true)
  end
end

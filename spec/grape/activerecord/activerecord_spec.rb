require 'spec_helper'
require 'grape'
require 'grape/activerecord'

describe "the Grape AR extension" do
  def database_url
    "sqlite3:///tmp/foo.sqlite3"
  end

  def new_grape_application
    Class.new(Grape::API) do
      include Grape::ActiveRecordExtension
    end
  end

  before(:each) do
    ActiveRecord::Base.remove_connection
  end

  context 'config/database.yml does not exist' do
    before(:all) do
      FileUtils.rm_rf("config")
    end

    it "exposes the database object" do
      expect{ new_grape_application }.to raise_error("No such file or directory - config/database.yml")
    end
  end

  context "config/database.yml exists and is valid" do
    before(:all) do
      FileUtils.mkdir_p("config")
      FileUtils.cp("spec/fixtures/database.yml", "config")
    end

    after(:all) do
      FileUtils.rm_rf("config")
    end

    before(:each) do
      @app = new_grape_application
    end

    it 'establishes a connection' do
      expect(ActiveRecord::Base.connection_pool.spec.config[:adapter]).to eq("sqlite3")
      expect(ActiveRecord::Base.connection_pool.spec.config[:database]).to eq("tmp/foo.sqlite3")
      expect(ActiveRecord::Base.connection_pool.spec.config[:pool]).to eq(2)
      expect(ActiveRecord::Base.connection_pool.spec.config[:timeout]).to eq(1000)
    end

    it 'sets up before filter to verify active connections' do
      ActiveRecord::Base.should_receive(:respond_to?).with(:verify_active_connections!) { true }
      ActiveRecord::Base.should_receive(:verify_active_connections!)
      @app.before[0].call()
    end

    it 'sets up after filter to clear active connections' do
      ActiveRecord::Base.should_receive(:clear_active_connections!)
      @app.after[0].call()
    end
  end

end

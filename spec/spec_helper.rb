# frozen_string_literal: true

require 'null_association'
require 'temporary_tables'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDOUT) if ENV.key?('DEBUG')
ActiveRecord::Base.establish_connection(
  ENV.fetch('DATABASE_URL') { 'sqlite3::memory:' },
)

RSpec.configure do |config|
  include TemporaryTables::Methods

  config.expect_with(:rspec) { _1.syntax = :expect }
  config.disable_monkey_patching!
end

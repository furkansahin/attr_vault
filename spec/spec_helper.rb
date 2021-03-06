# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

require 'bundler'
require 'attr_vault'

require 'pg'
require 'sequel'

conn = Sequel.connect(ENV['DATABASE_URL'])
conn.run <<-EOF
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TABLE IF EXISTS items;

CREATE TABLE items(
  id serial primary key,
  key_id integer,
  alt_key_id integer,
  secret_encrypted bytea,
  secret_digest bytea,
  other_encrypted bytea,
  other_digest bytea,
  not_secret text,
  other_not_secret text
);
EOF

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.before(:example) do
    conn.run 'TRUNCATE items'
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end


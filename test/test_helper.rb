$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "tiny/record"
require "minitest/autorun"
require 'active_record'
require 'support/user'
require 'support/admin'
require 'mysql2'
ActiveRecord::Base.establish_connection adapter: "mysql2", database: "memory", username: 'root'
require 'support/schema'

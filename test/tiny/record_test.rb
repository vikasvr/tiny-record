require "test_helper"

class Tiny::RecordTest < Minitest::Test
  attr_accessor :record

  def setup
    @record = User.first_or_create(first_name: "First", last_name: "last")
  end

  def test_that_it_has_a_version_number
    refute_nil ::Tiny::Record::VERSION
  end

  def test_fetch_record
    user = User.find(record.id)
    assert_equal user.attributes, record.attributes
    user = User.fetch(record.id)
    assert_equal user.attributes, record.attributes
    user = User.fetch(record.id, with: :first_name)
    refute_equal user.attributes, record.attributes
    assert_nil user.id
    assert_equal "First", user.first_name
    assert_raises ActiveRecord::RecordNotFound do
      User.fetch(0)
    end
  end

  def test_fetch_by_record
    user = User.fetch_by(first_name: "First")
    assert_equal user.attributes, record.attributes
    user = User.fetch_by(first_name: "First", with: :first_name)
    refute_equal user.attributes, record.attributes
    assert_nil user.id
    assert_equal "First", user.first_name
    assert_nil User.fetch_by(first_name: "test user")
  end

  def test_tiny_columns
    User.instance_eval do
      tiny_columns :id, :first_name
    end
    user = User.fetch(record.id)
    assert_raises ActiveModel::MissingAttributeError do
      user.last_name
    end
    assert_equal "First", user.first_name
    assert_equal record.id, user.id
    User.instance_eval do
      tiny_columns
    end
    user = User.fetch(record.id)
    assert_equal "last", user.last_name
  end
end

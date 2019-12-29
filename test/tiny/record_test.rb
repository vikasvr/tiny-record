require "test_helper"

class Tiny::RecordTest < Minitest::Test
  attr_accessor :record

  def setup
    @record = User.create(first_name: "First", last_name: "last")
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

  def test_fetch_where
    User.create(first_name: "First", last_name: "last")
    users_from_fetch = User.fetch_where(first_name: "First", with: :last_name)
    assert_equal 2, users_from_fetch.count
    users_from_fetch.each do |user|
      assert_equal "last", user.last_name
      assert_raises ActiveModel::MissingAttributeError do
        user.first_name
      end
    end
  end

  def test_tiny_columns
    record = Admin.create(first_name: "new",last_name: "admin")
    admin = Admin.fetch(record.id)
    assert_raises ActiveModel::MissingAttributeError do
      admin.last_name
    end
    assert_equal "new", admin.first_name
  end

  def after_teardown
    User.destroy_all
  end
end

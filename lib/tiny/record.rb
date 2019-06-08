require "tiny/record/version"

module TinyRecord
  def self.included(base)
    base.extend ClassMethods
  end
  module ClassMethods
    @@with_columns = []

    def tiny_columns(*args)
      @@with_columns = *args
    end

    def fetch(id, with: @@with_columns)
      get(primary_lookup(id), with).take!
    end

    def fetch_by(columns = {})
      with = columns.delete(:with)
      get(columns, with).take
    end

    def fetch_where(columns = {})
      with = columns.delete(:with)
      get(columns, with)
    end

    def get(by_columns, with_columns)
      collection = where(by_columns)
      collection = collection.select(with_columns) if with_columns.present?
      collection
    end

    def primary_lookup(lookup_id)
      { primary_key => lookup_id }
    end
  end
end

require "tiny/record/version"
module TinyRecord
  def self.included(base)
    base.extend ClassMethods
  end
  module ClassMethods

    def tiny_columns(*args)
      @default_tiny_columns = *args if args.present?
    end

    def fetch(id, with: nil)
      _get_records(_primary_lookup(id), with).take!
    end

    def fetch_by(columns = {})
      with = columns.delete(:with)
      _get_records(columns, with).take
    end

    def fetch_where(columns = {})
      with = columns.delete(:with)
      _get_records(columns, with)
    end

    def _get_records(by_columns, with_columns)
      collection = where(by_columns)
      collection = _retrieve_selective_columns(collection,with_columns)
      collection
    end

    def _retrieve_selective_columns(collection, requested_columns)
      target_columns = requested_columns && requested_columns.present? ? requested_columns : _default_tiny_columns
      collection = collection.select(target_columns) if collection.present?
      collection
    end

    def _default_tiny_columns
      @default_tiny_columns
    end

    def _primary_lookup(lookup_id)
      { primary_key => lookup_id }
    end
  end
end

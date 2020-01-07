require "tiny/record/version"
module TinyRecord
  def self.included(base)
    base.extend ClassMethods
  end
  module ClassMethods

    def tiny_columns(*args)
      @default_tiny_columns = *args
    end

    def fetch(id, with: nil)
      _get_records(_primary_lookup(id), with).take!
    end

    def fetch_by(tiny_columns = {})
      with = tiny_columns.delete(:with)
      _get_records(tiny_columns, with).take
    end

    def fetch_where(*args)
      if args[0].is_a?(Hash)
        _fetch_from_hash(args)
      else
        _fetch_from_string(args)
      end
    end

    private

    def _get_records(by_columns, with_columns = nil)
      collection = where(by_columns)
      collection = _retrieve_selective_columns(collection,with_columns)
      collection
    end

    def _retrieve_selective_columns(collection, requested_columns)
      target_columns = requested_columns && requested_columns.present? ? requested_columns : _default_tiny_columns
      collection = collection.select(target_columns)
      collection
    end

    def _fetch_from_hash(args)
      target_parameter = args[0]
      with = target_parameter.delete(:with)
      _get_records(target_parameter, with)
    end

    def _fetch_from_string(args)
      _get_records(args)
    end

    def _default_tiny_columns
      @default_tiny_columns
    end

    def _primary_lookup(lookup_id)
      { primary_key => lookup_id }
    end
  end
end

class Admin < ActiveRecord::Base
  include TinyRecord
  tiny_columns :first_name
end

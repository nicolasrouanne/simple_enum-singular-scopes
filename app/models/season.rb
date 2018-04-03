class Season < ActiveRecord::Base
    as_enum :name, low: 0, medium: 1, high: 2, pluralize_scopes: false
end

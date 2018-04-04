class Season < ActiveRecord::Base
    as_enum :name, { low: 1, medium: 2, high: 3 }, pluralize_scopes: false
end

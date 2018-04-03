class Season < ActiveRecord::Base
    as_enum :name, [:low, :medium, :high], pluralize_scopes: false
end

# Simple_enum Singular Scopes
_Debugging project_ for the `simple_enum` gem, issue [#139](https://github.com/lwe/simple_enum/issues/139).

## Issue
The issue is basically that the _singular scopes_ don't seem to be working with [PR #138](https://github.com/lwe/simple_enum/pull/138).

## Usage
This project is using the following versions:
- ruby 2.2.5
- rails 4.0.13

Setup steps:
```bash
# bundle project
$ bundle install
# generate database and migrations
$ rake db:migrate
# generate models using seeds
$ rake db:seed_fu
```

Reproduce "bug":
```bash
# start a rails console
$ rails console

# singular scopes don't work (though they should)
> Season.low
NoMethodError: undefined method `low` for #<Class:0x007f85b9050988>

# pluralized scopes work (though they shouldn't)
> Season.lows
Season Load (0.6ms)  SELECT "seasons".* FROM "seasons" WHERE "seasons"."name_cd" = 0
 => #<ActiveRecord::Relation [#<Season id: 1, created_at: "2018-04-03 09:15:40", updated_at: "2018-04-03 09:15:40", name_cd: 0>]>
```

## EDIT: Fixed! ✅
The issue was solved by [@drobny](https://github.com/drobny); it was caused by `pluralize_scopes` [getting confused](https://github.com/lwe/simple_enum/issues/139#issuecomment-378235776) as an option.

The solution is either to add options as an array, this maps to default arrays indices starting at 0
```ruby
as_enum :name, [:low, :medium, :high], pluralize_scopes: false

# rails console
> Season.low
=> #<ActiveRecord::Relation [#<Season id: 3, created_at: "2018-04-03 09:15:40", updated_at: "2018-04-03 09:15:40", name_cd: 0>]>
```

Or to add options as a hash specifying the value to map to the enum
```ruby
# you can specify whichever integer you like
as_enum :name, { low: 1, medium: 2, high: 3 }, pluralize_scopes: false


# rails console
# NOTE: difference is `name_cd` which is 1 instead of 0
> Season.low
=> #<ActiveRecord::Relation [#<Season id: 3, created_at: "2018-04-03 09:15:40", updated_at: "2018-04-03 09:15:40", name_cd: 1>]>
```

# FactoryBot extensions

factory_bot_extensions is a simple set of syntax extensions that I typically like to use on projects when using factory_bot.

Refactored from factory_girl_extensions https://github.com/GoodGets/factory_girl_extensions

## Install

    gem install factory_bot_extensions

## FactoryBot extensions 6.1

As of version 2.0, factory_bot_extensions now targets the new FactoryBot 26.1 API.

## Usage

```ruby
require 'factory_bot_extensions' # This includes custom methods in every Class.  See below to customize this.

FactoryBot.define do
  factory :user do
    name 'Bob Smith'
  end
end

# Creates a saved instance without raising (same as saving the result of FactoryBot.build)
User.generate(:name => 'Johnny')

# Creates a saved instance and raises when invalid (same as FactoryBot.create)
User.generate!

# Creates an unsaved instance (same as FactoryBot.build)
User.build

# Creates an instance and yields it to the passed block
User.generate do |user|
  # ...do something with user...
end

# Creates and returns a Hash of attributes from this factory (same as FactoryBot.attributes_for).
User.attributes

# A few short aliases are included for convenience.
User.gen
User.gen!
User.attrs

# Factories with custom prefix/suffixes are also supported.
FactoryBot.define do
  factory :admin_user, :parent => :user do
    is_admin true
  end

  factory :user_with_profile, :parent => :user do
    profile_complete true
  end

  factory :admin_user_with_profile, :parent => :admin_user do
    profile_complete true
  end
end

# Generates the :admin_user factory
User.generate(:admin)
User.generate(:admin, :name => 'Cool Admin')

# Generates the :user_with_profile factory
User.generate(:with_profile)

# Generates the :admin_user_with_profile factory
User.generate(:admin, :with_profile)
User.generate(:admin, :with_profile, :name => 'Custom name')

# User.build and User.attributes also support these custom prefix/suffixes.

# Factories with custom names are supported as well
FactoryBot.define do
  factory :unverified_user, :class => :user do
    verified false
  end
end

# Generates the :unverified_user factory
User.generate(:unverified)
```

### Extend custom classes with FactoryBotExtensions

When you `require "factory_bot_extensions"`, we include custom methods (build/generate/etc) into 
every class by calling:

```ruby
require "factory_bot_extensions/core"

Class.send :include, FactoryBotExtensions
```

If you don't want all of your classes to be polluted with these methods (for example, you only want 
to extend your ActiveRecord::Base classes with these methods), you can simply:

```ruby
# don't require factory_bot_extensions!  require factory_bot_extensions/core instead.
require "factory_bot_extensions/core"

ActiveRecord::Base.send :extend, FactoryBotExtensions
```

## Why User.gen instead of FactoryBot(:user)?

Personally, I really dislike the `FactoryBot(:user)` syntax.  When you have a lot of 
factories, it's hard to see the names of the actual model classes.  I don't like this:

```ruby
FactoryBot(:user).should be_valid
FactoryBot(:name, :string => 'something').should be_awesome
FactoryBot(:comment, :user => Factory(:user)).should be_cool
FactoryBot(:user).should do_some_stuff_with(:things)
```

To me, the thing that draws my attention in that code snippet is `FactoryBot`. 
I don't care about `Factory`, I care about the actual models!  I prefer:

```ruby
User.gen.should be_valid
Name.gen(:string => 'something').should be_awesome
Comment.gen(:user => User.gen).should be_cool
User.gen.should do_some_stuff_with(:things)
```

When you syntax highlight the above code, the constants (model names) are usually 
the things that really jump out at you.  Even in plain text, it's easier to 
understand that code than the above `FactoryBot(:code)` in my opinion.

## Dude, why isn't this stuff included in the official FactoryBot gem as an alternative syntax?

Originally, when I made this, not many people were using this syntax.

Now that I know many people using this syntax, I may send a pull request to FactoryBot to see if they would consider accepting this.

As of factory_bot_extensions 2.0, the code is actually written in the same style as official syntaxes, so it should be very easy to include this into the official FactoryBot gem.

## License

factory_bot_extensions is released under the MIT license.

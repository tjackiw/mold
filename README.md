## Overview ##

Mold is a view template handler for Rails 3+ that renders Ruby objects to JSON.

## Compatibility ##

Mold is compatible with Rails Rails 3.x.

## Installation ##

Install Mold as a gem:

```ruby
gem install mold
```

or add to your Gemfile:
```ruby
gem 'mold'
```

## Usage ##

It's pretty straight-forward to create a Mold JSON template, just create the structure as you would in a Hash:

```ruby
# app/controllers/users_controller.rb
class Users < ActionController:Base
  def show
	  @user = User.first
  end
end

# app/views/users/show.mold
{
	:user => {
		:id   => @user.id,
		:name => @user.name
	}
}
```

You can also create and use view partials in Mold:

```ruby
# app/controllers/users_controller.rb
class Users < ActionController:Base
  def index
	@users = User.all
  end
end

# app/views/users/_user.json.mold
{
	:user => {
		:id   => user.id,
		:name => user.name
	}
}

# app/views/users/index.json.mold
{
	:users => @users.map{ |user| render(:partial => 'user', :object => user) }
}
```

Writing code in a Mold view also works:

```ruby
# app/views/users/show.json.mold
time = Time.now

{
	:user => {
		:time => time
	}
}
```

## Inspiration ##

This gem has been inspired mostly by [ruby\_template_handler](https://github.com/mschuerig/ruby_template_handler).

## Copyright ##

Copyright © 2011 Thiago Jackiw. See [License.txt](https://github.com/tjackiw/mold/License.txt) for details.
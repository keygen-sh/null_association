# null_association

[![CI](https://github.com/keygen-sh/null_association/actions/workflows/test.yml/badge.svg)](https://github.com/keygen-sh/null_association/actions)
[![Gem Version](https://badge.fury.io/rb/null_association.svg)](https://badge.fury.io/rb/null_association)

Use `null_association` to utilize the [null object pattern](https://en.wikipedia.org/wiki/Null_object_pattern)
with Active Record associations.

This gem was extracted from [Keygen](https://keygen.sh).

Sponsored by:

<a href="https://keygen.sh?ref=null_association">
  <div>
    <img src="https://keygen.sh/images/logo-pill.png" width="200" alt="Keygen">
  </div>
</a>

_A fair source software licensing and distribution API._

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'null_association'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install null_association
```

## Usage

To use a null object, define an optional singular association and use the
`null_object:` keyword, which accepts a class, a string, or an instance. When
the association is nil, the null object will be returned instead.

```ruby
class NullPlan
  include Singleton

  def name  = 'Free'
  def free? = true
  def pro?  = false
  def ent?  = false
end
```

```ruby
class NullBilling
  include Singleton

  def subscribed? = true
  def trialing?   = false
  def canceled?   = false
end
```

```ruby
class Account
  belongs_to :plan, optional: true, null_object: NullPlan.instance
  has_one :billing, null_object: NullBilling.instance
end
```

```ruby
account = Account.create(plan: nil)

puts account.plan       # => #<NullPlan name="Free">
puts account.plan.free? # => true
puts account.plan.ent?  # => false

account.update(plan: Plan.new(name: 'Ent', ent: true))

puts account.plan       # => #<Plan id=1 name="Ent">
puts account.plan.free? # => false
puts account.plan.ent?  # => true
```

## Supported Rubies

**`null_association` supports Ruby 3.1 and above.** We encourage you to upgrade
if you're on an older version. Ruby 3 provides a lot of great features, like
better pattern matching and a new shorthand hash syntax.

## Is it any good?

Yes.

## Contributing

If you have an idea, or have discovered a bug, please open an issue or create a
pull request.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

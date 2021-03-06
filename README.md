# Single Table Inheritance (Coba)

## What is Single Table Inheritance?
Single Table Inheritance (STI) is defined as multiple subclasses sharing a single database table. Rails supports STI right out of the box simply by inheriting subclasses from an ActiveRecord parent class which has a type column in its table.

(source: https://medium.com/@User3141592/when-to-use-single-table-inheritance-vs-multiple-table-inheritance-db7e9733ae2e)

Tutorial from: https://www.driftingruby.com/episodes/single-table-inheritance

## Prerequisite

1. Ruby 2.6.3
2. Rails 5.2.4
3. PostgreSQL 11.5

## Migration

Edit the migration like below

**..._create_contacts.rb**
```ruby
class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :type
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :address
      t.string :city
      t.string :state
      t.date :birthday
      t.timestamps
    end
    add_index :contacts, [:type, :user_id]
  end
end
```

## Models

**user.rb**
```ruby
class User < ApplicationRecord
  has_many :emergencies, class_name: 'Emergency'
  has_many :friends, class_name: 'Friend'
end
```

**profile.rb**
```ruby
class Contact < ApplicationRecord
  scope :friends,   -> { where(type: 'Friend') }    # Contact.friends
  scope :emergency, -> { where(type: 'Emergency') } # Contact.emergencies
end
```

**friend.rb***
```ruby
class Friend < Contact
  belongs_to :user
end
```

**emergency.rb**
```ruby
class Emergency < Contact
  belongs_to :user
end
```

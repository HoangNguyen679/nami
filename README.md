# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Versions
Ruby: 3.1.1
Rails: 7.0.3.1
Node: 16.15.0
Postgresql: 14.1

## Model migration

```
rails g model user username:uniq first_name last_name email:uniq is_public:boolean
rails g model bond user_id:bigint friend_id:bigint state
rails g model post user_id:bigint thread_id:bigint postable:references{polymorphic}
rails g model picture post_id:bigint caption
rails g model status text
rails g migration AddPostgisExtensionToDatabase
rails g model place locale coordinate:st_point name place_type
rails g model sight place:references activity_type
```

## Testing

Good test suite
- Fast
- Independent
- Repeatable
- Self-validating
- Timely

```
bundle exec rspec
```

## Seed

```
rails db:seed:replant
```

## Enum

That is the definition in rails not ruby.

## Session and Authentication

### Tailwindcss

```
bundle add tailwindcss-rails
rails tailwindcss:install
```

```
npm install -D postcss-import
```

postcss.config.js
```
module.exports = {
  plugins: {
    "postcss-import": {},
    tailwindcss: {},
    autoprefixer: {},
  },
};

```

### Devise

```
bundle add devise
rails g devise:install
```

```
rails g controller home index
```

```
rails g devise:views
rails g devise user0820170835_add_devise_to_users.rb
rails db:migrate
```

Need to fix [turbo rails 7 problem](https://github.com/heartcombo/devise/issues/5446)

### Forgot password

```
bundle add letter_opener_web
```

[Devise Tut](https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address)
- If using username and email in sign in -> find_for_database_authentication
- If using email in sign in and forget password -> find_first_by_auth_conditions

### Sign out

[Using button_to instead of link_to](https://github.com/heartcombo/devise/issues/4570#issuecomment-740812109)

### Mail Decorate

```
bundle add premailer-rails
```

### Build timeline

```
rails g controller Timelines index show --no-test-framework --no-assets
```

### Active Storage

```
rails active_storage:install
rails db:migrate
```
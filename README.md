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
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

## users テーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

### Association
- has_many :items
- has_many :purchases


## items テーブル
| Column                    | Type       | Options     |
| ------------------------- | ---------- | ----------- |
| title                     | string     | null: false |
| price                     | integer    | null: false |
| category_id               | integer    | null: false |
| condition_id              | integer    | null: false |
| shipping_cost_id          | integer    | null: false |
| shipping_origin_id        | integer    | null: false |
| shipping_date_estimate_id | integer    | null: false |
| user                      | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase


## purchases テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address


## addresses テーブル
| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| postal_code   | string     | null: false |
| prefecture_id | integer    | null: false |
| city          | string     | null: false |
| address_line1 | string     | null: false |
| address_line2 | string     |             |
| phone_number  | string     | null: false |
| purchase      | references | null: false, foreign_key: true |

### Association
- belongs_to :purchase
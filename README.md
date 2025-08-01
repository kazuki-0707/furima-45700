
# テーブル設計

## users テーブル

| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| nickname           | string   | null: false               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| last_name          | string   | null: false               |
| first_name         | string   | null: false               |
| last_name_kana     | string   | null: false               |
| first_name_kana    | string   | null: false               |
| birth_date         | date     | null: false               |


has_many :items, dependent: :destroy
has_many :orders, dependent: :destroy


## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| description        | text       | null: false                    |
| price              | integer    | null: false                    |
| status_id          | integer    | null: false                    |
| category_id        | integer    | null: false                    |
| shipping_fee_id    | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| delivery_day_id    | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

belongs_to :user
has_one :order, dependent: :destroy


## orders テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| user            | references | null: false, foreign_key: true |
| item            | references | null: false, foreign_key: true |

belongs_to :user
belongs_to :item
has_one :address, dependent: :destroy


## addresses テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| post_code        | string     | null: false                    |
| prefecture_id    | integer    | null: false                    |
| city             | string     | null: false                    |
| street_address   | string     | null: false                    |
| building         | string     |                                |
| phone_number     | string     | null: false                    |
| purchase         | references | null: false, foreign_key: true |


belongs_to :order

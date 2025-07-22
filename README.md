
# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| profile            | text   | null: false |


## items テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| name         | string     | null: false |
| description  | text       | null: false |
| price        | integer    | null: false |
| status       | string     | null: false |
| category     | string     | null: false |
| user_id      | references | foreign_key: true |


## purchases テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user_id            | references | null: false, foreign_key: true |
| item_id            | references | null: false, foreign_key: true |
| shipping_post_code | string     | null: false |
| shipping_address   | text       | null: false |
| phone              | string     | null: false |


## addresses テーブル

| Column          | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| purchase_id  | references | null: false, foreign_key: true |
| post_code    | string     | null: false |
| address      | string     | null: false |
| phone_number | string     | null: false |


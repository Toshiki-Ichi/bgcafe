# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| kanji_family       | string  | null: false               |
| kanji_name         | string  | null: false               |
| kata_family        | string  | null: false               |
| kata_name          | string  | null: false               |
| birthday           | date    | null: false               |


### Association

- has_many :items
- has_many :customers


## items テーブル

| Column          | Type        | Options                        |
| --------------- | ----------- | ------------------------------ |
| item_name       | string      | null: false                    |
| note            | text        | null: false                    |
| price           | integer     | null: false                    |
| category_id     | integer     | null: false                    |
| status_id       | integer     | null: false                    |
| responsible_id  | integer     | null: false                    |
| region_id       | integer     | null: false                    |
| shipping_day_id | integer     | null: false                    |
| user            | references  | null: false, foreign_key: true |


### Association

- has_one :customer
- belongs_to :user

## customers テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- has_one :area
- belongs_to :item
- belongs_to :user


## areas テーブル

| Column      | Type        | Options                        |
| ----------- | ----------- | ------------------------------ |
| postal      | string      | null: false                    |
| region_id   | integer     | null: false                    |
| city        | string      | null: false                    |
| city_num    | string      | null: false                    |
| building    | string      |                                |
| tel_num     | string      | null: false                    |
| customer    | references  | null: false, foreign_key: true |

### Association

- belongs_to :customer
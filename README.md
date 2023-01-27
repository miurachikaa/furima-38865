# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| last-name       | string | null: false |
| first-name      | string | null: false |
| last-name-kana  | string | null: false |
| first-name-kana | string | null: false |
| birthday        | date   | null: false |

### Association

- has_many   :items
- has_many   :order

## items テーブル

| Column                   | Type       | Options                        |
| ------------------------ | ---------- | ------------------------------ |
| item-name                | string     | null: false                    |
| item-info                | text       | null: false                    |
| item-category            | references | null: false                    |
| item-sales-status        | references | null: false                    |
| item-shipping-fee-status | references | null: false                    |
| item-prefecture          | references | null: false                    |
| item-scheduled-delivery  | references | null: false                    |
| item-price               | string     | null: false                    |
| user                     | references | null: false, foreign_key: true |
| order                    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :oder

## orders テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |
| order-address | references | null: false, foreign_key: true |



### Association

- has_many   :items
- belongs_to :user
- belongs_to :order-address

## order-addresses テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal-code  | string     | null: false                    |
| prefecture   | integer    | null: false                    |
| city         | string     | null: false                    |
| addresses    | string     |                                |
| building     | string     | null: false                    |
| phone-number | string     | null: false                    |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |
| order        | references | null: false, foreign_key: true |

### Association

- belongs_to :order
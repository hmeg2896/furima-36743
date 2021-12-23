# README



## usersテーブル

| Column               | Type       | Options               |
| -------------------- | ---------- | ----------------------|
| user_name            | string     | null: false           |
| email                | string     | null: false           |
|                      |            | unique: true          |
| encrypted_password   | string     | null: false           |
| last_name            | string     | null: false           |
| first_name           | string     | null: false           |
| last_name_kana       | string     | null: false           |
| first_name_kana      | string     | null: false           |
| birth                | date       | null: false           |

### アソシエーション
has_many :items
has_many :comments
has_many :purchases
has_many :orders



## itemsテーブル

| column                 | Type          | options               |
| ---------------------- | ------------- | ----------------------|
| product                | string        | null: false           |
| product_description    | text          | null: false           |
| category_id            | integer       | null: false           |
| condition_id           | integer       | null: false           |
| postage_id             | integer       | null: false           |
| prefecture_id          | integer       | null: false           |
| region_id              | integer       | null: false           |
| shipping_date_id       | integer       | null: false           |
| price                  | integer       | null: false           |
| user                   | references    | foreign_key: true     |  

### アソシエーション
belongs_to :user
has_many :comments
has_one :purchase
has_many :orders



## commentsテーブル

| column     | Type         | options               |
| ---------- | ------------ | ----------------------|
| text       | text         | null: false           |
| user       | reference    | foreign_key: true     |
| items      | reference    | foreign_key: true     |

### アソシエーション
belongs_to :user
belongs_to :item




## purchasesテーブル

| column                 | Type          | options               |
| ---------------------- | ------------- | ----------------------|
| postal_code            | string        | null: false           |
| prefecture_id          | string        | null: false           |
| city                   | string        | null: false           |
| address                | string        | null: false           |
| building_name          | string        |                       |
| phone_number           | string        | null: false           |
| user                   | references    | foreign_key: true     |  
| order                  | references    | foreign_key: true     |

### アソシエーション
belongs_to :user
belongs_to :order



## ordersテーブル

| column             | Type         | options               |
| -------------------| ------------ | ----------------------|
| purchase_user_id   | string       | null: false           |
| product_id         | string       | null: false           |
| user               | reference    | foreign_key: true     |
| item               | reference    | foreign_key: true     |


### アソシエーション
belongs_to :user
belongs_to :item
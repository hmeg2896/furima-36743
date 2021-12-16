# README



## usersテーブル

| Column               | Type       | Options               |
| -------------------- | ---------- | ----------------------|
| user_name            | string     | null: false           |
| email                | string     | null: false           |
| encrypted_password   | string     | null: false           |
| last_name            | string     | null: false           |
| first_name           | string     | null: false           |
| last_name_kana       | string     | null: false           |
| first_name_kana      | string     | null: false           |
| birth                | date       | null: false           |

### アソシエーション
has_many :items
has_many :comments
has_many :purchase



## itemsテーブル

| column                 | Type          | options               |
| ---------------------- | ------------- | ----------------------|
| image                  | binary        | null: false           |
| product                | string        | null: false           |
| product_description    | text          | null: false           |
| category               | string        | null: false           |
| condition              | string        | null: false           |
| postage                | integer       | null: false           |
| region                 | string        | null: false           |
| shipping_date          | integer       | null: false           |
| price                  | integer       | null: false           |
| user                   | references    | foreign_key: true     |  

### アソシエーション
belongs_to :users
has_many :comments




## commentsテーブル

| column     | Type         | options               |
| ---------- | ------------ | ----------------------|
| text       | text         | null: false           |
| user       | reference    | foreign_key: true     |
| items      | reference    | foreign_key: true     |

### アソシエーション
belongs_to :users
belongs_to :items




## purchaseテーブル

| column                 | Type          | options               |
| ---------------------- | ------------- | ----------------------|
| card_number            | integer       | null: false           |
| exp_month              | integer       | null: false           |
| exp_year               | integer       | null: false           |
| security_code          | integer       | null: false           |
| postal_code            | integer       | null: false           |
| prefecture             | string        | null: false           |
| city                   | string        | null: false           |
| address                | string        | null: false           |
| building_name          | string        | null: false           |
| phone_number           | integer       | null: false
| user                   | references    | foreign_key: true     |  

### アソシエーション
belongs_to :users
# README

## userテーブル

|Column             |Type   |Options                  |
|-------------------|-------|-------------------------|
|nickname           |string |null: false,unique: true |
|encrypted_password |string |null: false              |
|email              |string |null: false              | 
|first_name_kanji   |string |null: false              |
|last_name_kanji    |string |null: false              |
|first_name_kana    |string |null: false              |
|last_name_kana     |string |null: false              |
|birthday           |date   |null: false              |

### Association
has_many :items
has_many :orders

## itemテーブル

|Column            |Type       |Options           |
|------------------|-----------|------------------|
|name              |string     |null: false       |
|explanation       |text       |null: false       |
|price             |integer    |null: false       | 
|category_id       |integer    |null: false       |
|item_status_id    |integer    |null: false       |
|delivery_fee_id   |integer    |null: false       |
|prefecture_id     |integer    |null: false       |
|delivery_days_id  |date       |null: false       |
|user              |references |foreign_key:true  |

### Association
belongs_to :user
has_one :order

## orderテーブル

|Column|Type       |Options           |
|------|-----------|------------------|
|user  |references |foreign_key:true  |
|item  |references |foreign_key:true  |

### Association
belongs_to :user
belongs_to :item
has_one :address

## addressテーブル

|Column           |Type       |Options                  |
|-----------------|-----------|-------------------------|
|post_code        |string     |null: false              |
|prefecture_id    |integer    |null: false              |
|city             |string     |null: false              | 
|block            |string     |null: false              |
|building_name    |string     |                         |
|phone_number     |string     |null: false,unique: true |
|order            |references |foreign_key: true        |

### Association
belongs_to :order

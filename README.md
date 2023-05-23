# README

# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false |ユニーク制約
| encrypted_password | string | null: false |
| name               | string | null: false |
| profile            |  text  | null: false |
| occupation         |  text  | null: false |
| position           |  text  | null: false |

## ユニーク制約
unique: trueを記述
今回だと↓
  t.string :email, null: false, unique: true

### Association

- has_many :prototypes
- has_many :comments


## prototypes テーブル

| Column     |    Type      | Options     |
| ---------- | ------------ | ----------- |
| title      |  string      | null: false |
| catch_copy |  text        | null: false |
| concept    |  text        | null: false |
| user       |  references  | null: false |外部キー

## 外部キー記述
foreign_key: trueを記述する
外部キーがあるからカラムの型はreferences

### Association

- has_many :comments
- belongs_to :user



## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| content   | text       | null: false                    |
| prototype | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :prototype
- belongs_to :user
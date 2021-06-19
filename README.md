# 概要
本APIはアイデアを管理するAPIです。  
カテゴリー名、本文で構成されたアイデアを登録し、登録されたアイデアを取得することが可能です。  
アイデアを取得する場合、カテゴリー名を指定すると該当するアイデアを返し、  
カテゴリー名を指定しなかった場合は登録されている全てのアイデアを返します。  
また、該当しないカテゴリー名を指定した場合は、ステータスコード404を返します。  

## バージョン
本APIはバージョン管理をしています。  
2021年6月19日　Version 1

# 環境
OS: MacOS Big Sur ver.11.2  
フレームワーク: Ruby on Rails ver.6.0.3.7  
使用言語: Ruby ver.2.6.5  
データベース: MySQL ver.5.6.51  
テスト: RSpec ver.3.10  
コード解析ツール: Rubocop ver.1.17.0  
API確認ツール: [Postman](https://web.postman.co/)  
エディタ: VScode ver.1.54.2  

# デモンストレーション
## アイデアを登録する
・アイデアは「カテゴリー名(category_name)」と「本文(body)」を指定できます。  
・「カテゴリー名」と「本文」を入力し、JSON形式でリクエストを送信する(HTTPメソッド：POST)と、アイデアが登録できます。  
・登録できた場合、ステータスコード201を返します。  
・また、メッセージでも登録が完了したことをお知らせいたします。  
[![Image from Gyazo](https://i.gyazo.com/4b0ac65b86f9a404909f2d78f74fdc13.gif)](https://gyazo.com/4b0ac65b86f9a404909f2d78f74fdc13)

リクエスト形式  
```JSON
{
  "category_name": "test",
  "body": "これはテスト用のアイデアです。"
}
```

・「カテゴリー名」と「本文」いずれかが空欄ではアイデアは登録できません。  
・アイデアの登録に失敗した場合はステータスコード422, バリデーションエラーを返します。  
### カテゴリー名が空欄でリクエストを送信した場合
[![Image from Gyazo](https://i.gyazo.com/3af888601e9b06aa72f331dbd892dac1.gif)](https://gyazo.com/3af888601e9b06aa72f331dbd892dac1)

### 本文が空欄でリクエストを送信した場合
[![Image from Gyazo](https://i.gyazo.com/1cae6fe46b0b7fc2e198cfd613ce7f97.gif)](https://gyazo.com/1cae6fe46b0b7fc2e198cfd613ce7f97)

## アイデアを取得する
・「カテゴリー名」を指定することで、該当するアイデアを取得することができます。(HTTPメソッド：GET)  
[![Image from Gyazo](https://i.gyazo.com/0edfd53a988b9eb0a830d89a2d6bab5a.gif)](https://gyazo.com/0edfd53a988b9eb0a830d89a2d6bab5a)

リクエスト形式  
```JSON
{
  "category_name": "test"
}
```

・「カテゴリー名」を指定せずにリクエストを送信した場合は、全てのアイデアを返します。  
・また、返却するアイデアの構成は「アイデアのID(id)」「カテゴリー名(category_name)」「アイデアの本文(body)」で構成されています。  
[![Image from Gyazo](https://i.gyazo.com/5a78e478a1cbe9b699e615b598c663ea.gif)](https://gyazo.com/5a78e478a1cbe9b699e615b598c663ea)

### アイデアが取得できない場合
・登録されていない「カテゴリー名」を指定してリクエストを送信した場合は、ステータスコード404を返します。  
・また、メッセージで「お探しのカテゴリー名に該当するアイデアは見つかりませんでした。」とお知らせいたします。  
[![Image from Gyazo](https://i.gyazo.com/614766476a2af0ee6183f95db2458ce7.gif)](https://gyazo.com/614766476a2af0ee6183f95db2458ce7)


# テーブル設計
## ER図
[![Image from Gyazo](https://i.gyazo.com/ca3d5d772b4bed16dae7c589c33eb18f.png)](https://gyazo.com/ca3d5d772b4bed16dae7c589c33eb18f)

## categoriesテーブル
| Column | Type       | Options                   |
| name   | string     | null: false, unique: true |

### Association
- has_many :ideas

## ideasテーブル
| Column   | Type       | Options                        |
| category | references | null: false, foreign_key: true |
| body     | text       | null: false                    |

### Association
- belongs_to :category
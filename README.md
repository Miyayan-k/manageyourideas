# 概要
本APIはアイデアを管理するAPIです。
カテゴリー名、本文で構成されたアイデアを登録し、登録されたアイデアを取得することが可能です。
アイデアを取得する場合、カテゴリー名を指定すると該当するアイデアを返し、
カテゴリー名を指定しなかった場合は登録されている全てのアイデアを返します。
また、該当しないカテゴリー名を指定した場合は、ステータスコード404を返します。

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
・アイデアは「カテゴリー名(vategory_name)」と「本文(body)」を指定できます。
・「カテゴリー名」と「本文」を入力し、JSON形式でリクエストを送信すると、アイデアが登録できます。
・登録できた場合、ステータスコード201を返します。
・また、メッセージでも登録が完了したことをお知らせいたします。
[![Image from Gyazo](https://i.gyazo.com/4b0ac65b86f9a404909f2d78f74fdc13.gif)](https://gyazo.com/4b0ac65b86f9a404909f2d78f74fdc13)

・「カテゴリー名」と「本文」いずれかが空欄ではアイデアは登録できません。
・アイデアの登録に失敗した場合はステータスコード422, バリデーションエラーを返します。
### カテゴリー名が空欄でリクエストを送信した場合
[![Image from Gyazo](https://i.gyazo.com/3af888601e9b06aa72f331dbd892dac1.gif)](https://gyazo.com/3af888601e9b06aa72f331dbd892dac1)

### 本文が空欄でリクエストを送信した場合
[![Image from Gyazo](https://i.gyazo.com/1cae6fe46b0b7fc2e198cfd613ce7f97.gif)](https://gyazo.com/1cae6fe46b0b7fc2e198cfd613ce7f97)



# テーブル設計
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
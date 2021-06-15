# テーブル設計
## categoriesテーブル
| Column | Type       | Options                   |
| name   | string     | null: false, unique: true |

### Association

## ideasテーブル
| Column      | Type   | Options                        |
| category_id | bigint | null: false, foreign_key: true |
| body        | text   | null: false                    |

### Association
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
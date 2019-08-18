Userモデル

| カラム名 | データ型 |
| :----- | :---- |
|  name  |  string  |
|  email  |  string  |
| password_digest | string |


 Taskモデル


| カラム名 | データ型 |
| :----- | :----- |
| task_name | string |
| task_body | text |
| task_limit | datetime |
| task_status | string |
| task_priority | string |
| user_id|integer |

Labelモデル

| カラム名 | データ型 |
| :--- | :--- |
| label_name | string |


Labellingモデル


| カラム名 | データ型 |
| :--- | :--- |
| task_id | integer |
| label_id | integer |

開発環境
------------
Ruby 2.6.3  
Ruby on Rails 5.2.3  
PostgreSQL 11.4  

デプロイ手順
------------
1.heroku create（最初だけ）  
2.rails assets:precompile RAILS_ENV=production  
3.git add -A(またはファイル名)  
4.git commit -m "コミットメッセージ"  
5.git push heroku master  
6.heroku run rails db:migrate

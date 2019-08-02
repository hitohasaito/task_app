Userモデル

| カラム名 | データ型 |
| :----- | :----- |
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

 abellingモデル

| カラム名 | データ型 |
| :--- | :--- |
| task_id | integer |
| label_id | integer |

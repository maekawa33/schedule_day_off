![ロゴ](app/assets/images/logo_index.png)  
サービスURL: https://www.schedule-day-off.com

## **サービス概要**  
---    
休日スケジュールを投稿・共有するサービスです。 様々な価値観を持った人の休日を知ることで、より充実した休日を過ごすためのヒントを得ることができます。
<br>
<br>

## **メインのターゲット**  
---  
* 休日の過ごし方をおすすめしたい方  
* 休日の過ごし方に満足していない方  

<details>
<summary>ユーザーが抱える課題</summary>

* 休日をもっと充実させたい  
* Twitter上での交流を増やしたい 
</details>  
<details>
<summary>解決方法</summary>

* 様々な価値観を持った人の一番おすすめの休日スケジュールを共有することで、より休日を充実させるヒントを得ることができる。 
* Twitterと連携することで、交流のきっかけになる。  
</details>
<br>
<br>

## **主な機能**  
---  
### 未ログインユーザー    
* スケジュールの検索、一覧、詳細  
* ユーザーの詳細  
### ログインユーザー  
* スケジュールの投稿、検索、一覧、詳細、編集  
* ユーザーの編集、詳細  
### 管理ユーザー  
* 全スケジュールの投稿、検索、一覧、詳細、編集、削除  
* 全ユーザーの編集、詳細、削除
<br>
<br>

## **なぜこのサービスを作りたいのか？**  
---  
休日をダラダラと過ごしていて、もったいないと考えたのがきっかけ。他人の休日の過ごし方を知ることで自分の休日をより充実させるヒントを得ることができると考えました。
<br>
<br>

## **画面遷移図**  
---  
figma: (https://www.figma.com/file/cbWV6ra9ZXM4xS8Fsul06u/schedule-day-off?node-id=0%3A1&t=8jeIEBlmQrI2vLO6-1)
<br>
<br>

## **ER図**  
---  
```mermaid
erDiagram
  users ||--o{ schedules : ""
  users ||--o{ favorites : ""
  users ||--o{ tries : ""
  schedules ||--o{ events : ""
  schedules ||--o{ favorites : ""
  schedules ||--o{ tries : ""
  schedules ||--o{ taggings : ""
  tags ||--o{ taggings : ""
  events {
  integer id PK
  bigint schedule_id FK
  time start_time
  time end_time
  string event_time
  string image
  string price
  string comment
  datetime created_at
  datetime update_at
  }
  favorites {
  integer id PK
  bigint user_id FK
  bigint schedule_id FK
  datetime created_at
  datetime updated_at
  }
  schedules {
  integer id PK
  bigint user_id FK
  string schedule_title
  integer assumed_number_people
  time get_up_time
  time sleep_time
  datetime created_at
  datetime updated_at
  }
  taggings {
  integer id PK
  bigint schedule_id FK
  bigint tag_id FK
  datetime created_at
  datetime updated_at
  }
  tags {
  integer id PK
  string name
  datetime created_at
  datetime updated_at
  }
  tries {
  integer id PK
  bigint user_id FK
  bigint schedule_id FK
  datetime created_at
  datetime updated_at
  }
  users {
  integer id PK
  string name
  string email
  string crypted_password
  string salt
  string avatar
  integer role
  integer login_type
  string reset_password_token
  datetime reset_password_token_expires_at
  datetime reset_password_email_sent_at
  integer access_count_to_reset_password_page
  datetime created_at
  datetime updated_at
  }
```
<br>
<br>

## **使用技術**  
---  
### バックエンド  
* Ruby 3.1.0  
* Rails 7.0.4  
### フロントエンド  
* hotwire  
* TailwindCSS-daisyUI  
### インフラ  
* Heroku  
* AmazonS3  
* PostgreSQL
<br>
<br>

## **スケジュール**  
---  
企画〜技術調査：12/1〆切  
README~ER図作成：12/15〆切  
メイン機能実装：12/15-1/31〆切  
β版をRUNTEQ内リリース(MVP)：1/31〆切  
本番リリース：2/15〆切  
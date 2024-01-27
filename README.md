# はじめに
テントサウナのレンタルサービス(作成途中)

エンドユーザー向け機能のほかに、管理者画面にて運営スタッフが商品や顧客の管理が可能となっております。

以下のdockerを利用して作成しております。
https://github.com/nickjj/docker-rails-example

## 技術スタック

### 言語、フレームワーク
- Ruby
- Ruby on Rails
- TailWind CSS

### データベース
- PostgreSQL
- Redis

### 決済機能
- [Stripe](https://stripe.com/docs/api)
stripe webhook を用いて決済ページを実装

### コード 品質管理
- Rubocop

### 非同期処理
- Sidekiq

### メール送信機能
- Action Mailer

### アイコン
- [Google icons](https://fonts.google.com/icons)
- [Heroicons](https://heroicons.com/)

## 動かし方
注文するには、StripeのCLIをdocker上で立ち上げる必要があります。
（dockerfile でアクセス等を記載しておけば必要なし。）

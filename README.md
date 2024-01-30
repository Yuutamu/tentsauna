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
 決済ページもstripe webhook を用いて実装

### コード 品質管理
- Rubocop

### 非同期処理
- Sidekiq
顧客への注文確認メールの送信を非同期にて処理しています。
ちなみに、Sidekiq を採用している利用は、他よりも有名かつ、1個のプロセスで動作させられるのでメモリ使用量が少なく経済的なので。

### メール送信機能
- Action Mailer

### アイコン
- [Google icons](https://fonts.google.com/icons)
- [Heroicons](https://heroicons.com/)

## 動かし方
注文するには、StripeのCLIをdocker上で立ち上げる必要があります。
（dockerfile でアクセス等を記載しておけば必要なし。）

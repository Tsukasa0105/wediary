
# Wediary
仲間との旅行などの記録を、「いつ」、「どこで」、「だれと」、「なにを」したか記録できるアプリです。



具体的には以下のことができます。

* 仲間とのグループを作り、複数のイベントを記録
* イベントは、カレンダーにより日付管理、Google Mapにより地点管理がされる
* イベント前のアイデア集約、旅行中の精算記録も一括管理

# 使用技術

* Ruby 2.5.3
* Ruby on Rails 5.2.2
* MySQL 5.5
* Puma
* AWS
* Docker/Docker-compose
* CircleCi CI/CD
* Rspec
* Google Map API
* Heroku
* Cloudinary

# 機能一覧

* ユーザ登録、ログイン機能
* フォロー機能
* グループ機能
* 投稿機能
    * 画像複数投稿（CarrierWave）
    * 位置紐づけ（Google Map API）
    * カレンダー機能（Simple Calender）
    * URL投稿機能（Rinku）
* お気に入り機能
* 検索機能
* ソート、フィルター機能

# テスト

* Rspec
    * 単体テスト（Model）
    * 機能テスト（Request）
    * 統合テスト（Feature）
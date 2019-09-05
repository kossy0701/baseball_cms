# README

## アプリ概要

簡易的なCMSを作成してみました。

## 言語・環境

- Ruby 2.5.1
- Rails 5.2.3
- jQuery
- JavaScript
- Mysql 5.7
- AWS S3
- Production: AWS EC2(お金かかるからやめた)
- Beta: Heroku
- Route 53(お金かかるからやm)
- unicorn
- nginx
- capistrano

## デモ
[demo](https://github.com/kossy0701/baseball_cms/blob/demo/demo.gif)

## 実装機能
- ログイン・ログアウト機能(bcrypt)
- メンバー・ニュース・ブログ投稿(CRUD)機能
- 投票(いいね)機能
- 複数画像アップロード機能(Active_storage)
- 画像並べ替え機能(act_as_list)
- コメント機能
- メンバー検索機能(FormObject)
- ニュース検索機能(FormObject)
- 管理者機能(namespace)
- アクティビティロギング機能
- CSV出力機能(メンバー、アクティビティログ)
- remote: trueを用いた非同期通信機能(js.erb)
- 画像アップロード時のプレビュー表示機能(jQuery)
- wheneverを用いたcron定期実行機能
- [スプレッドシートへの定期出力機能](https://docs.google.com/spreadsheets/d/1L4a7lh1z-90pidXZXCFOTSkrAA9ShjLeh_8ANqBWP_w)

## テスト・継続的インテグレーション
- Rspec(models, requests, systems, decorators)
- CircleCI
- dependabot(依存パッケージを更新するサービス)[HP](https://dependabot.com/)
- rollbar(エラー通知サービス、今は使ってない)[HP](https://rollbar.com)

## 工夫した点
- FatModelを避けるためにdraperを採用し、モデルに書きがちなビューのロジックを集約
- 検索機能はActiveModelで実装
- CSV出力機能の実装
- 後々ユーザー区分を追加する可能性を考え、ActivityLogモデルはポリモーフィック関連を採用
- Commentモデルは今後の機能拡張で様々なモデルと紐づく可能性を考え、STIを採用

## 苦労した点
- capistranoでの自動デプロイの際にunicorn startでつまづき丸2日費やす。原因はmaster.keyをuploadする処理をしていなかった。
- form_withの扱いに慣れておらず、modelオプションやurlオプションの使い分けで少し苦労した。

## DB設計

### membersテーブル
|Column|Type|Options|
|------|------|-----|
|number|integer|null: false|
|name|string|null: false, index: true|
|full_name|string|index: true|
|email|string||
|birthday|date||
|sex|integer|null: false|
|administorator|boolean|null: false|
|password_digest|string||
|prefecture_id|integer|null: false|

- association

```
belongs_to_active_hash :prefecture
has_many :entries, dependent: :destroy
has_many :votes, dependent: :destroy
has_many :voted_entries, through: :votes, source: :entry
has_many :activity_logs, as: :performer, dependent: :destroy
has_many :comments, as: :commenter, dependent: :destroy
```

### activity_logsテーブル
|Column|Type|Options|
|------|------|-----|
|log_type|integer|null: false, index: true|
|performer_type|string|null: false, polymophic: true, index: true|
|performer_id|bigint|null: false, polymophic: true, index: true|
|performed_at|datetime|null: false, index: true|
|performed_title|string|null: false, index: true|

- association

```
belongs_to :performer, polymorphic: true
```

### articlesテーブル
|Column|Type|Options|
|------|------|-----|
|title|string|null: false, index: true|
|body|text|null: false|
|released_at|datetime|null: false, index: true|
|expired_at|datetime||
|member_only|boolean|default: false, null: false|

- association

```
has_many :article_comments, dependent: :destroy
```

### commentsテーブル
|Column|Type|Options|
|------|------|-----|
|commenter_id|bigint|null: false, polymorphic: true, index: true|
|commenter_type|string|null: false, polymorphic: true, index: true|
|article_id|bigint|optional: true, index: true|
|entry_id|bigint|optional: true, index: true|
|type|string|null: false, single_table_inheritance, index: true|
|body|string|null: false|

- association

```
belongs_to :commenter, polymorphic: true
belongs_to :article, optional: true
belongs_to :entry, optional: true

```

### entriesテーブル
|Column|Type|Options|
|------|------|-----|
|member_id|bigint|null: false, index: true, foreign_key: true|
|title|string|null: false, index: true|
|text|body||
|posted_at|datetime|null: false|
|status|string|default: 'draft', null: false, index: true|

- association

```
belongs_to :author, class_name: 'Member', foreign_key: 'member_id'
has_many :images, class_name: 'EntryImage'
has_many :votes, dependent: :destroy
has_many :voters, through: :votes, source: :member
has_many :entry_comments, dependent: :destroy
```

### entry_imagesテーブル
|Column|Type|Options|
|------|------|-----|
|entry_id|bigint|null: false, index: true|
|alt_text|string|default: '', null: false|
|position|integer|index: true|

- association

```
belongs_to :entry
```

### votesテーブル
|column|Type|Options|
|------|------|-----|
|entry_id|bigint|null: false, index: true|
|member_id|bigint|null: false, index: true|

- association

```
belongs_to :entry
belongs_to :member

```

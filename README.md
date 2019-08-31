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

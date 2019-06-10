# README

## アプリ概要

簡易的なCMSを作成してみました。


## 言語・環境

- Ruby 2.5.1
- Rails 5.2.3
- jQuery
- JavaScript
- Mysql5.7
- AWS S3
- Production: AWS EC2
- Beta: Heroku
- Route53


## URL
[Baseball CMS](http://www.baseball-cms.com)


### 管理者ユーザーログイン
- name: Taro
- password: 12345678

## デモ
[demo](https://github.com/kossy0701/baseball_cms/blob/demo/demo.gif)

## 実装機能
- サインイン・アップ機能
- メンバー・ニュース・ブログ投稿(CRUD)機能
- 投票(いいね)機能
- 画像アップロード機能
- コメント機能
- メンバー検索機能
- ニュース検索機能
- 管理者機能(namespace)
- アクティビティロギング機能
- remote: trueを用いた非同期通信機能

## テスト・継続的インテグレーション
- Rspec(models, systems, decorators)
- CircleCI

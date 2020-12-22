
# アプリ名 : SHOP_NOTE_APP
![alt](https://user-images.githubusercontent.com/60740632/102938844-69a20e00-44f0-11eb-9839-b8483b80f3d2.png)


### URL

[ポートフォリオサイトへ移動](http://18.177.6.24/)


### テストアカウント

最初に出てくる画面の「ゲストログイン」をクリックすると、ゲストユーザーとしてログインし、全ての機能をお使い頂けます。

## 概要
このアプリは、グループチャット型の買い物メモです。  
買い物メモを投稿して購入したら削除する、といった根幹の機能は既存のネイティブアプリと一緒ですが、  
その他に以下のような特徴があります。    

・グループを作成しメンバーを招待することで、家族やサークルといったグループで買い物メモの共有が出来る  
個人スペースと各グループチャットスペースが分かれているため、メモを分けて管理出来ます。  
 (買い物はもちろん、簡単なToDoアプリとしてもお使い頂けます)
 
・画像投稿機能、投稿に対するコメント/数量指定機能で細かい内容まで伝達出来る

・リピート買いする商品を予め登録出来るお気に入り商品機能を実装  
登録しておくと専用ページにてチェックを入れるだけで一括投稿を行うことが出来る  

・WEBアプリで作成しているためスマホやタブレット、PCといった様々なデバイスで閲覧出来る



## 作成経緯
私の家庭が共働きでひとり買い物に行くことが多いため、買うものを家族間でシェアし、円滑に買い物出来るアプリがあれば便利だと考えたからです。  
ネイティブアプリで既存のものもありますが、  
①使える機種が限られていること(iphoneとAndroid両方に対応していない等)  
②機能面の充実(画像で買うものを伝えられたら...投稿に対してコメントを加えられたら...等)
以上の観点から作成することを決定しました。

## 使用技術
- フロントエンド
  - HTML/CSS/Sass/bootstrap4
 
- バックエンド
  - Rails v5.1.7
  - Ruby v2.7.0
  - RSpec v3.10
  
- インフラ
  - AWS (VPC,EC2,RDS)
  (S3,route53,ALBについては今後実装予定)
  - mysql v5.7.32
  - unicorn v5.7.0
  - nginx v1.12.2
- その他使用ツール
  - テキストエディタ: Atom
  - ER図作成ツール: draw.io

## 機能一覧
- ユーザー登録関連(devise使用)
  - 新規登録、プロフィール編集機能
  - ログイン、ログアウト機能
  - 簡単ログイン機能(ゲストユーザーログイン)

- 買い物メモ投稿機能
  - メモの投稿、削除機能(ajax使用)
  - 画像投稿機能(cariierwave使用)
  - 買い物メモに対する数量指定機能
  - 買い物メモに対するコメント機能

- グループ関連機能
  - グループの作成、編集、削除機能
  - グループへのユーザー招待機能
  - グループチャット機能
  - お気に入り商品の登録/投稿機能  
  
- ユーザー検索機能

- アプリのチュートリアル機能  
新規登録者に操作方法を体感して頂けるよう、主要機能を中心に実装しました。  
(新規登録の時のみで、ログイン/ゲストログインの際には表示されません)
  
- アプリのレビュー投稿機能  
アプリに訪問して頂いた方に使用感のレビューを頂けるよう実装しました。

- 画像アップロード機能
  - 開発環境:carrierwave
  - 本番環境:S3を使用予定。今後実装していきます。
  
- 画像プレビュー機能  
投稿した画像をクリックすることで画面全体に表示されるよう実装しました。

- レスポンシブwebデザイン(bootstrap4使用)  
各デバイスで見やすくなるよう現在追加実装中です。

- PFのテスト機能(Rspec使用)

## DB設計

### ER図

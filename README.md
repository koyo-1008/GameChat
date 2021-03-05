__✅ポートフォリオ名　GameChat__

オンラインゲーム初心者向けの交流を目的にしたチャットサービスです。 

ゲームタイトルの中に複数のchannelがあり、ユーザー自身でchannelを作成しそのchannle中でチャットをすることができます。 

GameChat　URL→　<http://18.177.86.54/>  

ゲストユーザーID&パスワード

Email→　『testuser1@hoge.co.jp』

password→ 『koyo1008』

よろしければこちらでログインしてください


参考画像　　

<img width="1680" alt="スクリーンショット 2021-03-04 23 52 09" src="https://user-images.githubusercontent.com/58773090/109981979-cae22b00-7d44-11eb-96b1-6071b5231db5.png">


--------------------------------------

__✅機能一覧__

・ユーザー登録機能(devise）

・ログイン機能(device）

・コメント投稿機能

・画像投稿機能

・channel作成機能

--------------------------------------

__✅DB設計__

## usersテーブル


|Column|Type|Options|
|------|----|-------|
|name|string|default: "",null:false|
|nickname|string|null:false|
|email|string|default: "",null:false,unique: true|
|name|string|null:false|
|encrypted_password|string|default: "",null:false|
|reset_password_token|string|unique: true|


## groupsテーブル


|Column|Type|Options|
|------|----|-------|
|name|string|default: "", null: false|

### Association

has_many :channels

## group_usersテーブル


|Column|Type|Options|
|------|----|-------|
|user_id|integer| null: false|
|group_id|integer| null: false|


## commentsテーブル


|Column|Type|Options|
|------|----|-------|
|user_id|integer| null: false|
|channle_id|integer| null: false|
|content|text|-------|

### Association

belongs_to :user
belongs_to :channel

## channlesテーブル


|Column|Type|Options|
|------|----|-------|
|name|string| default: "",null: false|
|group_id|integer| null: false|

### Association

belongs_to :group
has_many :comments

--------------------------------------

__✅このアプリケーションを作成したきっかけ__

自分自身オンラインゲームが大好きで、小学６年生の頃からずっとハマっていました。  
しかし、周りに一緒にやってくれる友人がおらず、ゲームによってはゲーム内でチャットができる機能がなかったり、とてもチャットしにくかったりといったことがあり、どうやって交流を深めて良いか悩んでいました。  
Twitter等で交流を深めれば良いと思っていましたが、Twitterのハッシュタグ　→＃（これのことです）　でフレンド募集等の検索しても一文字違うだけでヒットしなかったことがありとても不便だと感じました。    
また、最初はTwitterに慣れていないといった理由でゲームを一緒に遊べる人を探すのは困難を極めました。  
そういった経験から、オンラインゲームで友人がいなくて交流する機会が欲しいという人のために、オンラインゲーム専用の交流が簡単にできるアプリケーションを作成しました。  

--------------------------------------

__✅使用技術__

・Ruby　2.5.1

・Ruby on Rails  6.0.3.4

・Vue.js

・Bootstrap4

・HTML

・CSS

・MySQL　5.6.47

・Webpack

・RSpec

・AWS

・S3

・Capistrano　3.15.0

・unicorn　5.5.4

・Active Storage

・device

--------------------------------------

__✅特に見ていただきたい点__

・RailsアプリケーションにJavaScriptフレームワークであるVue.jsを導入している点

・Vue.jsを使って非同期でチャットができる点

・コンポーネント化されており、コードが見やすい点

・アプリケーションのUIが直感的で操作しやすくしている点

--------------------------------------





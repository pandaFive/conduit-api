# 概要

RealWorldプロジェクトのバックエンドAPIをRailsのapiモードで実装した。

## 目次

- [目次](#目次)
- [要件](#要件)
  - [ステップ1](#ステップ1)
  - [ステップ2](#ステップ2)
    - [2-1](#2-1)
    - [2-2](#2-2)
    - [2-3](#2-3)
    - [2-4](#2-4)
    - [2-5 (advanced)](#2-5-advanced)
- [実装](#実装)
  - [エンドポイント](#エンドポイント)
  - [ユーザー登録](#ユーザー登録)
  - [ログイン](#ログイン)
  - [カレントユーザーの取得](#カレントユーザーの取得)
  - [カレントユーザーの編集](#カレントユーザーの編集)
  - [アーティクルの作成](#アーティクルの作成)
  - [アーティクルのリストを取得する](#アーティクルのリストを取得する)
  - [アーティクルを取得する](#アーティクルを取得する)
  - [アーティクルの編集](#アーティクルの編集)
  - [アーティクルの削除](#アーティクルの削除)
  - [アーティクルのお気に入り登録](#アーティクルのお気に入り登録)
  - [アーティクルのお気に入り解除](#アーティクルのお気に入り解除)
- [デプロイ](#デプロイ)
  - [デプロイ先](#デプロイ先)
  - [インフラ構成図](#インフラ構成図)

## 要件

### RealWorld

ブログプラットフォームを作る [RealWorld](https://github.com/gothinkster/realworld/tree/main) という OSS のプロジェクトがあります。RealWorld は実世界と同じ機能を持つプラットフォームを作ることで、学習したいフレームワークの技術を習得することを目的としてたプロジェクトです。

ここでは、[RealWorld の バックエンドの API](https://realworld-docs.netlify.app/docs/specs/backend-specs/introduction) の仕様を満たす Rails API を作成します。

ステップ1とステップ2に分かれます。時間に余裕がない場合はステップ1に進んでください。時間に余裕がある場合はステップ2に進んでください。ステップ1を終えてからステップ2に進む設計にはなっていないため、最初にどちらに進むかを選択してください。

ステップ1は RealWorld の API の仕様を部分的に満たした API を作成します。具体的には、認証機能のない簡易バージョンの作成になります。

ステップ2は RealWorld の API の仕様を満たす API を作成します。認証機能付きのバージョンの作成になります。

基本的にはステップ2を進めていくことを想定していますが、時間に余裕がない場合はステップ1を進めてください。

[RealWorld のドキュメント](https://realworld-docs.netlify.app/docs/intro) に目を通した上で、ステップに進んでください。

#### ステップ1

RealWorld の API のうち、次のエンドポイントを実装してください。

- [Create Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#create-article)
- [Get Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#get-article)
- [Update Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#update-article)
- [Delete Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#delete-article)

なお、Article に関わる要素のうち、認証機能及び著者、お気に入り(`favorite`) は実装しなくてよいものとします。

#### ステップ2

##### 2-1

RealWorld の API のうち、次のエンドポイントを実装してください。

- [Registration](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#registration)

その際に、[API spec](https://github.com/gothinkster/realworld/tree/main/api) と呼ばれている [Postman のテスト(Conduit.postman_collection.json)](https://github.com/gothinkster/realworld/blob/main/api/Conduit.postman_collection.json)の該当する箇所が通るように実装してください(該当箇所以外のテストは削除するとテストしやすいです)。

##### 2-2

次のエンドポイントを実装してください。

- [Authentication](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#authentication)

その際に、Postman のテストの該当する箇所が通るように実装してください。

##### 2-3

次のエンドポイントを実装してください。

- [Create Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#create-article)
- [Get Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#get-article)
- [Update Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#update-article)
- [Delete Article](https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints#delete-article)

その際に、Postman のテストの該当する箇所が通るように実装してください。

なお、Article に関わる要素のうち、お気に入り(`favorite`) は実装しなくてよいものとします。Postman のテストからも該当箇所のコードは削除し除外してください。

##### 2-4

いずれかのエンドポイントのテストを1つ書いてください。

##### 2-5 (advanced)

お気に入り(`favorite`)も実装してください。

## 実装

### エンドポイント

```
post   /api/users
post   /api/users/login
get    /api/user
put    /api/user
post   /api/articles
get    /api/articles
get    /api/articles/:slug
put    /api/articles/:slug
delete /api/articles/:slug
post   /api/articles/:slug/favorite
delete /api/articles/:slug/favorite
```

### ユーザー登録

```
post http://localhost:3000/api/users
```

#### リクエストボディ

```json
{
  "user":{
    "username": "Jacob",
    "email": "jake@jake.jake",
    "password": "jakejake"
  }
}
```

#### レスポンス

```json
{
  "user": {
    "email": "jake@jake.jake",
    "token": "jwt.token.here",
    "username": "jake",
    "bio": "I work at statefarm",
    "image": null
  }
}
```

### ログイン

```
post http://localhost:3000/api/users/login
```

#### リクエストボディ

```json
{
  "user":{
    "email": "jake@jake.jake",
    "password": "jakejake"
  }
}
```

#### レスポンス

```json
{
  "user": {
    "email": "jake@jake.jake",
    "token": "jwt.token.here",
    "username": "jake",
    "bio": "I work at statefarm",
    "image": null
  }
}
```

### カレントユーザーの取得

```
get http://localhost:3000/api/user
```

#### リクエスボディ
```json
nil
```

#### レスポンス
```json
{
  "user": {
    "email": "jake@jake.jake",
    "token": "jwt.token.here",
    "username": "jake",
    "bio": "I work at statefarm",
    "image": null
  }
}
```

### カレントユーザーの編集

```
put http://localhost:3000/api/user
```

#### リクエストボディ
```json
{
  "user":{
    "email": "jake@jake.jake",
    "bio": "I like to skateboard",
    "image": "https://i.stack.imgur.com/xHWG8.jpg"
  }
}
```

#### レスポンス
```json
{
  "user": {
    "email": "jake@jake.jake",
    "token": "jwt.token.here",
    "username": "jake",
    "bio": "I like to skateboard",
    "image": "https://i.stack.imgur.com/xHWG8.jpg"
  }
}
```

### アーティクルの作成

```
post http://localhost:3000/api/articles
```

#### リクエストボディ
```json
{
  "article": {
    "title": "How to train your dragon",
    "description": "Ever wonder how?",
    "body": "You have to believe",
    "tagList": ["reactjs", "angularjs", "dragons"]
  }
}
```

#### レスポンス
```json
{
  "article": {
    "slug": "how-to-train-your-dragon",
    "title": "How to train your dragon",
    "description": "Ever wonder how?",
    "body": "It takes a Jacobian",
    "tagList": ["dragons", "training"],
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z",
    "favorited": false,
    "favoritesCount": 0,
    "author": {
      "username": "jake",
      "bio": "I work at statefarm",
      "image": "https://i.stack.imgur.com/xHWG8.jpg",
      "following": false
    }
  }
}
```

### アーティクルのリストを取得する

```
get http://localhost:3000/api/articles
```

#### クエリパラメータ
`tag`, `author`, `favorited`, `limit` and `offset`

url例
```
get http://localhost:3000/api/articles?author=jake
```

#### レスポンス

```json
{
  "articles":[{
    "slug": "how-to-train-your-dragon",
    "title": "How to train your dragon",
    "description": "Ever wonder how?",
    "body": "It takes a Jacobian",
    "tagList": ["dragons", "training"],
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z",
    "favorited": false,
    "favoritesCount": 0,
    "author": {
      "username": "jake",
      "bio": "I work at statefarm",
      "image": "https://i.stack.imgur.com/xHWG8.jpg",
      "following": false
    }
  }, {
    "slug": "how-to-train-your-dragon-2",
    "title": "How to train your dragon 2",
    "description": "So toothless",
    "body": "It a dragon",
    "tagList": ["dragons", "training"],
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z",
    "favorited": false,
    "favoritesCount": 0,
    "author": {
      "username": "jake",
      "bio": "I work at statefarm",
      "image": "https://i.stack.imgur.com/xHWG8.jpg",
      "following": false
    }
  }],
  "articlesCount": 2
}
```

### アーティクルを取得する

```
get http://localhost:3000/api/articles/:slug
```

#### レスポンス
```json
{
  "article": {
    "slug": "how-to-train-your-dragon",
    "title": "How to train your dragon",
    "description": "Ever wonder how?",
    "body": "It takes a Jacobian",
    "tagList": ["dragons", "training"],
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z",
    "favorited": false,
    "favoritesCount": 0,
    "author": {
      "username": "jake",
      "bio": "I work at statefarm",
      "image": "https://i.stack.imgur.com/xHWG8.jpg",
      "following": false
    }
  }
}
```

### アーティクルの編集

```
put http://localhost:3000/api/articles/:slug
```

#### リクエストボディ
```json
{
  "article": {
    "title": "Did you train your dragon?"
  }
}
```

#### レスポンス

```json
{
  "article": {
    "slug": "how-to-train-your-dragon",
    "title": "How to train your dragon",
    "description": "Ever wonder how?",
    "body": "It takes a Jacobian",
    "tagList": ["dragons", "training"],
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z",
    "favorited": false,
    "favoritesCount": 0,
    "author": {
      "username": "jake",
      "bio": "I work at statefarm",
      "image": "https://i.stack.imgur.com/xHWG8.jpg",
      "following": false
    }
  }
}
```

### アーティクルの削除

```
delete http://localhost:3000/api/articles/:slug
```

#### レスポンス

レスポンスなし

### アーティクルのお気に入り登録

```
post http://localhost:3000/api/articles/:slug/favorite
```

#### レスポンス

```json
{
  "article": {
    "slug": "how-to-train-your-dragon",
    "title": "How to train your dragon",
    "description": "Ever wonder how?",
    "body": "It takes a Jacobian",
    "tagList": ["dragons", "training"],
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z",
    "favorited": false,
    "favoritesCount": 0,
    "author": {
      "username": "jake",
      "bio": "I work at statefarm",
      "image": "https://i.stack.imgur.com/xHWG8.jpg",
      "following": false
    }
  }
}
```

### アーティクルのお気に入り解除

```
delete http://localhost:3000/api/articles/:slug/favorite
```

#### レスポンス

レスポンスなし

## デプロイ

### デプロイ先
[https://www.coderpanda.net](https://www.coderpanda.net/)

### インフラ構成図

![インフラ構成図](https://github.com/pandaFive/conduit-api/assets/101968892/cd054787-7294-481a-8bce-f0b34b31de77)

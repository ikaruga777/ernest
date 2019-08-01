# Ernest

## なにこれ
Slackの絵文字をダンプしてSlackに流すくん

- SlackのCustom Emojiの一覧をGistにダンプする
- ダンプしたCustom EmojiのDiffを取ってSlackに流す


## 使い方
### SlackにAPPを追加する

以下のScopesがあると動きます。
- chat:write:bot
- emoji:read

### settings.yamlを編集する

`settings.yaml.example` をコピーして `settings.yaml` を作成し、編集します。

- slack:
  - token:
    - Slackに投稿するためのAPI Tokenです
  - notify_cnannel:
    - このチャンネルに絵文字の差分を通知します
- github:
  - api_endpoint:
    - Gist APIを使うためのAPIエンドポイントです
    - GitHubだったら `https://api.github.com` です
    - GitHub Enterpriseを使う場合は適宜変更してください
  - access_token:
    - `https://github.com/settings/tokens` から取得したトークンを設定します
    - トークン作成時には `gist  Create gists` にチェックを入れる必要があります。
  - save_gist_id:
    - このGist idのGistにCustom Emojiのダンプを保存します。
  - save_gist_file:
    - Custom Emojiのダンプのファイル名を設定できます

### 実行
```
$ bundle install
$ bundle exec bin/ernest
```

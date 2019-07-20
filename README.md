# Ernest

## なにこれ
Slackの絵文字をダンプしてSlackに流すくん

- SlackのCustom Emojiの一覧をダンプする
- ダンプしたCustom EmojiのDiffを取ってSlackに流す


## 使い方
### SlackにAPPを追加する

以下のScopesがあると動きます。
- chat:write:bot
- emoji:read

### settings.yamlを編集する

`settings.yaml.example` をコピーして `settings.yaml` を作成し、編集します。

### 実行
```
$ bundle install
$ bin/ernest
```

# これは何？
- SAML2.0のSPをsinatra(ruby 1.9.3)とruby-samlで実装したサンプル
- AWS ElasticBeansTalkで動かす前提のファイル構成
- SAML2.0のIdPはPingOneを利用する

## 環境構築

### Local Ruby

```
# homebrew で rbenv をインストール
brew install rbenv ruby-build

# vim .bash_profile 起動時に PATH 通す
eval "$(rbenv init -)"

# EBT のバージョンと同じものを入れる、確認すること。
RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline) --with-openssl-dir=$(brew --prefix openssl)"

rbenv install 1.9.3-p551

# local でのみ動くようにする
cd path/to/this
rbenv local 1.9.3-p551
rbenv rehash

# bundler入れる
rbenv exec gem install bundler
rbenv rehash
```

### Gem
```
# gem入れる
bundle install
```

### local サーバ起動試す
```
bundle exec rackup

ブラウザでアクセス  
http://localhost:9292/
```
### SPの設定


### PingOne(IdP)の設定


## ElasticBeasntalk へ deploy

```
# EB コマンドラインインターフェイス (CLI) 3.x のセットアップ
# http://docs.aws.amazon.com/ja_jp/elasticbeanstalk/latest/dg/eb-cli3-getting-set-up.html

# pip いれる
sudo easy_install pip

# eb コマンド入れる
sudo pip install awsebcli
eb --help

# aws コマンド入れる、AWSの設定
sudo pip install awscli
aws configure --profile nenga

# eb コマンド使えるようにする
cd path/to/this

# git init してなかったら最初にそれを実行

# 下記で、鍵などをセットアップ
eb init --profile nenga

# ステージングへ deploy
eb deploy saml-staging
```

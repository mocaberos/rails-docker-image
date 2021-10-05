# Rails docker image

[![Build Status](https://codebuild.ap-northeast-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiVU8wSVhIckQ0VlJicXR5Yy9FSFdjRVUrbmNhUjNoVzBvSWZCd1d1REtHN0pFRGJyVFlMVmt2MjVva3VPQXkzcWNoMUpuWnFHa0lXQWNYclRtSTFGdDJBPSIsIml2UGFyYW1ldGVyU3BlYyI6InlGdnA3ZDJTM3loT2ozTmUiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=main)](https://ap-northeast-1.console.aws.amazon.com/codesuite/codebuild/085041388644/projects/rails-docker-image)

Rails 6 or 7 (puma)用dockerイメージ

## 使い方
```dockerfile
# Public
FROM mocaberos/rails-docker-image:latest
FROM mocaberos/rails-docker-image:0.0.16
# Private
FROM 085041388644.dkr.ecr.ap-northeast-1.amazonaws.com/rails-docker-image:latest
FROM 085041388644.dkr.ecr.ap-northeast-1.amazonaws.com/rails-docker-image:0.0.16
```
RailsアプリをDockerコンテナ内の`/app`ディレクトリにコピーして、
pumaは`bind 'unix:/var/run/puma.sock'`を設定すると、使用可能。

## 詳細
- Debian 11（bullseye)
- Nginx
  - https://github.com/mocaberos/nginx-on-debian
  - mrubyなしバージョン
- Rails 6 or 7
- Ruby 3.0.2
- Node.js 14.17.5
- jemalloc (Rubyのアロケーションライブラリをよりパフォーマンスの良いjemallocに変更)

Nginxの設定ファイルは`docker/nginx`内のものをコピーして使用できます。
railsアプリが`/app`に配置される前提で、`/app/public/`をドキュメントルートに設定しており。
デフォルトで1190ポートをリッスンして、`unix:/var/run/puma.sock`にリバースプロキシで送信します。

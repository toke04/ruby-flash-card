# Rubyフラッシュカード
## サービスURL

Rubyフラッシュカード  
https://ruby-flash-card.fly.dev/

## サービス概要
『Rubyフラッシュカード』というサービスは、  
覚えているとRuby on Rails 等で効率良く処理が書けるRubyのメソッドを、  
フラッシュカード形式で出題し、  
覚えていたなかったものを再度フラッシュカードで覚えたか確認する事と、  
すでに覚えていたものを忘れていないかフラッシュカードで確認することができるサービスです。  
公式サイトの内容をその場で確認し、  
オンラインエディターで試しながら自分の言葉でメモすることで、  
効率良く覚えることができます。

## 実際の画面
<img width="421" alt="スクリーンショット 2023-08-05 11 56 03" src="https://github.com/syo-tokeshi/ruby-flash-card/assets/54713809/81dd1268-f9e7-4a22-84ff-4c37a3feed61">
<img width="793" alt="スクリーンショット 2023-08-05 11 57 02" src="https://github.com/syo-tokeshi/ruby-flash-card/assets/54713809/f4351097-a7d2-4000-b04d-19e242d59575">
<img width="413" alt="スクリーンショット 2023-08-05 11 58 55" src="https://github.com/syo-tokeshi/ruby-flash-card/assets/54713809/2ca5ca14-5552-4bd8-b96d-5d840343669c">

## 技術スタック
- Ruby 3.2.0
- Rails 7.0.6
- Devise 4.9.0
- omniauth 2.1.1
- omniauth-github 2.0.1
- ransack 4.0.0
- vite_rails 3.0.15
- Rucocop 1.54.2
- ERB-Lint 0.4.0
- Tailwind CSS 3.3.3
- daisyUI 3.3.1
- Node.js 18.16.1
- React 18.2.15
- TypeScript 4.6.3
- axios 1.4.0
- react-toastify 9.1.3
- @uiw/react-textarea-code-editor 2.1.7
- ESLint 8.45.0
- Prettier 3.0.0
- Hotwire
  - Turbo 1.4.0
- RSpec 6.0.3
- Factory_bot 6.2.1
- PostgreSQL
- GitHub Actions
- Docker
- Fly.io

## ローカルでの環境構築手順
### セットアップ
```
git clone https://github.com/syo-tokeshi/ruby-flash-card
cd ruby-flash-card
bin/setup
npm install
```

### GitHub の Client IDと Client Secretの取得について

このアプリを利用するには、上記二つの値を本リポジトリのルートディレクトリ直下の`.env`ファイルに記載する必要があります

```
GITHUB_ID = 'xxxxxxxx'
GITHUB_SECRET = 'xxxxxxxx'
```

取得の際は、以下の記事を参考にセットアップをお願い致します
https://yurakawa.hatenablog.jp/entry/2018/06/04/002033
### 起動コマンド
```
bin/dev
```

### Lint
```
bin/lint
```

### Test
```
bin/rspec
```

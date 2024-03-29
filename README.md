# Rubyフラッシュカード
## サービスURL

Rubyフラッシュカード  
https://ruby-flash-card.fly.dev/

## サービス概要
『Rubyフラッシュカード』というサービスは、  
覚えているとRuby on Rails 等で効率良く処理が書けるRubyのメソッドを、  
フラッシュカード形式で出題し、  
覚えていたなかったものを再度フラッシュカードで覚えたか確認する事と、  
すでに覚えていたものを忘れていないか確認することができるサービスです。  
公式サイトの内容をその場で確認し、  
オンラインエディターで試しながら自分の言葉でメモすることで、  
効率良く覚えることができます。

## 実際の画面
<img width="433" alt="スクリーンショット 2023-09-12 12 07 25" src="https://github.com/syo-tokeshi/ruby-flash-card/assets/54713809/e0641182-3767-4157-9a28-6cedaff3167a">
<img width="1020" alt="スクリーンショット 2023-09-12 12 09 06" src="https://github.com/syo-tokeshi/ruby-flash-card/assets/54713809/7631fb4f-b2b2-4e76-b407-b6585c2cece8">
<img width="468" alt="スクリーンショット 2023-09-12 12 10 01" src="https://github.com/syo-tokeshi/ruby-flash-card/assets/54713809/53a21c89-6485-42e0-8cb9-a81812ddbcbb">

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
- react-hotkeys-hook 4.4.1
- prismjs 1.29.0
- ESLint 8.45.0
- Prettier 3.0.0
- RSpec 6.0.3
- Factory_bot 6.2.1
- ruby-wasm
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
GITHUB_ID = 'Client ID'
GITHUB_SECRET = 'Client Secret'
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

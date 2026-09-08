## この章でやること

GitHub Enterprise Cloud に push する簡単なアプリを作るお題に取り組み、プロンプトや設計の違いで成果物が変わることを体感します。

目安時間: アプリ作成 25分、共有 10分

## GitHub に push する簡単なアプリを作る

同じお題をもとに各自でアプリを作ります。全員が同じものを作る必要はありません。プロンプト、設計、利用する言語やフレームワークによって、成果物が変わることを体感します。

この章では GitHub Enterprise Cloud に push するところまでをゴールにします。Pull Requestの作成、GitHub ActionsによるCI、Jenkinsの設定、本番デプロイは今回の範囲外です。

リポジトリはGitHub Enterprise CloudのWeb画面から手動で作成します。GitHub CLI (`gh`) はインストールせず、この手順でも使用しません。pushには通常の `git` コマンドを使います。

### お題

GitHub Enterprise Cloud に push できる、シンプルな Web API または Web アプリを作ってください。

必須条件:

- HTTP で動作する
- ヘルスチェック用のエンドポイントを持つ
- README に起動方法を書く
- Gitでコミットし、GitHub Enterprise Cloud に push できる状態にする

例:

- ToDo API
- メモ投稿 API
- 簡易ステータスページ
- VM 情報を返すダミー API
- 静的 HTML のランディングページ

### 作成手順

1. Planで、作成するファイル、使用するフレームワーク、起動方法、動作確認方法を整理します。
    - GitHub に push する簡単な Web API を作りたいです。初心者向けのお題として、どのような構成が良いですか？
    - 20分で作れる最小構成にしてください。
    - `/health` を返すだけの最小アプリから始めたいです。
1. 言語・フレームワークを決めます。
    - Node.js / Express
    - Python / FastAPI
    - Java / Spring Boot
    - Go / net/http
    - 静的 HTML
1. 計画を確認してAgentへ切り替え、アプリのひな型を作成します。
1. 小さな関数やREADMEの一文を自分で書き始め、表示されたコード補完候補を `Tab` で採用します。意図と違う候補は採用せず、そのまま入力を続けます。
1. コードまたは文章の一部を選択し、Inline Chatから「この処理を初心者向けに説明してください」または「この部分だけ読みやすくしてください」と依頼します。
1. Agentが変更を終えたら差分を開き、次を確認します。
    - Planにないファイルが追加されていない
    - パスワードやトークンが書かれていない
    - `/health` とREADMEが要件を満たしている
    - 実行したコマンドが想定どおりである
1. テストや起動確認が失敗した場合は、Problemsパネルまたはターミナル出力をチャットへ追加して修正を依頼します。
1. README にローカル起動方法を書きます。

### GitHub Enterprise Cloud に push する

1. GitHub Enterprise CloudのWeb画面を開き、講師が指定したOrganizationまたは自分の領域に空のリポジトリを作成します。
1. リポジトリ名を決めます。README、`.gitignore`、ライセンスは追加せず、空の状態で作成します。
1. 作成後に表示されるHTTPSのリポジトリURLを控えます。
1. コミットに使用される名前とメールアドレスを確認します。

    ```bash
    git config user.name
    git config user.email
    ```

    何も表示されない場合は、講師の案内に従って設定します。メールアドレスの公開を避ける場合は、GitHubのnoreplyメールアドレスを使用します。

1. アプリのディレクトリで次のコマンドを実行します。最初の行のURLは、控えたHTTPS URLに置き換えます。

    ```bash
    REPOSITORY_URL='https://github.example.com/organization/repository.git'
    git init
    git add .
    git commit -m "Add sample application"
    git branch -M main
    git remote add origin "$REPOSITORY_URL"
    git push -u origin main
    ```

1. 認証を求められた場合は、組織で指定されたブラウザー認証またはGit Credential Managerを使用します。パスワードやトークンをチャット、ソースコード、コマンド履歴へ貼り付けないでください。
1. GitHub Enterprise CloudのWeb画面を再読み込みし、ソースコードとREADMEが表示されることを確認します。

すでにGitリポジトリとして初期化されている場合は、`git init`を省略します。`origin`が設定済みの場合は、勝手に上書きせず `git remote -v` で現在値を確認してください。

## プロンプト例

- Python FastAPI で `/health` と `/api/messages` を持つ最小構成のアプリを作ってください。
- README にローカルでの起動方法と動作確認方法を書いてください。
- このアプリを、`gh` CLIを使わず通常の `git` コマンドだけでGitHub Enterprise Cloudへpushする手順を教えてください。
- 初心者が README を読んで迷いそうな点を補足してください。

## 共有・ふりかえり

1. 何を作ったかを1分程度で共有します。
1. 同じお題でも、生成されたファイル構成や README の書き方が違うことを確認します。
1. Copilot の回答を採用する前に、どのような観点でレビューすべきかを話し合います。

## 余裕がある方向けの追加ワーク

1. アプリの README にアーキテクチャ図を追加します。
1. GitHub Actionsを利用できる環境では、buildとtestだけを行うワークフロー案をCopilotに相談します。実行前にOrganizationの利用ルールを確認します。
1. 将来 Jenkins でデプロイする場合に必要になりそうな設定ファイルや情報を Copilot に整理してもらいます。
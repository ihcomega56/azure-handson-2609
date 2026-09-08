## この章でやること

GitHub Enterprise Cloud に push する簡単なアプリを作るお題に取り組み、プロンプトや設計の違いで成果物が変わることを体感します。

## GitHub に push する簡単なアプリを作る

この章では GitHub Enterprise Cloud に push するところまでをゴールにします。Pull Requestの作成、GitHub ActionsによるCI、Jenkinsの設定、本番デプロイは今回の範囲外です。

### お題

GitHub Enterprise Cloud に push できる、TypeScript で作るシンプルな ToDo アプリを作ってください。

必須条件:

- TypeScript で作る
- ブラウザで動作する UI を持つ
- バックエンド通信をしない
- タスクの追加・完了切替・削除ができる
- README に起動方法を書く
- Git でコミットし、GitHub Enterprise Cloud に push できる状態にする

例:

- シンプル ToDo リスト
- 今日のやること管理アプリ
- 予定管理ダッシュボード
- 簡単なメモ帳風アプリ

### 作成手順

1. Plan で、作成するファイル、使う技術、起動方法、動作確認方法を整理します。
    - GitHub に push する簡単な TypeScript UI アプリを作りたいです。初心者向けのお題として、どのような構成が良いですか？
    - 20分で作れる最小構成にしてください。
    - バックエンド通信は使わず、ブラウザだけで動くシンプルな ToDo アプリにしたいです。
1. 技術を固定します。
    - TypeScript
    - React + Vite
    - ローカルの state で管理
    - 必要に応じて localStorage を使う
1. 計画を確認して Agent へ切り替え、アプリのひな型を作成します。
1. 小さな関数や README の一文を自分で書き始め、表示されたコード補完候補を `Tab` で採用します。意図と違う候補は採用せず、そのまま入力を続けます。
1. コードまたは文章の一部を選択し、Inline Chat から「この処理を初心者向けに説明してください」または「この部分だけ読みやすくしてください」と依頼します。
1. Agent が変更を終えたら差分を開き、次を確認します。
    - Plan にないファイルが追加されていない
    - パスワードやトークンが書かれていない
    - README と UI の要件が一致している
    - 実行したコマンドが想定どおりである
1. テストや起動確認が失敗した場合は、Problems パネルまたはターミナル出力をチャットへ追加して修正を依頼します。
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

- TypeScript で、ブラウザで動くシンプルな ToDo アプリを作ってください。タスクの追加、完了切替、削除ができるようにしてください。
- README にローカル起動方法と動作確認方法を書いてください。バックエンド通信は使わない前提にしてください。
- このアプリを、`gh` CLI を使わず通常の `git` コマンドだけで GitHub Enterprise Cloud へ push する手順を教えてください。
- 初心者が README を読んで迷いそうな点を補足してください。

## 共有・ふりかえり

1. 何を作ったかを1分程度で共有します。
1. 同じお題でも、生成されたファイル構成や README の書き方が違うことを確認します。
1. Copilot の回答を採用する前に、どのような観点でレビューすべきかを話し合います。

## 余裕がある方向けの追加ワーク

1. この ToDo アプリを、将来閉域環境の VM または AKS にデプロイする前提で、必要な準備を整理します。
    - どの段階でビルド成果物を作るか
    - どこで公開するのか（内部共有か、閉域内のエンドポイントか）
    - 必要になる環境変数や設定ファイル
    - 環境ごとの差分をどこで管理するか
1. GitHub Actions を利用できる環境では、アプリの `build` と `test` だけを行うワークフロー案を Copilot に相談します。実際の本番デプロイはこの章では行いません。
1. 将来 Jenkins などでデプロイする場合に必要な設定ファイルや情報を Copilot に整理してもらいます。ただし、この環境ではローカルから一発で公開できない前提で、デプロイ準備の整理に留めます。
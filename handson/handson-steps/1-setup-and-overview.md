## この章でやること

Visual Studio Code で GitHub Copilot を使える状態にし、今回のハンズオンで使う GitHub Copilot の機能をざっくり確認します。

目安時間: 20分

この章では、次の機能を実際に一度ずつ操作します。

- Ask、Plan、Agent のモード切り替え
- `#` によるファイルや選択範囲などのコンテキスト参照
- `/` から選ぶスラッシュコマンド
- ファイル添付

## 手順

### 必要なツールをインストール

1. Windows PowerShellを開きます。通常は管理者として起動する必要はありませんが、インストール中にユーザーアカウント制御 (UAC) が表示された場合は、組織のルールに従って許可します。
1. このリポジトリのルートディレクトリへ移動します。
1. 次のコマンドを実行します。

    ```powershell
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\handson\scripts\setup-windows.ps1
    ```

1. `Setup completed successfully.` と表示されたことを確認します。途中でエラーになった場合は、表示されたメッセージを講師へ共有します。
1. Visual Studio CodeとPowerShellをすべて閉じ、Visual Studio Codeでこのリポジトリを開き直します。

このスクリプトは、Visual Studio Code、Azure CLI、Git、Bicep CLI、およびハンズオンで使用するVS Code拡張機能を確認し、不足しているものだけをインストールします。再実行しても導入済みの項目はスキップされます。

### Visual Studio Code の準備

1. GitHub Copilot にサインインします。
1. Copilot Chat を開きます。ファイルを開いた状態で質問したり、チャットにファイルを添付したりできることを確認します。

### CLI の準備

1. Visual Studio Codeで新しいPowerShellターミナルを開き、Azure CLIが使えるか確認します。
    ```bash
    az version
    ```
1. 必要に応じて Azure にログインします。
    ```bash
    az login
    ```
1. 複数のサブスクリプションを利用している場合は、対象のサブスクリプションを確認します。
    ```bash
    az account show
    az account set --subscription <subscription-id>
    ```
1. Bicep CLI が使えるか確認します。
    ```bash
    az bicep version
    ```

### GitHub Copilot の使い分けを確認

1. Copilot Chat のモード選択を開き、Ask、Plan、Agent が選べることを確認します。
    - Ask: 説明、相談、読み取り中心の調査
    - Plan: 編集前に作業手順、対象ファイル、確認方法を整理
    - Agent: ファイル編集、コマンド実行、検証をまとめて依頼
1. Ask を選び、次の質問を送信します。
    - `このワークスペースが何を扱うリポジトリか、まだファイルを変更せずに説明してください。`
1. チャット入力欄に `#` を入力し、表示される候補を確認します。
1. `#file` などのファイルを参照する候補を使って、この章のファイルをコンテキストに含めます。エディターで文章を選択した場合は、選択範囲を追加する候補も試します。
1. チャット入力欄に `/` を入力し、利用可能なスラッシュコマンドを確認します。`/explain` など、現在の環境に表示されるコマンドを1つ実行します。
1. ファイルをチャットへドラッグ＆ドロップするか、コンテキスト追加ボタンから添付できることを確認します。
1. GitHub Copilot CLI の紹介を聞きます。CLI では `/help`、`@` によるファイル参照、`!` によるシェルコマンド実行などを確認します。利用できるコマンドはバージョンによって異なるため、詳細は `/help` で確認します。
1. GitHub Copilot App の紹介を聞きます。GUI ベースで作業したい場合の入口として紹介します。
1. SRE Agent の紹介を聞きます。運用・障害調査・リソース調査のようなシナリオで、専用エージェントを使うとどのような相談ができるかを確認します。

## プロンプト例

- 今日のハンズオンで GitHub Copilot を使う場面を、初心者向けに説明してください。
- Azure インフラを IaC 化するとき、最初に確認すべき観点を教えてください。
- GitHub Copilot Chat、CLI、App、SRE Agent はそれぞれどのような場面で使い分けると良いですか？
- VS Code の Copilot Chat で、開いているファイルをコンテキストに含める方法を教えてください。
- Ask、Plan、Agent の違いを、ファイルを変更する可能性の有無も含めて説明してください。

## 余裕がある方向けの追加ワーク

1. Copilot Chat の回答をそのまま受け入れるのではなく、根拠となるファイル名や行番号も出してもらいます。
1. 自分の作業スタイルに合わせて、Copilot Chat と GitHub Copilot CLI のどちらが使いやすいかを比較します。

## この章でやること

午前・前半パートで手動作成した Azure インフラを、Copilot Chat に調査してもらいながら読み解きます。最後に Mermaid 記法で構成図を作成します。

目安時間: 25分

## 手順
### Mermaid 構成図の作成

1. 対象のサブスクリプション ID とリソースグループ名を確認します。この2つだけは参加者側で指定します。
1. Copilot Chat を Agent に切り替えます。
1. Copilot Chat に、Azure インフラを調査して Mermaid の構成図を作りたいことを伝えます。

    ```text
    次の Azure リソースグループを読み取り専用で調査し、Mermaid のインフラ構成図を作成してください。

    サブスクリプション ID: <subscription-id>
    リソースグループ名: <resource-group-name>

    まず実行予定の Azure CLI コマンドを示してください。
    create、update、delete など変更を伴う操作は実行しないでください。
    VNet、Subnet、VM、Bastion、NAT Gateway、Public IP、NSG の関係が分かる図にしてください。
    不足している情報があれば、推測せず先に質問してください。
    ```

1. Copilot が提示したコマンドを読み、`show`、`list`、`query` などの読み取り専用操作だけであることを確認してから実行を承認します。
1. Copilot が追加で質問してきた場合は、Azure Portal や講師の画面共有で確認できる範囲で回答します。
1. Copilot が作成した Mermaid 図を読み、管理者の接続経路とアウトバウンド通信の経路が分かるか確認します。
1. 必要に応じて「もっとシンプルに」「ネットワーク中心に」「初心者向けに説明を追加して」など、図の粒度を調整します。
1. 完成した Mermaid 図を新しい Markdown ファイルに貼り付け、Visual Studio Code の Markdown Preview、Mermaid 対応拡張機能、または Mermaid Live Editor で表示を確認します。

## プロンプト例

- Bastion とは何ですか？
- この構成の単一障害点になりそうな箇所はどこですか？
- GitLab VM に Public IP が付いている場合のメリット・デメリットを説明してください。
- NAT Gateway と Public IP の役割の違いを初心者向けに説明してください。
- NSG の設定をレビューするときに確認すべきポイントをチェックリスト化してください。
- この構成を本番環境に近づけるなら、どのような改善が考えられますか？
- この Mermaid 図を、説明用にもっとシンプルにしてください。

## 余裕がある方向けの追加ワーク

1. `/infra-investigate` を使い、Mermaid 図の作成より少し詳しいインフラ調査を依頼します。

    ```text
    /infra-investigate

    次の Azure 環境を読み取り専用で調査してください。

    サブスクリプション ID: <subscription-id>
    リソースグループ名: <resource-group-name>

    変更やデプロイは行わず、実行予定のコマンドを先に示してください。
    ```

1. Copilot の回答で、確認できた事実と推測が分かれているか、関連ファイルと Azure リソース構成が整理されているかを確認します。
1. チーム内で Mermaid 図や調査結果を見比べ、プロンプトの違いで図や説明の粒度がどう変わるかを共有します。

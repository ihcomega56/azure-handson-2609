# GitHub Copilot でインフラ理解を深めるハンズオン

このハンズオンでは、午前・前半パートで手動作成した Azure インフラを題材に、GitHub Copilot を使って構成を読み解き、Mermaid 構成図や Bicep のたたき台を作成します。また、自然言語で Azure の確認作業を依頼し、AI が Azure CLI を実行する体験も行います。

実際の Azure へのデプロイは行いません。Bicep は build による構文確認まで、アプリケーションは GitHub Enterprise Cloud に push するところまでをゴールにします。

> **講師向けメモ**  
> 完成済みの構成図や Bicep は、講師用のサンプルとしてローカルに保持します。参加者には完成済みサンプルを見せず、ブラウザー版 Azure Portal で確認した実リソースから Copilot と一緒に作ってもらいます。

## 想定時間

約 2 時間です。環境セットアップと GitHub Copilot の紹介を含むため、実作業時間は 90 分前後を想定しています。

| 時間 | 内容 |
| ---- | ---- |
| 0:00 - 0:20 | GitHub Copilot の基本操作、モード、コンテキスト指定を体験 |
| 0:20 - 0:45 | Azure Portal で既存インフラを確認し、Mermaid 構成図を作成 |
| 0:45 - 1:15 | Plan で方針を確認してから Bicep を作成し、build で確認 |
| 1:15 - 1:25 | 自然言語で Azure の確認作業を依頼し、AI に CLI を実行させる |
| 1:25 - 1:50 | GitHub に push する簡単なアプリを Copilot と作る |
| 1:50 - 2:00 | 共有・ふりかえり |

## 必要な環境

- Visual Studio Code
- GitHub Copilot / GitHub Copilot Chat 拡張機能
- Bicep 拡張機能
- Azure CLI
- Git
- GitHub Enterprise Cloud の研修用リポジトリを作成できるアカウント
- GitHub Copilot CLI（講師デモ、または余裕がある方向け）
- Mermaid を表示できる環境（Mermaid Live Editor、または VS Code の Mermaid 対応拡張機能）

Azure への実デプロイは行いません。Azure サブスクリプションや権限がない場合は、講師が画面共有する Azure Portal の情報をもとに進めます。

## 講師用サンプルについて

完成済みの構成図、Bicep、パラメーターファイル、デプロイ手順は講師用サンプルです。参加者向けリポジトリには含めません。

> **注意**  
> 参加者向けの作業では、完成済みサンプルを前提にしません。また、講師用サンプルに含まれるデプロイや削除の手順は、このハンズオンでは実行しません。

## 事前準備

可能であれば、開始前に次の準備を済ませておきます。

1. Visual Studio Code に必要な拡張機能をインストールします。
1. GitHub Copilot にサインインします。
1. Azure CLI をインストールし、`az version` が実行できることを確認します。
1. GitHub Enterprise Cloud にサインインできることを確認します。

## 進め方

各章の手順を見ながら、Visual Studio Code の Copilot Chat を中心に進めます。

1. [環境セットアップと GitHub Copilot の紹介](handson-steps/1-setup-and-overview.md)
1. [既存インフラを理解し、Mermaid 構成図を作成する](handson-steps/2-understand-existing-infra.md)
1. [既存構成から Bicep のたたき台を作成する](handson-steps/3-create-bicep.md)
1. [自然言語で Azure の確認コマンドを実行する](handson-steps/4-run-azure-commands.md)
1. [GitHub に push するアプリを作る](handson-steps/5-create-and-push-app.md)

## ゴール

- Copilot Chat で既存インフラについて質問できる
- Ask、Plan、Agent を作業内容に応じて使い分けられる
- `#` によるコンテキスト参照とスラッシュコマンドを使える
- コード補完と Inline Chat を使って小さな編集ができる
- Agent が提案したコマンドとファイル差分を実行・採用前に確認できる
- Azure Portal で確認した情報をもとに Mermaid 構成図を作れる
- 手動作成した Azure リソースを Bicep に起こす観点を理解できる
- Bicep を build して、構文エラーの有無を確認できる
- 自然言語で Azure の確認作業を依頼し、AI が発行する Azure CLI の結果を読める
- 同じお題でも、プロンプトや設計の違いで生成されるアプリが変わることを体感できる
- 作成したアプリを GitHub Enterprise Cloud に push できる

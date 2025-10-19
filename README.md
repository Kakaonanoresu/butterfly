# butterfly — ゲーム向けカスタム Linux OS（プロトタイプ）

概要
- "butterfly" はゲーム体験（高フレームレート・低レイテンシ）を最優先にした Linux ベースのカスタム OS プロジェクトです。
- 目的: できるだけ多くの Windows (.exe) ゲームを動かしつつ、ネイティブに近い高速な体験を提供する。

アプローチ（短縮）
- ベース: Arch Linux（ローリングで最新ドライバ）を想定（Ubuntu ベースに変更可能）
- 互換レイヤ: Steam + Proton-GE、Wine、Lutris を標準でサポート
- 性能チューニング: low-latency カーネル/zen, CPU governor=performance, IRQ affinity, gamemode, PipeWire 設定
- 高互換性が必要なゲーム（特にアンチチートを使うタイトル）向けに、KVM + GPU パススルーの VM テンプレートを別途提供

MVP（優先度）
1. Arch ベースのカスタム ISO（Steam + Proton-GE、Lutris、gamemode をプリインストール）
2. Wine/Lutris のゲームプロファイル集（ユーザー追加可能）
3. GPU パススルーのガイドと VM テンプレート（ハードウェア必須）

貢献方法
- issue / PR を通じてパッケージ候補やチューニングの改善提案をしてください。
- 実機でのテスト結果（GPU/CPU/ゲーム名/動作状況）を issues に報告してください。

まず教えてください
1) 主要ターゲットはどのGPUですか？（NVIDIA / AMD / Intel）
2) Arch をベースで進めてよいですか？（Ubuntu 系を強く希望なら対応を変えます）
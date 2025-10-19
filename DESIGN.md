# butterfly - 設計メモ

設計方針
- 目的: 低スペックでも動くゲーム向け Linux ベース OS (x86_64), lib32 を含めて Windows .exe 互換性を確保
- 軽量: 最小限のデーモン、Wayland + sway、zram、tmpfs を活用して I/O とメモリ負荷を抑える
- 互換性: Steam + Proton-GE, Lutris, Wine をサポート。アンチチート等は VM+GPUパススルーを推奨
- 汎用 GPU/CPU 対応: Mesa/Vulkan を中心に、NVIDIA はプロプライエタリを選択式で導入可能にする

配布/運用
- ISO 配布 (ArchISO ベース)、ユーザーは protonup/protonup-qt で Proton-GE を導入
- 追加: GPU 別の最適化テンプレートとテストプロファイルを repo に揃える

セキュリティ注意
- 一部パフォーマンス向上策はセキュリティ緩和や安定性の低下を招く可能性があるためデフォルトで慎重に扱う

拡張候補
- CI による ISO の自動ビルド(別途 runner が必要)
- テストマトリクス (Proton バージョン x GPU ドライバ)

#!/usr/bin/env bash
# ArchISO を使って butterfly カスタム ISO を作る雛形スクリプト
# 実行環境: Arch Linux（または chroot）上で動かすことを想定
set -euo pipefail

WORKDIR="$(pwd)/archiso"
OUTDIR="$WORKDIR/out"
CONFIGDIR="$WORKDIR/releng"

echo "準備: $WORKDIR を作成します"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

if ! command -v mkarchiso >/dev/null 2>&1; then
  echo "このスクリプトは Arch の mkarchiso を必要とします。Arch 環境で実行してください。"
  exit 1
fi

# releng の雛形をコピー
if [ ! -d /usr/share/archiso/configs/releng ]; then
  echo "/usr/share/archiso/configs/releng が見つかりません。archiso パッケージを確認してください。"
  exit 1
fi

cp -r /usr/share/archiso/configs/releng "$CONFIGDIR"
cd "$CONFIGDIR"

# パッケージリストを上位の packages.txt からコピーする想定
if [ -f ../../packages.txt ]; then
  cp ../../packages.txt ./packages.x86_64
else
  echo "packages.txt が見つかりません。上位ディレクトリに配置してください。"
  exit 1
fi

# カスタムユニットやスクリプトを chroot イメージに組み込む
mkdir -p airootfs/usr/local/bin
if [ -f ../../services/performance.service ]; then
  mkdir -p airootfs/etc/systemd/system
  cp ../../services/performance.service airootfs/etc/systemd/system/
fi
if [ -f ../../usr-local-bin/butterfly-tune.sh ]; then
  cp ../../usr-local-bin/butterfly-tune.sh airootfs/usr/local/bin/butterfly-tune.sh
  chmod +x airootfs/usr/local/bin/butterfly-tune.sh
fi

# カスタムセットアップ用のアーカイブや追加ファイルを airootfs に配置する場合はここに追加

# ビルド（注意: 実行には root 権限が必要）
sudo mkarchiso -v .
echo "ビルド完了。ISO は $CONFIGDIR/out/ に生成されます."
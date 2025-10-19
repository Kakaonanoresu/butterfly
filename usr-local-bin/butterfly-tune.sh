#!/usr/bin/env bash
# /usr/local/bin/butterfly-tune.sh
# 簡易チューニングスクリプト（起動時に systemd ユニットから呼ぶ想定）
set -euo pipefail

ACTION="${1:-}"

apply_performance() {
  echo "Applying performance settings..."
  # CPU governor を performance に
  for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
    gov="$cpu/cpufreq/scaling_governor"
    if [ -f "$gov" ]; then
      echo performance > "$gov" || true
    fi
  done

  # 例: swappiness を下げる
  sysctl -w vm.swappiness=10 >/dev/null 2>&1 || true

  # ここで gamemode やその他ユーザ空間の通知を行うことも可能
  echo "Performance settings applied."
}

restore_defaults() {
  echo "Restoring defaults..."
  for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
    gov="$cpu/cpufreq/scaling_governor"
    if [ -f "$gov" ]; then
      echo ondemand > "$gov" || true
    fi
  done
  sysctl -w vm.swappiness=60 >/dev/null 2>&1 || true
  echo "Defaults restored."
}

case "$ACTION" in
  start)
    apply_performance
    ;;
  stop)
    restore_defaults
    ;;
  *)
    echo "Usage: $0 {start|stop}"
    exit 2
    ;;
esac

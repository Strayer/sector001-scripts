#!/usr/bin/env bash
set -euo pipefail

cd "$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

# /sbin is missing in PATH in cron context
export PATH=$PATH:/sbin/

BACKUP_DIR="/tmp/lvm_backup"

echo ""
echo "*** Creating LVM snapshots"
echo ""

lvcreate -s -p r -n snap_root -L 2G /dev/sector001-vg/root

function cleanup {
  echo ""
  echo "*** Unmounting backup dir ${BACKUP_DIR}"
  echo ""

  umount -R $BACKUP_DIR || true
  rmdir $BACKUP_DIR || true

  echo ""
  echo "*** Removing LVM snapshots"
  echo ""

  lvremove -f sector001-vg/snap_root
}
trap cleanup EXIT

echo ""
echo "*** Mounting LVM snapshots to ${BACKUP_DIR}"
echo ""

mkdir $BACKUP_DIR
mount -o ro /dev/sector001-vg/snap_root $BACKUP_DIR

echo ""
echo "*** Running duply backup ($(date))"
echo ""

./duply-backup.sh

echo ""
echo "*** Done ($(date))"

echo ""
echo "*** Running borg backup ($(date))"
echo ""

./borg-backup.sh

echo ""
echo "*** Done ($(date))"

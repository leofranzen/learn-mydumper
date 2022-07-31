#!/usr/bin/env bash

umask 0077

BACKUP_DIR="/backup/"
BACKUP_NAME="${BACKUP_DIR}mydumper-$(date +%F_%H%M)"

BACKUP_LOG_DIR="/var/log/mydumper/"
BACKUP_LOG_FILE="${BACKUP_LOG_DIR}mydumper.log"

BACKUP_RETENTION_DAYS=30

if [ ! -d ${BACKUP_DIR} ] ; then
    mkdir -p ${BACKUP_DIR}
fi

if [ ! -d ${BACKUP_LOG_DIR} ] ; then
    mkdir -p ${BACKUP_LOG_DIR}
fi

exec >> ${BACKUP_LOG_FILE}
exec 2>> ${BACKUP_LOG_FILE}

echo "[+] start script $(date +"%F %T %A")"

echo "[+] mydumper $(date +"%F %T %A")"
mydumper --threads 4 --rows=100000 --compress \
    --events --routines --triggers --complete-insert \
    --build-empty-files --outputdir "${BACKUP_NAME}"

echo "[+] clean old backup $(date +"%F %T %A")"
for OLD_BACKUP in $(find /backup/ -mindepth 1 -maxdepth 1 -type d -name '*mydumper*' -mtime +${BACKUP_RETENTION_DAYS}) ; do
    echo "[+] clean backup ${OLD_BACKUP} $(date +"%F %T %A")"
    rm -rf ${OLD_BACKUP}
done

echo -e "[+] end script $(date +"%F %T %A")\n"

exit 0

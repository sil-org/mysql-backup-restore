#!/usr/bin/env sh

STATUS=0

case "${MODE}" in
    backup|restore)
        if [ -z "${APP_ID}" ]; then
            "/data/${MODE}.sh" || STATUS=$?
        else
            config-shim --app "${APP_ID}" --config "${CONFIG_ID}" --env "${ENV_ID}" "/data/${MODE}.sh" || STATUS=$?
        fi
        ;;
    *)
        echo mysql-backup-restore: FATAL: Unknown MODE: ${MODE}
        exit 1
esac

if [ $STATUS -ne 0 ]; then
    echo mysql-backup-restore: Non-zero exit: $STATUS
fi

exit $STATUS

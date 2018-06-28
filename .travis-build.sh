#!/bin/bash
set -o nounset

TARGET_ARCHITECTURE="aarch64"

BUILD_LOG_FILE="termux-build.log"
BUILD_FINISHED_CONTROL_FILE="/tmp/.build-finished"
PACKAGES_ARCHIVE_FILE="termux-extra-packages_${TARGET_ARCHITECTURE}.tar"

## Print message every 5 minutes.
timed_message() {
    local MESSAGE_DELAY=300

    while true; do
        sleep "${MESSAGE_DELAY}" && {
            if [ -e "${BUILD_FINISHED_CONTROL_FILE}" ]; then
                break
            fi
            echo "[*] build in progress..."
        }
    done
}

if [ ! -e "./termux-packages" ]; then
    echo -n "[*] Cloning build environment (termux/termux-packages.git)... "
    if git clone "https://github.com/termux/termux-packages.git" > /dev/null 2>&1; then
        echo "ok"
    else
        echo "fail"
        exit 1
    fi

    echo -n "[*] Copying extra packages to build environment... "
    if cp -a ./packages/* ./packages-x11/* ./termux-packages/packages/ > /dev/null 2>&1; then
        echo "ok"
    else
        echo "fail"
        exit 1
    fi
fi

echo "[*] Preparing build environment..."
cd ./termux-packages || exit 1
cp ../setup-build-environment.sh ./
./scripts/run-docker.sh sudo env TRAVIS_BUILD_ID=${TRAVIS_BUILD_ID} ./setup-build-environment.sh

echo
echo "PACKAGE BUILD STARTED: ${1}"
echo

timed_message &

if ./scripts/run-docker.sh ./build-package.sh -a "${TARGET_ARCHITECTURE}" "${1}" > "${BUILD_LOG_FILE}" 2>&1; then
    touch "${BUILD_FINISHED_CONTROL_FILE}"
    echo
    echo "BUILD FINISHED SUCCESSFULLY"
    echo
else
    touch "${BUILD_FINISHED_CONTROL_FILE}"
    echo
    echo "BUILD FAILED"
    echo
    echo "Last 1000 lines of build log:"
    tail -n 1000 "${BUILD_LOG_FILE}"
    echo
    exit 1
fi

echo -n "[*] Archiving built packages... "
if tar -cvf "${PACKAGES_ARCHIVE_FILE}" debs "${BUILD_LOG_FILE}" "setup-build-environment.log" > /dev/null 2>&1; then
    echo "ok"
else
    echo "fail"
    echo "[!] Compiled binaries will not be available."
    echo
    echo "    However, since build was successfull, exiting"
    echo "    with status 0 (success)."
    echo
    exit 0
fi

echo -n "[*] Uploading archive... "
if RESULT_URL=$(curl --silent --upload-file "${PACKAGES_ARCHIVE_FILE}" https://transfer.sh/) > /dev/null 2>&1; then
    echo "ok"
    echo
    echo "Your packages were uploaded to: ${RESULT_URL}"
    echo
    exit 0
else
    echo "[!] Failed to upload packages."
    echo
    echo "    However, since build was successfull, exiting"
    echo "    with status 0 (success)."
    echo
    exit 0
fi

#!/usr/bin/env bash

set -Eeuo pipefail

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ANDROID_DIR="$ROOT_DIR/android"
readonly KEY_PROPERTIES="$ANDROID_DIR/key.properties"
readonly LOCAL_PROPERTIES="$ANDROID_DIR/local.properties"
readonly ENV_FILE="$ROOT_DIR/.env"
readonly GOOGLE_SERVICES="$ANDROID_DIR/app/google-services.json"
readonly APPLICATION_ID="com.cyr.talkfirst"

TARGET="${1:-all}"
if [[ $# -gt 0 ]]; then
  shift
fi

case "$TARGET" in
  all | aab | apk) ;;
  *)
    echo "Usage: $0 [all|aab|apk] [additional flutter build arguments]" >&2
    exit 64
    ;;
esac

cd "$ROOT_DIR"

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

property_value() {
  local file="$1"
  local key="$2"
  awk -F= -v key="$key" '
    $1 == key {
      value = substr($0, index($0, "=") + 1)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      print value
      exit
    }
  ' "$file"
}

require_property() {
  local file="$1"
  local key="$2"
  local value
  value="$(property_value "$file" "$key")"
  [[ -n "$value" ]] || fail "Missing $key in ${file#"$ROOT_DIR/"}."
  [[ "$value" != *"YOUR_"* && "$value" != *"<"* && "$value" != *"change-me"* ]] ||
    fail "$key in ${file#"$ROOT_DIR/"} is still a placeholder."
  printf '%s' "$value"
}

command -v flutter >/dev/null 2>&1 || fail "flutter was not found in PATH."
[[ -f "$ENV_FILE" ]] || fail "Missing .env. Copy .env.example and configure release values."
[[ -f "$KEY_PROPERTIES" ]] || fail "Missing android/key.properties (upload signing config)."
[[ -f "$LOCAL_PROPERTIES" ]] || fail "Missing android/local.properties."
[[ -f "$GOOGLE_SERVICES" ]] || fail "Missing android/app/google-services.json."

api_base_url="$(require_property "$ENV_FILE" "API_BASE_URL")"
[[ "$api_base_url" == https://* ]] || fail "API_BASE_URL must use HTTPS for release."
require_property "$ENV_FILE" "GOOGLE_SERVER_CLIENT_ID" >/dev/null
require_property "$LOCAL_PROPERTIES" "facebook.appId" >/dev/null
require_property "$LOCAL_PROPERTIES" "facebook.clientToken" >/dev/null

store_file="$(require_property "$KEY_PROPERTIES" "storeFile")"
require_property "$KEY_PROPERTIES" "storePassword" >/dev/null
require_property "$KEY_PROPERTIES" "keyAlias" >/dev/null
require_property "$KEY_PROPERTIES" "keyPassword" >/dev/null

if [[ "$store_file" = /* ]]; then
  resolved_store_file="$store_file"
else
  resolved_store_file="$ANDROID_DIR/app/$store_file"
fi
[[ -f "$resolved_store_file" ]] || fail "Upload keystore does not exist at the configured storeFile path."

grep -Eq "\"package_name\"[[:space:]]*:[[:space:]]*\"$APPLICATION_ID\"" "$GOOGLE_SERVICES" ||
  fail "google-services.json does not contain Android package $APPLICATION_ID."

version="$(awk '/^version:[[:space:]]*/ { print $2; exit }' pubspec.yaml)"
[[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+\+[1-9][0-9]*$ ]] ||
  fail "pubspec.yaml version must look like 1.2.3+4 with a positive versionCode."

echo "Release preflight passed for $APPLICATION_ID ($version)."
flutter pub get

if [[ "$TARGET" == "all" || "$TARGET" == "aab" ]]; then
  flutter build appbundle --release --no-pub "$@"
  echo "AAB: $ROOT_DIR/build/app/outputs/bundle/release/app-release.aab"
fi

if [[ "$TARGET" == "all" || "$TARGET" == "apk" ]]; then
  flutter build apk --release --no-pub "$@"
  echo "APK: $ROOT_DIR/build/app/outputs/flutter-apk/app-release.apk"
fi

mapping_file="$ROOT_DIR/build/app/outputs/mapping/release/mapping.txt"
native_symbols="$ROOT_DIR/build/app/outputs/native-debug-symbols/release/native-debug-symbols.zip"
[[ -f "$mapping_file" ]] && echo "R8 mapping: $mapping_file"
[[ -f "$native_symbols" ]] && echo "Native symbols: $native_symbols"

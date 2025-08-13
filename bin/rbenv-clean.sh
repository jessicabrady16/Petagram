#!/usr/bin/env bash
# rbenv-clean.sh — remove all rbenv Rubies except the one you keep.
# Usage:
#   rbenv-clean.sh                 # keep current rbenv global
#   rbenv-clean.sh --keep 3.3.9    # keep a specific version
#   rbenv-clean.sh --dry-run       # show what would be removed
# Notes: safe for WSL/Linux. Requires rbenv.

set -euo pipefail

err() { printf "\e[31m%s\e[0m\n" "$*" >&2; }
info() { printf "\e[36m%s\e[0m\n" "$*"; }
ok() { printf "\e[32m%s\e[0m\n" "$*"; }

command -v rbenv >/dev/null 2>&1 || { err "rbenv not found"; exit 1; }

KEEP="$(rbenv global)"
DRY_RUN=0

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --keep) KEEP="${2:-}"; shift 2;;
    --dry-run) DRY_RUN=1; shift;;
    -h|--help)
      echo "Usage: $(basename "$0") [--keep VERSION] [--dry-run]"
      exit 0;;
    *) err "Unknown option: $1"; exit 1;;
  esac
done

VERSIONS_DIR="${HOME}/.rbenv/versions"
[[ -d "$VERSIONS_DIR" ]] || { err "No versions dir: $VERSIONS_DIR"; exit 0; }

# Optional: keep ruby-build updated so future installs are smooth
if [[ -d "$HOME/.rbenv/plugins/ruby-build/.git" ]]; then
  info "Updating ruby-build…"
  git -C "$HOME/.rbenv/plugins/ruby-build" pull --ff-only || true
fi

info "rbenv versions dir: $VERSIONS_DIR"
info "Keeping: $KEEP"
echo

echo "Before size:"
du -sh "$VERSIONS_DIR" || true
echo

ALL_VERSIONS="$(rbenv versions --bare || true)"
REMOVE_LIST="$(printf '%s\n' "$ALL_VERSIONS" | grep -v -F "$KEEP" || true)"

if [[ -z "$REMOVE_LIST" ]]; then
  ok "Nothing to remove."
else
  echo "Will remove:"
  echo "$REMOVE_LIST" | sed 's/^/  - /'
  echo
  if [[ "$DRY_RUN" -eq 1 ]]; then
    ok "Dry-run mode: no changes made."
  else
    while IFS= read -r v; do
      [[ -n "$v" ]] || continue
      info "Uninstalling $v…"
      rbenv uninstall -f "$v"
    done <<< "$REMOVE_LIST"
  fi
fi

echo
echo "After size:"
du -sh "$VERSIONS_DIR" || true
ok "Done."

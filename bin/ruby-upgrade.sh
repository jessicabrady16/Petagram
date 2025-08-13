#!/usr/bin/env bash
set -euo pipefail
command -v rbenv >/dev/null || { echo "rbenv required"; exit 1; }

git -C ~/.rbenv/plugins/ruby-build pull --ff-only || true
LATEST="$(rbenv install -l | awk '/^3\.3\./{v=$1} END{print v}')"
echo "Installing Ruby $LATEST…"
rbenv install -s "$LATEST"
rbenv global "$LATEST"
gem install bundler
bundle update --bundler
ruby -v
echo "Updating database.yml credentials…"
if [[ -f config/database.yml ]]; then
  sed -i 's/username: .*/username: petagram_user/' config/database.yml
  sed -i 's/password: .*/password: petagram_password/' config/database.yml
  echo "Updated database.yml credentials."
else
  echo "No config/database.yml found, skipping update."
fi
echo "Ruby upgrade complete. Remember to run 'bundle install' if needed."
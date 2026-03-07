#!/usr/bin/env bash
set -euo pipefail

OWNER="frankyfurt101"
REPO="privacy"
API_BASE="repos/${OWNER}/${REPO}/pages"

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI (gh) is not installed. Install it first."
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "GitHub CLI is not authenticated. Run: gh auth login"
  exit 1
fi

create_payload() {
  cat <<'JSON'
{
  "source": {
    "branch": "main",
    "path": "/"
  }
}
JSON
}

update_payload() {
  cat <<'JSON'
{
  "source": {
    "branch": "main",
    "path": "/"
  },
  "https_enforced": true
}
JSON
}

if gh api -X GET "$API_BASE" >/dev/null 2>&1; then
  update_payload | gh api \
    --method PUT \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "$API_BASE" \
    --input - >/dev/null
else
  create_payload | gh api \
    --method POST \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "$API_BASE" \
    --input - >/dev/null

  update_payload | gh api \
    --method PUT \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "$API_BASE" \
    --input - >/dev/null
fi

PAGES_URL="https://${OWNER}.github.io/${REPO}/"

echo "GitHub Pages configured."
echo "Privacy Policy URL: ${PAGES_URL}"
echo "Terms URL: ${PAGES_URL}terms.html"

#!/bin/bash
set -euo pipefail

# GitHub リポジトリ設定スクリプト
# プロジェクト作成時に実行して GUI 操作を省略する

REPO="${1:-}"

if [[ -z "$REPO" ]]; then
  echo "Usage: $0 <owner/repo>"
  echo "Example: $0 tetsuooda/ai-driven-develop-kit"
  exit 1
fi

echo "Configuring repository: $REPO"

# リポジトリ設定
echo "Setting repository options..."
gh repo edit "$REPO" \
  --delete-branch-on-merge \
  --enable-issues \
  --enable-wiki=false \
  --enable-projects=false

# マージ方法の設定（merge commit のみ許可）
echo "Setting merge options..."
gh api "repos/$REPO" \
  -X PATCH \
  -f allow_merge_commit=true \
  -f allow_squash_merge=false \
  -f allow_rebase_merge=false \
  --silent

# ブランチ保護ルール
echo "Setting branch protection for main..."
gh api "repos/$REPO/branches/main/protection" \
  -X PUT \
  -H "Accept: application/vnd.github+json" \
  --input - --silent <<'EOF'
{
  "required_status_checks": {
    "strict": true,
    "contexts": []
  },
  "enforce_admins": false,
  "required_pull_request_reviews": null,
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false
}
EOF

echo "Done!"

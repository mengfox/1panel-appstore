#!/usr/bin/env sh
set -e

HTML_PATH="${APP_HTML_PATH:-./data/html}"

mkdir -p "$HTML_PATH"

if [ ! -f "$HTML_PATH/index.html" ]; then
  cat > "$HTML_PATH/index.html" <<'EOF'
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Demo Nginx</title>
</head>
<body>
  <h1>Demo Nginx for 1Panel AppStore</h1>
  <p>1Panel AppStore Demo is running.</p>
</body>
</html>
EOF
fi

echo "Demo Nginx init completed."

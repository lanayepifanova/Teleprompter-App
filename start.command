#!/bin/zsh
# Double-click to open the teleprompter. Close this window when you're done.
cd "$(dirname "$0")"
PORT=8765
if ! lsof -i tcp:$PORT >/dev/null 2>&1; then
  python3 -m http.server $PORT --bind 127.0.0.1 >/dev/null 2>&1 &
  SERVER=$!
  trap "kill $SERVER 2>/dev/null" EXIT
  sleep 0.6
fi
open -a "Google Chrome" "http://localhost:$PORT/" 2>/dev/null || open "http://localhost:$PORT/"
echo "Teleprompter is running at http://localhost:$PORT/ — close this window to stop it."
[ -n "$SERVER" ] && wait $SERVER

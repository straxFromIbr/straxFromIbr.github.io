#! /opt/homebrew/bin/fish

hugo -D --buildFuture
git add -A
git commit -m (date)
git push origin main

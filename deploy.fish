#! /opt/homebrew/bin/fish

cp config.toml config.toml.backup
#cat config.toml | python -c 'import sys; import toml; dic=toml.load(sys.stdin); s="Build:".join([dic["author"]["bio"].split("Build:")[0]+"<br>","'(date '+%Y/%m/%d %H:%M')'"]); dic["author"]["bio"]=s;f=open("config.toml","w");toml.dump(dic,f);f.close()'
cat config.toml | python -c 'import sys; import toml; dic=toml.load(sys.stdin); s="Build:".join([dic["author"]["bio"].split("Build:")[0],"'(date '+%Y/%m/%d %H:%M')'_"]); dic["author"]["bio"]=s;f=open("config.toml","w");toml.dump(dic,f);f.close()'
hugo -D --buildFuture
git add -A
git commit -m (date)
git push origin main

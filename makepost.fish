#! /opt/homebrew/bin/fish
set postname $argv[1]
hugo new "post/$postname.md"
mkdir ./content/images/$postname

sed -i "" -e '12s/^/'"thumbnailImage: \/images\/$postname\/"'\n/' ./content/post/$postname.md
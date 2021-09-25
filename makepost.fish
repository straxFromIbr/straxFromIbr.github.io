#! /opt/homebrew/bin/fish
set postname $argv[1]
hugo new "post/$postname.md"
mkdir ./content/images/$postname

sed -i "" -e '12s/^/'"thumbnailImage: \/images\/$postname\/"'\n/' ./content/post/$postname.md
echo '{{< image classes="fancybox clear fig-100 center" src="/images/'$postname'/" title="">}}' >> ./content/post/$postname.md
cd ./content/post
code $postname.md

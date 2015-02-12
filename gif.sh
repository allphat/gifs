#! /bin/sh
for command in curl jshon mplayer
do
  if ! which $command > /dev/null; then
    read -p "Do you wish to install $command?" yn
    case $yn in
      [Yy]* ) sudo apt-get install $command; break;;
      [Nn]* ) exit;;
          * ) echo "Please answer yes or no.";;
    esac
  fi
done

current_dir=$(pwd)
script_dir=$(dirname $0)

if [ $script_dir = '.' ]
then
  script_dir="$current_dir"
fi

giphy_api_key="dc6zaTOxFJmzC"
tmp_dir="$script_dir/tmp/"
file_name="current.gif"

while :; do
  search_url='http://api.giphy.com/v1/gifs/random?api_key='$giphy_api_key
  gif_url=$(curl -s $search_url | jshon -e data -e image_original_url -u)
  gif_real="$tmp_dir$file_name"
  url=$(curl -s $gif_url -o "$gif_real")

  mplayer -fs "$tmp_dir/"* </dev/null >/dev/null 2>&1

  sleep $((RANDOM%60+10))
done





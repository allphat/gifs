#! /bin/sh
for command in curl mplayer
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
max_files=50
file_pattern="*.gif"
#while true; do
    nb_files=`find -type f -path $tmp_dir -name $file_pattern | wc -l`
    if [ $max_files -lt $nb_files ]; then
      find $tmp_dir -type f | sort -n | cut -d' ' -f2- | head -n -2 | xargs rm  
    fi 

    search_url='http://api.giphy.com/v1/gifs/trending?api_key='$giphy_api_key'&limit=1'
    json_file=$(curl -s $search_url -o 'test.json') 
    grep -e 'original"\:{"url":".*",' -f 'test.json'
    #$gif_url=$json_file | sed -e 's?original":{"url":".*"?'
    #echo $gif_url
    #gif_real="$gif_file.gif"
    #$url=$(curl -s "http://www.gif.tv/gifs/$gif_real" -o "$tmp_dir$gif_real")
   # mplayer -fs "$tmp_dir$gif_real" </dev/null >/dev/null 2>&1
   # sleep $((RANDOM%600+60))
#done

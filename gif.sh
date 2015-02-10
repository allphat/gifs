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

tmp_dir="$script_dir/tmp/"
max_files=50
file_pattern="*.gif"
while true; do
    nb_files=`find -type f -path $tmp_dir -name $file_pattern | wc -l`
    if [ $max_files -lt $nb_files ]; then
       echo'ooooo'
	#find $tmp_dir -type f -amin +2 -delete
        find $tmp_dir -type f | sort -n | cut -d' ' -f2- | head -n -2 | xargs rm  
    fi 
    script_dir=$(dirname $0)
    temp_file="current.gif"
    timestamp_date=`date +%s`
    search_url='www.gif.tv/gifs/get.php?unique='$timestamp_date
    gif_file=$(curl -s $search_url)
    gif_real="$gif_file.gif"
    curl -s "http://www.gif.tv/gifs/$gif_real" -o "$tmp_dir$gif_real"
    mplayer -fs "$tmp_dir$gif_real" </dev/null >/dev/null 2>&1
    sleep $((RANDOM%600+60))
done

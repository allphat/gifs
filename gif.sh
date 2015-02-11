#! /bin/sh
for command in curl feh jshon
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
nb_files_max=50

while :; do
  nb_files=`ls -l $tmp_dir | wc -l`
  if [ $nb_files -lt $max_files ]; then
    search_url='http://api.giphy.com/v1/gifs/random?api_key='$giphy_api_key
    gif_url=$(curl -s $search_url | jshon -e data -e image_original_url -u)
    gif_real="$tmp_dir$(date +%s).gif"
    url=$(curl -s $gif_url -o "$gif_real")
    sleep $((RANDOM%60+10))
  else
    break
  fi
done
if [ $max_files -le $nb_files ]; then
  while :
  do

    mplayer -fs -shuffle "$tmp_dir/"*
    #</dev/null >/dev/null 2>&1
  done
fi


##### delete old nb_files
#nb_files=`find -type f -path $tmp_dir -name $file_pattern | wc -l`
#if [ $max_files -lt $nb_files ]; then
#  find $tmp_dir -type f | sort -n | cut -d' ' -f2- | head -n -2 | xargs rm  
#fi 
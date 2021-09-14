#!/bin/bash
banner=$(cat <<BANNER
───▄▀▀▀▄▄▄▄▄▄▄▀▀▀▄───
───█▒▒░░░░░░░░░▒▒█───
────█░░█░░░░░█░░█────
─▄▄──█░░░▀█▀░░░█──▄▄─
█░░█─▀▄░░░░░░░▄▀─█░░█
█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█
█░░╦─╦╔╗╦─╔╗╔╗╔╦╗╔╗░░█
█░░║║║╠─║─║─║║║║║╠─░░█
█░░╚╩╝╚╝╚╝╚╝╚╝╩─╩╚╝░░█
█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█
BANNER
)
if [[ -z $1 ]]; then
  echo -e "\e[92m$banner\e[0m\nUsage: $0 [code]"; exit
fi

site="https://nhentai.net"
letakpict="https://i.nhentai.net/galleries"

thumbnail=$(curl -X GET --silent $site/g/$1/ \
	| htmlq --pretty '#thumbnail-container' --attribute data-src img)

if [[ -n "$thumbnail" ]]; then
  mkdir $1

	url_=$(echo "$thumbnail" | head -1)
	getnumidk=$(basename $(dirname $url_))

	for dwn in $(seq 1 $(echo "$thumbnail" | wc -l)); do
		wget -q --show-progress -P $1 $letakpict/$getnumidk/$dwn.jpg &
	done; wait

	echo -e "All done\nSaved into $1 directory"
else
  echo "oops sorry dude I didn't find any doujin with this code [$1]"
fi

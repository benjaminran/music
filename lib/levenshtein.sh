#!/bin/bash
# calculate distance between 2 strings
# https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Levenshtein_distance#Bash
function levenshtein {
	if [ "$#" -ne "2" ]; then
		echo "Usage: $0 word1 word2" >&2
	elif [ "${#1}" -lt "${#2}" ]; then
		levenshtein "$2" "$1"
	else
		local str1len=$((${#1}))
		local str2len=$((${#2}))
		local d i j
		for i in $(seq 0 $(((str1len+1)*(str2len+1)))); do
			d[i]=0
		done
		for i in $(seq 0 $((str1len)));	do
			d[$((i+0*str1len))]=$i
		done
		for j in $(seq 0 $((str2len)));	do
			d[$((0+j*(str1len+1)))]=$j
		done

		for j in $(seq 1 $((str2len))); do
			for i in $(seq 1 $((str1len))); do
				[ "${1:i-1:1}" = "${2:j-1:1}" ] && local cost=0 || local cost=1
				local del=$((d[(i-1)+str1len*j]+1))
				local ins=$((d[i+str1len*(j-1)]+1))
				local alt=$((d[(i-1)+str1len*(j-1)]+cost))
				d[i+str1len*j]=$(echo -e "$del\n$ins\n$alt" | sort -n | head -1)
			done
		done
		echo ${d[str1len+str1len*(str2len)]}
	fi
}

[[ "${BASH_SOURCE[0]}" != "${0}" ]] || levenshtein "$@"

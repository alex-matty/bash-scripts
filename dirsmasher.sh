#!/bin/bash

# Script for directory bruteforcing
# NOTES: Find a way to make it faster

#Get all the information from the user
echo "Website directory bruteforce"
echo -n "Website to bruteforce: "
read website
echo -n "Wordlist to use: "
read wordlist
echo -n "Extensions to use (Separated by comas): "
read extensions

# Create an array from the provided wordlist
arrayWordlist=()
mapfile arrayWordlist < $wordlist

# Create an array from the provided extensions
IFS="," read -a arrayExtensions <<< $extensions

# Start appending element from wordlist and extension, if url has either 200 or 301 code echo complete URL
startTime=$(date +%s)
for element in ${arrayWordlist[@]}
do
	for secondElement in ${arrayExtensions[@]}
	do
		htmlCode=$( curl --head --silent -o /dev/null --write-out '%{http_code}\n' "$website/$element.$secondElement" )
		if [[ $htmlCode -eq 200 ]] || [[ $htmlCode -eq 301 ]]
		then
			echo "Status: $htmlCode   $website/$element.$secondElement"
		fi
	done
done
endTime=$(date +%s)
totalTime=$((endTime-startTime))
echo "Script runtime = $totalTime seconds"

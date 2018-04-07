#!/usr/bin/env fish
set songdir $HOME/CloneHero/Songs

set name $argv

function search
	echo (curl -G https://chorus.fightthe.pw/api/search --data-urlencode "query=$argv")
end

function clean
	echo "$argv" | sed -e 's/^"//' -e 's/"$//'
end

function pick_prompt
	set_color green
	echo Pick a song: 
	set_color normal
end

echo "Searching for \"$argv\""
set results (search "$argv")
set song_link_list (echo "$results" | jq '.songs[] | .directLinks | .archive')
set song_name_list (echo "$results" | jq '.songs[] | .name')
set song_artist_list (echo "$results" | jq '.songs[] | .artist')
set song_charter_list (echo "$results" | jq '.songs[] | .charter')
set song_source_list (echo "$results" | jq '.songs[] | .sources[0] | .name')
set song_source_parent_list (echo "$results" | jq '.songs[] | .sources[0] | .parent | .name')
set song_count (count $song_name_list)

for i in (seq $song_count)
	set link (clean "$song_link_list[$i]")
	if [ "$link" != "null" ]
		set name (clean "$song_name_list[$i]")
		set artist (clean "$song_artist_list[$i]")
		set full_name "$artist - $name"
		set charter (clean "$song_charter_list[$i]")
		set source (clean "$song_source_list[$i]")
		set source_parent (clean "$song_source_parent_list[$i]")
		if [ "$source_parent" = "null" ]
			set full_source $source
		else
			set full_source $source/$source_parent
		end
		echo "[$i] $full_name (charted by $charter) from $full_source"
	end
end

read -p pick_prompt pick

set link (clean "$song_link_list[$pick]")
set name (clean "$song_name_list[$pick]")
set artist (clean "$song_artist_list[$pick]")
set full_name "$artist - $name"
set charter (clean "$song_charter_list[$pick]")
set source (clean "$song_source_list[$pick]")
set source_parent (clean "$song_source_parent_list[$pick]")
if [ "$source_parent" = "null" ]
	set full_source $source
else
	set full_source $source/$source_parent
end
set location $songdir/$full_source/

echo "Downloading $full_name (charted by $charter) from $full_source"
set tmplocation /tmp/$full_name.zip
wget $link -O $tmplocation
mkdir -p $location
unzip $tmplocation -d $location
rm $tmplocation

#!/usr/bin/env fish
for line in (cat synced)
	echo "Syncing $line"
	set dir (dirname "$line")
	set name (basename "$line")
	mkdir -p "./$dir"
	cp -r "$HOME/$line" "./$dir"
end

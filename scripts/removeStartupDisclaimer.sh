#!/bin/bash

# Define the search and replace strings
search_str="systemApp.prototype._displayedDisclaimer = function()"
replace_str="systemApp.prototype._noDisplayedDisclaimer = function()"

# Define the file path
file_path="/jci/gui/apps/system/js/systemApp.js"

# Use sed to perform the search and replace
sed -i "s@$search_str@$replace_str@" "$file_path"

# Add comments to the original line
sed -i "/$replace_str/a // $search_str" "$file_path"

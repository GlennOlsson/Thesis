# Exit code of script describes if the PDFs should be built
# Based on when they were last built, and when the latest change in any relevant file was made

if [ ! -f kth.pdf ]; then
    echo "KTH PDF not found, build"
    exit 1
fi

if [ ! -f calpoly.pdf ]; then
    echo "CalPoly PDF not found, build"
    exit 1
fi

# https://unix.stackexchange.com/a/615789
zmodload zsh/stat
typeset -A newest_mtime newest_file

stat -gLA REPLY -F %FZ%T +mtime -- kth.pdf
KTH_BUILD_TIME=$(date -j -f "%Y-%m-%dZ%H:%M:%S" "$REPLY" +"%s")

stat -gLA REPLY -F %FZ%T +mtime -- calpoly.pdf
CALPOLY_BUILD_TIME=$(date -j -f "%Y-%m-%dZ%H:%M:%S" "$REPLY" +"%s")

if [ $((CALPOLY_BUILD_TIME-30)) -gt $KTH_BUILD_TIME ] || [ $((CALPOLY_BUILD_TIME+30)) -lt $KTH_BUILD_TIME ]; then
	echo "PDFs are not built at same time, rebuild"
	return 1
fi

by_age_of_newest_file() {
	local dir=${1-$REPLY}
	local newest=($dir/**/*(ND.om[1]))

  	if [[ "$dir" == ".git" ]] || [[ "$dir" == ".vscode" ]] || [[ "$dir" == "out" ]]; then
		return
	fi

	if (($#newest)); then
		stat -gLA REPLY -F %FZ%T +mtime -- $newest
		newest_mtime[$dir]=$REPLY newest_file[$dir]=$newest
		mod_time=$(date -j -f "%Y-%m-%dZ%H:%M:%S" "$REPLY" +"%s")
		if [ $mod_time -gt $KTH_BUILD_TIME ]; then
			echo "There is a newer file, build ($newest)"
			FUNC_REPLY=1
			return 1
		fi
	else
		REPLY= newest_mtime[$dir]= newest_file[$dir]=
	fi
}

#print -rC1 -- *(ND/o+by_age_of_newest_file)

data=()
for dir (*(ND/o+by_age_of_newest_file)); do
	if [[ "$FUNC_REPLY" == "1" ]]; then
		return 1
	fi
	if [[ "$dir" != ".git" ]]; then
  		data+=("$dir" "$newest_mtime[$dir]" "($newest_file[$dir])")
	fi
	
done
echo "There is no newer file, no need to build"
export LC_ALL=C
curl -s "https://docs.google.com/spreadsheet/pub?hl=en_US&hl=en_US&key=0AqPp4y2wyQsbdGQ1V3pRRDg5NEpGVWpubzdRZ0tjUWc&single=true&gid=0&output=txt" | grep -v "New format" \
  | sed -e 's,\s*$,,' > licenses_changes.ntxt

: > licenses_changes.ptxt
grep ^SUSE- licenses_changes.ntxt | cut -d'	' -f1 | while read l; do
  echo "$l+	$l+" >> licenses_changes.ptxt ; 
done

for i in `w3m -dump -cols 1000 http://spdx.org/licenses/ | grep "License Text" | sed -e 's, *Y *License Text,,; s, *License Text,,; s,.* ,,;'`; do 
	echo "$i	$i" >> licenses_changes.ntxt ; 
	echo "$i+	$i+" >> licenses_changes.ptxt ;
done
IFS=:
dups=$(tr '	' ':' < licenses_changes.ntxt | while read nl ol; do echo "$nl"; done | sed -e 's,^,B-,; s,B-SUSE-,A-,' | sort | uniq | sed -e 's,^.-,,' | sort | uniq -d)
if test -n "$dups"; then 
  echo "DUPS $dups"
  exit 1
fi
dups=$(tr '	' ':' < licenses_changes.ntxt | while read nl ol; do echo "$ol"; done | sort | uniq -d)
unset IFS
if test -n "$dups"; then 
  echo "DUPS $dups"
  exit 1
fi

( 
echo "This is the git for openSUSE:Tools/obs-service-format_spec_file"
echo "It happens to be *the* repository for valid licenses to be used in openSUSE spec files"
echo ""
echo "SPDX Licenses"
echo ""
echo "License Tag | Description"
IFS=:
w3m -dump -cols 1000 http://spdx.org/licenses/ | grep "License Text" | sed -e 's, *Y *License Text,,; s, *License Text,,; s,\s* \([^ ]*\)$,:\1,' | while read text license; do
  echo "$license | $text"
done
unset IFS

) > README.md

cat licenses_changes.ntxt licenses_changes.ptxt | sort -u -o licenses_changes.stxt
( echo "First line" ; cat licenses_changes.stxt ) > licenses_changes.txt
rm licenses_changes.ntxt licenses_changes.stxt licenses_changes.ptxt


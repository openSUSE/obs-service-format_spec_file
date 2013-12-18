curl -s "https://docs.google.com/spreadsheet/pub?hl=en_US&hl=en_US&key=0AqPp4y2wyQsbdGQ1V3pRRDg5NEpGVWpubzdRZ0tjUWc&single=true&gid=0&output=txt" | grep -v "New format" > licenses_changes.txt
grep ^SUSE- licenses_changes.txt | cut -d'	' -f1 | while read l; do
  echo "$l+	$l+" >> licenses_changes.txt ; 
done

for i in `w3m -dump -cols 1000 http://spdx.org/licenses/ | grep "License Text" | sed -e 's, *Y *License Text,,; s, *License Text,,; s,.* ,,;'`; do 
	echo "$i	$i" >> licenses_changes.txt ; 
	echo "$i+	$i+" >> licenses_changes.txt ;
done
LC_ALL=C sort -o licenses_changes.txt -u licenses_changes.txt
( echo "First line" ; cat licenses_changes.txt ) > t
mv t licenses_changes.txt

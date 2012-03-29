curl "https://docs.google.com/spreadsheet/pub?hl=en_US&hl=en_US&key=0AqPp4y2wyQsbdGQ1V3pRRDg5NEpGVWpubzdRZ0tjUWc&single=true&gid=0&output=txt" | grep -v "New format" > licenses_changes.txt
sort -o licenses_changes.txt -u licenses_changes.txt
( echo "First line" ; cat licenses_changes.txt ) > t
mv t licenses_changes.txt

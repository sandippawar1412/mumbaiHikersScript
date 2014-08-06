:'
Aug 6, 2014
--Sandeep Pawar, IITB
-------------------------
reads the feed from mumbai hikers.. gets the new enteries in newLinks and newTitles
these enteries are added at top in the allTitles and allLinks file...

only 25 enteries(+1 for 1st mumbaihikers entery) are checked with top 26 enteries of allTitles..

after running the script remained files..
1. allTiles, allLinks
2. newtitles, newLinks -> these are the last new enteries to allTitles and allLinks
'
#!/bin/bash

touch allLinks.txt
touch allTitles.txt
wget "https://www.blogger.com/feeds/8748673123488657024/posts/default"
cat default | grep -i -o '<title type='\'text\''>[^<]*</title>' > titles.txt
cat default | grep -i -o 'type='\'text/html\'' href='\'http://www.mumbaihikers.org/[^\.]*.html\' > links.txt



 cat allTitles.txt | head -n 26 > _tmp_title.txt
 diff titles.txt _tmp_title.txt | grep -o "^<.*" | grep -o "<title .*>" > newTitles.txt
 sed '/.*\<Mumbai Hikers\>.*/d' newTitles.txt > _tmp_newTitles.txt
 mv _tmp_newTitles.txt newTitles.txt 
 cp newTitles.txt _tmp_allTitles.txt
 cat allTitles.txt >> _tmp_allTitles.txt
 mv _tmp_allTitles.txt allTitles.txt

 cat allLinks.txt | head -n 26 > _tmp_links.txt
 diff links.txt _tmp_links.txt | grep -o "^<.*" | grep -o "type.*" > newLinks.txt
 cp newLinks.txt _tmp_allLinks.txt
 cat allLinks.txt >> _tmp_allLinks.txt
 mv _tmp_allLinks.txt allLinks.txt


 rm _* default links.txt titles.txt	

 mkdir -p MHdatabase
  
 NOW=$(date +"%Y-%m-%d")
 
 LOGFILE="links-$NOW.log"
 cp allLinks.txt "$LOGFILE"
 mv "$LOGFILE" MHdatabase/
 
 LOGFILE="titles-$NOW.log"
 cp allTitles.txt "$LOGFILE"
 mv "$LOGFILE" MHdatabase/






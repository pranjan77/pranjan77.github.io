du -a |grep index.html |cut -f 2 |perl x.pl >i.html
y=`ps -aef |grep 8080 |grep Python |cut -f2 -d ' '`
kill $y

python2 -m SimpleHTTPServer 8080 &
open http://localhost:8080

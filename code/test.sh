dest=$1
mv test.txt test.txt.bak
vi +startinsert -c "set paste" test.txt
perl test.pl test.txt >out.txt
python2 t2.py >data.json
cp data.json $dest
echo $dest



#sleep 20s
killall conky
# cd ""
conky -c "conkyrc" > /dev/null 2>&1 &

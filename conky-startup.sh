#sleep 20s
killall conky

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# cd ""
conky -c "$DIR/conkyrc" > /dev/null 2>&1 &

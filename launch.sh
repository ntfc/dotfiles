DIR=$(dirname $(readlink -f "$0"))
DIR="$DIR/acestream"
while :
do
  ${DIR}/acestreamengine --lib-path ${DIR}/ --bind-all --client-console --live-cache-type memory --live-cache-size 209715200 ----max-peers 200 --max-peers-limit 101
done

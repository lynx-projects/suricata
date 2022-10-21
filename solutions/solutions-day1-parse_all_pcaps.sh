#!/bin/bash

PCAP_FOLDER="/home/student/pcap/suricata-course"
FILES=$(find $PCAP_FOLDER -type f -name '*.pcap')

for f in $FILES; do
  fname=$(echo $f | rev | cut -d "/" -f1 | rev)
  echo $PCAP_FOLDER/$fname
  mkdir -p /tmp/logs/$fname
  suricata -r $PCAP_FOLDER/$fname -l /tmp/logs/$fname --disable-detection
  echo $fname >> /tmp/logs/$fname/report.txt
  cat /tmp/logs/$fname/eve.json | jq .event_type | sort -h | uniq -c | sort -h >> /tmp/logs/$fname/report.txt
done

cat /tmp/logs/*/report.txt  | less

#!/bin/sh
while true
do
  token=`curl -s --request POST \
    --url http://10.99.6.5:9100/user-centre/oauth/token \
    --header 'authorization: Basic Y2xpZW50YXBwOjEyMzQ1Ng==' \
    --header 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
    --form grant_type=password \
    --form username=admin \
    --form password=123456 \
    --form scope=read \
    --form client_secret=123456 \
    --form client_id=clientapp | jq .access_token | sed 's/"//g'`

  text=`curl -s --request GET \
    --url http://10.99.6.5:9100/real-time/vehicle/statistics \
    --header "authorization: Bearer ${token}" \
    --header 'cache-control: no-cache' \
    --header 'content-type: application/json'`
  # 在线车辆
  onlineCount=`echo ${text} | jq .data.onlineCount`
  # 告警车辆
  warnCount=`echo ${text} | jq .data.warnCount`
  # 在充电
  inChargeCount=`echo ${text} | jq .data.inChargeCount`
  # 离线
  offlineCount=`echo ${text} | jq .data.offlineCount`

  time=`date +'%F %T'`
  line="onlineCount=${onlineCount},warnCount=${warnCount},inChargeCount=${inChargeCount},offlineCount=${offlineCount}"
  echo "time=${time},${line}"
  sleep 1
done

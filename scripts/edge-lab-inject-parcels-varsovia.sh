 #!/bin/bash
#

mqttUserName=admin
mqttPassword=public


while :;
do
  parcel="$(echo $((0 + RANDOM % 99))):$(echo $((0 + RANDOM % 99))):$(echo $((0 + RANDOM % 99))):$(echo $((0 + RANDOM % 99)))"
  echo $parcel
  from=$(echo $((0 + RANDOM % 10)))
  to=$(echo $((0 + RANDOM % 10)))

  fromId=$(jq -r ".[$from].id" < warehouses.json)
  fromMqtt=$(jq -r ".[$from].mqtt" < warehouses.json)
  toId=$(jq -r ".[$to].id" < warehouses.json)
  toMqtt=$(jq -r ".[$to].mqtt" < warehouses.json)

  echo "mosquitto_pub -t esp8266-out -h a64edbd7185a146f3acb0f88e88913ac-1764399169.us-east-2.elb.amazonaws.com  -p 1883 -u ${mqttUserName} -P ${mqttPassword} -m $parcel"
  mosquitto_pub -t esp8266-out -h a64edbd7185a146f3acb0f88e88913ac-1764399169.us-east-2.elb.amazonaws.com  -p 1883 -u ${mqttUserName} -P ${mqttPassword} -m $parcel
  mosquitto_pub -t esp8266-in  -h $toMqtt   -p 1883 -u ${mqttUserName} -P ${mqttPassword} -m $parcel

  echo
  sleep 0.5
done

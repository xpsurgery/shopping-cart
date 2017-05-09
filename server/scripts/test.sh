#! /bin/bash
#

curl -X POST http://localhost:17171/start
curl -X POST -d '{ "name": "fred" }' http://localhost:17171/teams
curl -X POST -d '{"initial_balance": 30}' http://localhost:17171/configure
curl -X POST http://localhost:17171/play

resp=`curl http://localhost:17171/challenge`
echo $resp

id=`echo "$resp" | grep post | sed -e 's/.*answer\///' -e 's/"//'`

echo $id
curl -d '{ "teamName": "fred", "answer": 6000}' -X POST http://localhost:17171/answer/$id

# curl http://localhost:17171/status


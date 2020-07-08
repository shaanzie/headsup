dates=$(date -u +%s)
echo $dates
set -e

echo "signup"
curl -d '{"email":"value1@gmail.com", "password":"value2", "name":"value1","role":"supervisor", "employeeID":"1234"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/signup
curl -d '{"email":"value2@gmail.com", "password":"value1", "name":"value2","role":"worker", "employeeID":"234"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/signup
curl -d '{"email":"value3@gmail.com", "password":"value4", "name":"value3","role":"worker", "employeeID":"567"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/signup
curl -d '{"email":"value4@gmail.com", "password":"value3", "name":"value4","role":"worker", "employeeID":"890"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/signup
echo " "
echo " "
echo "pushdata"
curl -d '{"status":"active","timestamp":"'${dates}'","stepcount":"4000","duration":"1","employeeID":"567","type":"productivity","asleep":"20","active":"40"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"status":"active","timestamp":"'$((${dates}+3600))'","stepcount":"2000","duration":"1","employeeID":"567","type":"productivity","asleep":"10","active":"50"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"status":"active","timestamp":"'$((${dates}+3600))'","stepcount":"1900","duration":"1","employeeID":"567","type":"productivity","asleep":"20","active":"40"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"status":"active","timestamp":"'$((${dates}+7200))'","stepcount":"2000","duration":"1","employeeID":"567","type":"productivity","asleep":"0","active":"0"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata

curl -d '{"status":"active","timestamp":"'${dates}'","stepcount":"3000","duration":"1","employeeID":"234","type":"productivity","asleep":"20","active":"40"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"status":"active","timestamp":"'$((${dates}+3600))'","stepcount":"2100","duration":"1","employeeID":"234","type":"productivity","asleep":"10","active":"50"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"status":"active","timestamp":"'$((${dates}+3600))'","stepcount":"1000","duration":"1","employeeID":"234","type":"productivity","asleep":"10","active":"50"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"status":"passive","timestamp":"'$((${dates}+7200))'","stepcount":"0","duration":"1","employeeID":"234","type":"productivity","asleep":"0","active":"0"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata

curl -d '{"status":"active","timestamp":"'${dates}'","stepcount":"3100","duration":"1","employeeID":"890","type":"productivity","asleep":"20","active":"40"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"status":"active","timestamp":"'$((${dates}+3600))'","stepcount":"2000","duration":"1","employeeID":"890","type":"productivity","asleep":"10","active":"50"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"status":"active","timestamp":"'$((${dates}+3600))'","stepcount":"2100","duration":"1","employeeID":"890","type":"productivity","asleep":"10","active":"50"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"status":"passive","timestamp":"'$((${dates}+7200))'","stepcount":"0","duration":"1","employeeID":"890","type":"productivity","asleep":"0","active":"0"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata

curl -d '{"employeeID":"567","type":"fatigue","alpha":"20","beta":"40", "gamma":"40"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"employeeID":"567","type":"fatigue","alpha":"10","beta":"50", "gamma":"40"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"employeeID":"567","type":"fatigue","alpha":"20","beta":"40", "gamma":"40"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"employeeID":"567","type":"fatigue","alpha":"30","beta":"20", "gamma":"50"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata

curl -d '{"employeeID":"234","type":"fatigue","alpha":"20","beta":"40", "gamma":"40"}'  -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"employeeID":"234","type":"fatigue","alpha":"10","beta":"50", "gamma":"40"}'  -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"employeeID":"234","type":"fatigue","alpha":"20","beta":"40", "gamma":"40"}'  -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"employeeID":"234","type":"fatigue","alpha":"30","beta":"20", "gamma":"50"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata

curl -d '{"employeeID":"890","type":"fatigue","alpha":"20","beta":"40", "gamma":"40"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"employeeID":"890","type":"fatigue","alpha":"10","beta":"50", "gamma":"40"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"employeeID":"890","type":"fatigue","alpha":"20","beta":"40", "gamma":"40"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"employeeID":"890","type":"fatigue","alpha":"30","beta":"20", "gamma":"50"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata

curl -d '{"employeeID":"234","type":"pollution","pollution":"8"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"employeeID":"234","type":"pollution","pollution":"9.6"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"employeeID":"234","type":"pollution","pollution":"7"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"employeeID":"234","type":"pollution","pollution":"6.4"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata

echo ""
echo ""
echo "pull examples"
curl -d '{"type":"person","employeeID":"234"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pulldata
curl -d '{"type":"collective"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pulldata

echo " "
echo " "
echo "fatigue"
curl -d '{"employeeID":"234"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/fatigue

echo " "
echo " "
echo "stepcount"
curl -d '{"employeeID":"234"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/stepcount

echo " "
echo " "
echo "pollution"
curl -d '{"employeeID":"234"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pollution

echo " "
echo " "
echo "workercount"
curl http://localhost:5000/api/v1/workercount
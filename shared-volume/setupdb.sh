#signup
curl -d '{"email":"value1@gmail.com", "password":"value2", "name":"value1","role":"supervisor", "employeeID":"1234"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/signup
curl -d '{"email":"value2@gmail.com", "password":"value1", "name":"value1","role":"worker", "employeeID":"12345"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/signup

#pushdata
curl -d '{"timestamp":"12345","stepcount":"200","duration":"1","employeeID":"1234","type":"productivity","asleep":"20","active":"40"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"timestamp":"12356","stepcount":"200","duration":"1","employeeID":"1234","type":"productivity","asleep":"10","active":"50"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata

curl -d '{"timestamp":"12345","stepcount":"200","duration":"1","employeeID":"12345","type":"productivity","asleep":"20","active":"40"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
curl -d '{"timestamp":"12356","stepcount":"200","duration":"1","employeeID":"12345","type":"productivity","asleep":"10","active":"50"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata

#pull examples
curl -d '{"type":"person","employeeID":"1234"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pulldata
curl -d '{"type":"collective"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pulldata
#! env ruby
#

require 'json'

ch = `curl http://localhost:17171/challenge`
challenge = JSON.parse(ch, symbolize_names: true)

puts challenge

answer = {
  teamName: 'kr',
  answer: 3456
}.to_json.gsub(/"/, '\\"')

puts answer

resp = `echo "#{answer}" | curl -X POST -d @- http://localhost:17171#{challenge[:postResponseTo]}`

puts resp


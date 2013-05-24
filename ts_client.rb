require 'drb/drb'

#
# This program splits a request of 20,000 factorials per range of 1,000. It writes
# all the requests as (['fact'], head, tail), takes all the results, and sums them up

def fact_client(ts, a, b, n=1000)
	req = []
	a.step(b, n) { |head|
		tail = [b, head + n - 1].min
		req.push([head, tail])
		ts.write(['fact', head, tail])
	}

	puts "#{req}" 
	
	req.inject(1) { |value, range|
		tuple = ts.take(['fact-answer', range[0], range[1], nil])
		value * tuple[3]
	}
end
ts_uri = ARGV.shift || 'druby://localhost:12345'
DRb.start_service
$ts = DRbObject.new_with_uri(ts_uri)
#puts fact_client($ts, 1, 20000)



t = Time.now
fact_client($ts, 1, 50000)
puts "\n============BENCHMARK time:=====================\n", (Time.now - t), "=================================\n\n"


#
# WITHOUT RINDA
t1 = Time.now
(1..50000).inject(1){|a, b| a*b}
puts "\n===========BENCHMARK time, when calculating factorial WITHOUT RINDA PROCESSING:\n", (Time.now - t1), "=================================\n\n"

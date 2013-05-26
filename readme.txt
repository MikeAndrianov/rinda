The factorial server and the client communicate with each other via tuplespace.
The client puts the request tuple and waits for the result tuple. The server
takes out the request tuple and puts the result tuple. The processes are
coordinated by exchanging tuples via tuplespace. Thanks to tuplespace as a
central location, you can write a coordination program easily without worrying
about the timing. Let’s change the client program to split a request with a
large factorial request into multiple requests divided by a certain range.

Rinda is a library to coordinate Ruby programs among different threads or different processes.


First run ts.rb, then ts_server.rb (you can start several servers at once).
After all start ts_client.rb for comuting factorials.

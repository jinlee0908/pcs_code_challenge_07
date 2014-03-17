Accept a new sucker when your CSV file is empty.
Blocking		1.022ms  		 
DSN Lookup		0.071ms 		 
Connecting		0.223ms 		 
Sending			0.114ms 		 
Waiting			7.409ms 		
Receiving		0.700ms 		 

Accept a new sucker when your CSV file has 20 lines.
Blocking		0.699ms 		 0.745ms
Sending			0.144ms 		 0.121ms
Waiting			6.800ms 		11.561ms
Receiving		0.590ms 		 1.271ms


Accept a new sucker when your CSV file has 10,000 lines.
Blocking		0.704ms 		 0.6640ms
DSN Lookup		0.055ms 		 
Connecting		0.176ms 		 
Sending			0.129ms 		 0.140ms
Waiting			23.862ms 		13.108ms
Receiving		0.589ms 		 0.595ms

Display a list of suckers when your CSV file has 20 lines.
Blocking		0.514ms 		 0.540ms
Sending			0.096ms 		 0.104ms
Waiting			7.396ms 		18.424ms
Receiving		0.763ms 		 0.809ms

Display a list of suckers when your CSV file has 10,000 lines.
Blocking		0.513ms 		 0.401ms
Sending			0.083ms 		 0.056ms
Waiting		  398.203ms 		 3.22s
Receiving	   15.825ms 		16.594ms
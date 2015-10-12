var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('FIL - Logs and Infos for Dev\n');
  var sys = require('sys')
  var exec = require('child_process').exec;
  function puts(error, stdout, stderr) { sys.puts(stdout) }
exec("/root/FIL/FIL.sh", puts);
}).listen(8111, "127.0.0.1");
console.log('Server running at http://127.0.0.1:8111/');

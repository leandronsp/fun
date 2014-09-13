from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer

class MyHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-Type', 'text/html')
        self.end_headers()
        self.wfile.write(self.path)
        return

PORT = 8300
httpd = HTTPServer(('', PORT), MyHandler)
print "Server running at", PORT
httpd.serve_forever()

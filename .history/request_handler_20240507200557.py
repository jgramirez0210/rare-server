from http.server import BaseHTTPRequestHandler, HTTPServer
import json

from views.user import create_user, login_user, get_all_users, get_single_user, get_all_users_management, update_user


class HandleRequests(BaseHTTPRequestHandler):
    """Handles the requests to this server"""

    def parse_url(self):
        """Parse the url into the resource and id"""
        path_params = self.path.split('/')
        resource = path_params[1]
        if '?' in resource:
            param = resource.split('?')[1]
            resource = resource.split('?')[0]
            pair = param.split('=')
            key = pair[0]
            value = pair[1]
            return (resource, key, value)
        else:
            id = None
            try:
                id = int(path_params[2])
            except (IndexError, ValueError):
                pass
            return (resource, id)

    def _set_headers(self, status):
        """Sets the status code, Content-Type and Access-Control-Allow-Origin
        headers on the response

        Args:
            status (number): the status code to return to the front end
        """
        self.send_response(status)
        self.send_header('Content-type', 'application/json')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()

    def do_OPTIONS(self):
        """Sets the OPTIONS headers
        """
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods',
                         'GET, POST, PUT, DELETE')
        self.send_header('Access-Control-Allow-Headers',
                         'X-Requested-With, Content-Type, Accept')
        self.end_headers()

    def do_GET(self):
        self._set_headers(200)
        response = {}
        
        parsed = self.parse_url()
        
        if '?' not in self.path:
            ( resource, id ) = parsed
            if resource == "users":
                if id is not None:
                    response = f"{get_single_user(id)}"
                else:
                    response = f"{get_all_users()}"
            elif resource == "users_management":
                response = f"{get_all_users_management()}"
        self.wfile.write(json.dumps(response).encode())        

    def do_POST(self):
        """Make a post request to the server"""
        self._set_headers(201)
        content_len = int(self.headers.get('content-length', 0))
        post_body = json.loads(self.rfile.read(content_len))
        response = ''
        resource, _ = self.parse_url()

        if resource == 'login':
            response = login_user(post_body)
        if resource == 'register':
            response = create_user(post_body)

        self.wfile.write(response.encode())

    def do_PUT(self):
        """Handles PUT requests to the server"""
        pass
        self.__set_headers(204)
        content_len = int(self.headers.get('content-length', 0))
        post_body = json.loads(self.rfile.read(content_len))
        post_body = json.loads(post_body)
        
        #Parse the URL
        (resource, id) = self.parse_url(self.path)
        #Update a singe user
        if resource == "users":
            success = update_user(id, post_body)
            if success:
                self.set_response(204)
            else:
                self.set_response(404)

    def do_DELETE(self):
        """Handle DELETE Requests"""
        pass


def main():
    """Starts the server on port 8088 using the HandleRequests class
    """
    host = ''
    port = 8088
    HTTPServer((host, port), HandleRequests).serve_forever()


if __name__ == "__main__":
    main()

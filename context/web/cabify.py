#!/usr/bin/env python

from bottle import route, run

@route('/status')
def status():
    return 'OK\n'

# run(host='localhost', port=8181, debug=False)
run(host='0.0.0.0', port=8181, debug=False)
# run(host='172.17.0.2', port=8181, debug=False)

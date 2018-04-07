#!/bin/bash
REQUESTS=1000000
CONCURENT_REQUESTS=100

echo "Base test"
echo "===================="
ab -n $REQUESTS -c $CONCURENT_REQUESTS -p test-body.txt -T "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW" http://172.17.0.3/base-test
echo ""
echo "complex string buffer test"
echo "===================="
ab -n $REQUESTS -c $CONCURENT_REQUESTS -p test-body.txt -T "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW" http://172.17.0.3/test-with-complex-string-buffer
echo ""
echo "simple string buffer test"
echo "===================="
ab -n $REQUESTS -c $CONCURENT_REQUESTS -p test-body.txt -T "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW" http://172.17.0.3/test-with-simple-string-buffer
echo ""
echo "string concat test"
echo "===================="
ab -n $REQUESTS -c $CONCURENT_REQUESTS -p test-body.txt -T "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW" http://172.17.0.3/test-with-string-concat
echo ""
echo "No buffer test"
echo "===================="
ab -n $REQUESTS -c $CONCURENT_REQUESTS -p test-body.txt -T "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW" http://172.17.0.3/test-without-buffer
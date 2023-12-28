```
Wed Nov 29 00:46:56 2023 - INFO  - Waiting for Prometheus to be ready.
+ grep 'Server is ready to receive web requests.' ./prometheus.log
+ sleep 1s
+ grep 'Server is ready to receive web requests.' ./prometheus.log
+ sleep 1s
.......
+ grep 'Server is ready to receive web requests.' ./prometheus.log
+ sleep 1s
+ grep 'Server is ready to receive web requests.' ./prometheus.log
+ sleep 1s
+ grep 'Server is ready to receive web requests.' ./prometheus.log
+ sleep 1s
+ grep 'Server is ready to receive web requests.' ./prometheus.log
+ sleep 1s
+ grep 'Server is ready to receive web requests.' ./prometheus.log
+ sleep 1s
Wed Nov 29 01:15:03 2023 - ERROR - Timeout : Command 'bash -x oe_test_prometheus_querying_http_api.sh' timed out after 1799.999254292 seconds
++ post_test
++ LOG_INFO 'start environment cleanup.'
++ message='start environment cleanup.'
++ python3 /root/mugen/libs/locallibs/mugen_log.py --level info --message 'start environment cleanup.'
```


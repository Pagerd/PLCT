```
[root@openeuler-riscv64 mugen]# systemctl restart ipmiseld.service
[ 1688.352278][ T1359] ipmiseld[1359]: unhandled signal 11 code 0x2 at 0x0000003f8d788fc0 in libc.so.6[3f8d6ed000+18b000]
[ 1688.358459][ T1359] CPU: 5 PID: 1359 Comm: ipmiseld Not tainted 6.4.0-10.1.0.20.oe2309.riscv64 #1
[ 1688.360024][ T1359] Hardware name: riscv-virtio,qemu (DT)
[ 1688.360976][ T1359] epc : 0000003f8d788fc0 ra : 0000003f8d782198 sp : 0000003f8d6c48f0
[ 1688.362143][ T1359]  gp : 0000002ae3b9eae8 tp : 0000003f8d6c68e0 t0 : 0000000000000000
[ 1688.363637][ T1359]  t1 : 0000003f8db65fcc t2 : 0000003f8dd08b16 s0 : 0000003f8ceb6000
[ 1688.365388][ T1359]  s1 : 0000000000010000 a0 : 0000003f88001090 a1 : 0000003f8ceb6000
[ 1688.366276][ T1359]  a2 : 0000000000002000 a3 : 0000000000000001 a4 : 0000003f8d841e54
[ 1688.367856][ T1359]  a5 : 0000003f8d788fbc a6 : 0000000000000000 a7 : 00000000000000de
[ 1688.369662][ T1359]  s2 : 0000003f88001090 s3 : 0000003f88001090 s4 : 00000000000f0000
[ 1688.371338][ T1359]  s5 : 0000003f8ceb6000 s6 : 0000002af723faf0 s7 : 0000000000010000
[ 1688.372850][ T1359]  s8 : 0000003f8d6c49f8 s9 : 0000003f8e020d60 s10: 0000003f8d6c5358
[ 1688.373560][ T1359]  s11: 0000000000800000 t3 : 0000003f8d782124 t4 : 0000000000000016
[ 1688.374812][ T1359]  t5 : 0000000000000061 t6 : 0000000000000078
[ 1688.376116][ T1359] status: 8000000200006020 badaddr: 0000003f8ceb6000 cause: 0000000000000005
[root@openeuler-riscv64 mugen]# systemctl status ipmiseld.service
× ipmiseld.service - IPMI SEL syslog logging daemon
     Loaded: loaded (/usr/lib/systemd/system/ipmiseld.service; disabled; preset>
     Active: failed (Result: core-dump) since Thu 2023-12-14 13:01:20 CST; 8s a>
   Duration: 2.853s
    Process: 1356 ExecStart=/usr/sbin/ipmiseld (code=exited, status=0/SUCCESS)
   Main PID: 1358 (code=dumped, signal=SEGV)

Dec 14 13:01:17 openeuler-riscv64 systemd[1]: Starting IPMI SEL syslog logging >
Dec 14 13:01:17 openeuler-riscv64 systemd[1]: Started IPMI SEL syslog logging d>
Dec 14 13:01:20 openeuler-riscv64 systemd-coredump[1361]: Process 1358 (ipmisel>
Dec 14 13:01:20 openeuler-riscv64 systemd[1]: ipmiseld.service: Main process ex>
Dec 14 13:01:20 openeuler-riscv64 systemd[1]: ipmiseld.service: Failed with res>
```


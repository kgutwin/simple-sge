simple-sge
==========

Simple installation of (Son of Grid Engine)[https://arc.liv.ac.uk/trac/SGE]
designed primarily for testing software that integrates with SGE.

Usage
-----

For quick interactive use:

```
$ docker pull kgutwin/simple-sge
$ docker run -ti --rm kgutwin/simple-sge
Reading configuration from file util/install_modules/inst_template.conf
Install log can be found in: /opt/sge/default/common/install_logs/qmaster_install_206fe0796da4_2016-06-22_12:26:11.log
Install log can be found in: /opt/sge/default/common/install_logs/execd_install_206fe0796da4_2016-06-22_12:26:14.log
206fe0796da4 added to submit host list
root@206fe0796da4 modified "all.q" in cluster queue list
root@206fe0796da4 modified "global" in configuration list
changed scheduler configuration
root@206fe0796da4:~# qsub -b y /bin/hostname
Your job 1 ("hostname") has been submitted
root@206fe0796da4:~# cat hostname.o1
206fe0796da4
```

For a persistent container that you can run multiple commands against:

```
$ docker run --name sge -d kgutwin/simple-sge sleep infinity
bc644d46ae13997ac5db07b8e2b7df092d63a680df4bbc06227299c6adaecc3f
$ docker exec -t -u sgeadmin sge bash -i -c "qstat -f"
queuename                      qtype resv/used/tot. load_avg arch          states
---------------------------------------------------------------------------------
all.q@bc644d46ae13             BIP   0/0/1          0.40     lx-amd64      
```

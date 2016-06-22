#!/bin/bash

cd /opt/sge
./inst_sge -m -x -s -auto util/install_modules/inst_template.conf
. /etc/profile.d/sge_settings.sh
cd $HOME

qconf -as `hostname`
qconf -mattr queue shell_start_mode unix_behavior all.q

update_conf() {
    TMPF=`mktemp`
    cat > $TMPF <<EOF
#!/bin/sh
sed -ri "$1" \$1
EOF
    chmod a+x $TMPF
    EDITOR="$TMPF" qconf -m$2
    rm -f $TMPF
}

# allow root to qsub (yes, it's a security hole but it simplifies the container)
update_conf "/min_/s/100/0/; s/posix_compliant/unix_behavior/" conf

# shrink scheduling interval for faster response
update_conf "/schedule_interval/s/[0-9]+:[0-9]+:[0-9]+/0:0:2/" sconf

# finalize
if [ -z "$1" ]; then
    exec /bin/bash
else
    exec "$@"
fi

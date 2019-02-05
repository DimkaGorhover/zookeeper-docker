sed -i -r 's|#(log4j.appender.ROLLINGFILE.MaxBackupIndex.*)|\1|g' /opt/zk/conf/log4j.properties
sed -i -r 's|#autopurge|autopurge|g' /opt/zk/conf/zoo.cfg
/opt/zk/bin/zkServer.sh start-foreground

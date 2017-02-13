PORT=6613
JAVA="/usr/java/jdk1.7.0_79/bin/java"

ORQUESTADOR=orchestrator-1.3.12.jar
TRANSMISOR=connectorservice-1.3.6.jar
REINJECTOR=reinjector-service-1.2.0.jar
TIMEZONE=America/Panama

cd $HOME/bin
stop.sh ${PORT}
echo Levantando servicio monitor:
echo ----------------------------
nohup ./pcom004p -${PORT} +d$HOME/var/log > /dev/null &


echo Levantando orquestador
echo ----------------------------
nohup ${JAVA} -Duser.timezone="${TIMEZONE}" -jar -Xms10M -Xmx80M -XX:MaxPermSize=20m -server ${ORQUESTADOR} -monitorHost localhost -monitorPort ${PORT} -serviceName ORC01* -poolSize 25  -hotdeploy  -asyncCommands -loggerlevel 0  > /dev/null &

echo Levantando transmisor
echo ----------------------------
nohup ${JAVA} -Djavax.net.ssl.trustStore=hub_keystore -Djavax.net.ssl.trustStorePassword=as123456 -Dhttps.protocols=TLSv1 -Duser.timezone="${TIMEZONE}" -jar -Xms10M -Xmx200M -XX:MaxPermSize=50m -server  ${TRANSMISOR} -monitorHost localhost -monitorPort ${PORT} -serviceName TRANS* -poolSize 30 -loggerlevel 0 -corelog > /dev/null &

echo Levantando reinjector
echo ----------------------------
nohup ${JAVA} -Duser.timezone="${TIMEZONE}" -jar -Xms10M -Xmx50M -XX:MaxPermSize=10m -server  ${REINJECTOR} -monitorHost localhost -monitorPort ${PORT} -serviceName REINJ* -poolSize 50 -loggerlevel 0 > /dev/null &

echo Procesos en ejecucion:
echo ----------------------
echo
ps -f | grep -v grep | grep -v bash | grep -v ps
echo


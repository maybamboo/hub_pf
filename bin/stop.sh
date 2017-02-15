MONITOR=pcom004

ORQUESTADOR=ORC01
TRANSMISOR=TRANS
REINJECTOR=REINJ

kill -9 `ps x | grep ${MONITOR} | grep -v grep | awk '{print $1}'`
kill -9 `ps x | grep ${ORQUESTADOR} | grep -v grep | awk '{print $1}'`
kill -9 `ps x | grep ${TRANSMISOR} | grep -v grep | awk '{print $1}'`
kill -9 `ps x | grep ${REINJECTOR} | grep -v grep | awk '{print $1}'`

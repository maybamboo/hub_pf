<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="/">	
	   <message>
			<header>
				<msg_type>RSNP01</msg_type>				
				<xsl:copy-of select="/request-context/request/message/header/id_trx_rec/self::node()"/>
				<id_trx_eft><xsl:value-of select="/request-context/services-responses/notificacion_pago/id_trx_eft/response/data/Results/Row/NEXTVAL" /></id_trx_eft>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_eps/self::node()"/>
				<xsl:copy-of select="/request-context/request/message/header/company_id/self::node()"/>	

				<payment_date>
					<xsl:value-of select="current-dateTime()" />
				</payment_date>

			</header>
			<body>
				<!--Indicar que hay un error en el pago y se debe revisar-->
				<status_code>CEF116</status_code>
				<status_desc>El monto total a pagar excede la deuda total del cliente y su servicio asociado</status_desc>
			</body>
		</message>		
	</xsl:template>	
</xsl:stylesheet>
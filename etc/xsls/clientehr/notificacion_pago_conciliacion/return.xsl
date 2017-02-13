<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

				
	<xsl:template match="/">
			
		<message>
			<header>
				<msg_type>RNP01</msg_type>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_rec/self::node()" />
				<id_trx_eft><xsl:value-of select="/request-context/services-responses/notificacion_pago_conciliacion/id_trx_pago_eft/response/data/Results/Row/NEXTVAL" /></id_trx_eft>
				<id_trx_eps></id_trx_eps>
				<xsl:copy-of select="/request-context/request/message/header/company_id/self::node()" />
				<xsl:copy-of select="/request-context/request/message/header/payment_date/self::node()" />
			</header>
			<body>
				<status_code>0</status_code>
				<status_desc>OK</status_desc>
					<payment>
						<service_id><xsl:value-of select="/request-context/request/message/body/payment/service_id" /></service_id>
						<document_id><xsl:value-of select="/request-context/request/message/body/payment/document_id" /></document_id>
						<status_code>0</status_code>
						<status_desc>OK</status_desc>
					</payment>
			</body>
		</message>
						
	</xsl:template>
</xsl:stylesheet>
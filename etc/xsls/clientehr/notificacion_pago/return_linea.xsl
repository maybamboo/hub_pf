<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="/">	
	   <message>
			<header>
				<msg_type>RSNP01</msg_type>				
				<xsl:copy-of select="/request-context/request/message/header/id_trx_rec/self::node()"/>
				<id_trx_eft><xsl:value-of select="/request-context/services-responses/notificacion_pago/id_trx_eft/response/data/Results/Row/NEXTVAL" /></id_trx_eft>				
				<id_trx_eps><xsl:value-of select="/request-context/services-responses/notificacion_pago/transformarResp/response/data/message/header/id_trx_eps"/></id_trx_eps>
				<xsl:copy-of select="/request-context/request/message/header/company_id/self::node()"/>	

				<payment_date>
					<xsl:value-of select="current-dateTime()" />
				</payment_date>


			</header>

			<body>
				<!--Indicar que hay un error en el pago y se debe revisar-->
				<status_code>0</status_code>
				<status_desc>OK</status_desc>


				<xsl:variable name="payment" select="/request-context/services-responses/notificacion_pago/valida_pagos_bd/response/data"/>

				<xsl:for-each select="$payment">
					<payment>
						<service_id><xsl:value-of select="Results/Row/ID_SERVICIO"/></service_id>
						<!--Se devuelve el doc_id obtenido de base de datos, independiente de que no haya sido enviado en la SNP01-->
						<document_id><xsl:value-of select="Results/Row/DOC_ID"/></document_id>
						<status_code>0</status_code>
						<status_desc>OK</status_desc>
					</payment>

				</xsl:for-each>
			</body>
			
		</message>		
	</xsl:template>	
</xsl:stylesheet>
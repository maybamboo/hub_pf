<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<msg_type>RIPHUB</msg_type>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_origin" />
				<xsl:copy-of select="/request-context/request/message/header/company_id" />
				<xsl:copy-of select="/request-context/request/message/header/collector_id" />
				<xsl:copy-of select="/request-context/request/message/header/date" />
			</header>
			<body>
			
			<xsl:choose>
			
				<xsl:when test="/request-context/services-responses/intencion_pago/intencionpago/response/code != '0' or format-number(sum(/request-context/services-responses/intencion_pago/intencionpago/response/data/Results/Row/RETORNO),0) != 0 or /request-context/services-responses/intencion_pago/intencionpago/response/data = -1">
			
					<status_code>CEF202</status_code>
					<status_desc>DOC_ID INVALIDO</status_desc>
					<id_trx_eft><xsl:value-of select="/request-context/services-responses/intencion_pago/idtrxeft/response/data/Results/Row/NEXTVAL" /></id_trx_eft>
					
							
				</xsl:when>
				<xsl:otherwise>
				
					<status_code>0</status_code>
					<status_desc>OK</status_desc>
					<id_trx_eft><xsl:value-of select="/request-context/services-responses/intencion_pago/idtrxeft/response/data/Results/Row/NEXTVAL" /></id_trx_eft>
			
								
				</xsl:otherwise>
				
				</xsl:choose>
							
			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>
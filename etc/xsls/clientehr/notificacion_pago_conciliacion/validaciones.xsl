<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<msg_type>notificacion_pago_conciliacion</msg_type>
			</header>
			<body>
				
				<convenio><xsl:copy-of select="/request-context/services-responses/default/convenio/*"/></convenio>
	
				
				<id_trx_rec><xsl:value-of select="/request-context/request/message/header/id_trx_rec" /></id_trx_rec>
				<collector_id><xsl:value-of select="/request-context/request/message/body/collector_id" /></collector_id>
				<company_id><xsl:value-of select="/request-context/request/message/header/company_id" /></company_id>						
				<total_amount><xsl:value-of select="/request-context/request/message/body/total_amount" /></total_amount>
				<amount><xsl:value-of select="/request-context/request/message/body/payment/amount" /></amount>				
				<currency_code><xsl:value-of select="/request-context/request/message/header/currency_code" /></currency_code>
				<country_code><xsl:value-of select="/request-context/request/message/header/country_code" /></country_code>
				<xsl:copy-of select="/request-context/request/message/body/payment/document_id" />
				
			</body>		
		</message>
	</xsl:template>
</xsl:stylesheet>
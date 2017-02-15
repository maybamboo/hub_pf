<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<msg_type>RIPHUB</msg_type>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_origin" />
				<xsl:copy-of select="/request-context/request/message/header/company_id" />
				<xsl:copy-of select="/request-context/request/message/header/date" />
			</header>
			<body>
				<status_code>CEF101</status_code>
				<status_desc>Problemas al consultar convenio.</status_desc>
				<id_trx_eft><xsl:value-of select="/request-context/services-responses/intencion_pago/idtrxeft/response/data/Results/Row/NEXTVAL" /></id_trx_eft>								
			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>
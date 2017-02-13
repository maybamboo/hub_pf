<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<type_msg>RCOMPGO</type_msg>													
				<date><xsl:value-of  select="current-dateTime()"/></date>				
			</header>
			<body>
				<xsl:choose>
				<xsl:when test="/request-context/services-responses/get_comprobante_pago/getComprobantePago/response/code = 0">
					<xsl:copy-of select="/request-context/services-responses/get_comprobante_pago/getComprobantePago/response/data/*"/>
				</xsl:when>
				<xsl:otherwise>
					<state_code>CEH2</state_code>
					<state_desc>En estos momentos el sistema no se encuentra disponible</state_desc>
				</xsl:otherwise>
				</xsl:choose>						
			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>
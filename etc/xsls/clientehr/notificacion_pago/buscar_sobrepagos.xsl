<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:template match="/">
		<xsl:variable name="response" select="/request-context/services-responses/notificacion_pago/valida_sobrepagos/response" />
		<response>
			<xsl:choose>	
				<xsl:when test="contains($response,'1')" >
					<code>1</code>
					<description>Existen sobrepagos</description>
				</xsl:when>
				<xsl:otherwise>
					<code>0</code>
					<description>No existen sobrepagos</description>
				</xsl:otherwise>

			</xsl:choose>
		</response>
	</xsl:template>
</xsl:stylesheet>
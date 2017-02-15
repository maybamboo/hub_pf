<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="xs">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">
		<response>
			<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>

			<xsl:variable name="count" select="count($payment[service_id ='' or string-length(service_id)>32])"/>
			<!--contamos cuantos pagos no son validos-->
			<xsl:choose>
				<xsl:when test="$count > 0">
					<code>1</code>
					<description>Existen service_id vacios o que exeden la longitud</description>	
				</xsl:when>
				<xsl:otherwise>
					<code>0</code>
					<description>Todos los service_id estan correctos</description>
				</xsl:otherwise>
			</xsl:choose>
		</response>
	</xsl:template>
</xsl:stylesheet>
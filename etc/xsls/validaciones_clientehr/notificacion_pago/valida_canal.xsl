<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="xs">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">
		<xsl:variable name="channel" select="/request-context/request/message/body/channel"/>
		<response>

			<xsl:choose>
				<xsl:when test="/request-context/request/message/body/convenio/msg/canales/canal[dsc_cnl=$channel]">
					<code>0</code>
					<description>El canal esta habilitado en el convenio</description>	
				</xsl:when>
				<xsl:otherwise>
					<code>1</code>
					<description>El canal no esta habilitado en el convenio</description>
				</xsl:otherwise>
			</xsl:choose>
		</response>
	</xsl:template>
</xsl:stylesheet>


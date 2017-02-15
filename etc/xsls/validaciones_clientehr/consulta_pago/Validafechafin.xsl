<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="xs">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>


	<xsl:template match="/">
		<response>
		<xsl:variable name="Date" select="/request-context/request/message/body/end_date"/>
		<xsl:variable name="Date" select="translate($Date,' ','T')"/>
		<xsl:choose>
		<xsl:when test="$Date = ''">
		    <code>0</code>
			<description>Ok</description>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="bool" select="$Date castable as xs:dateTime"/>
			<xsl:choose>
				<xsl:when test="$bool">
					<code>0</code>
					<description>Ok</description>
				</xsl:when>
				<xsl:otherwise>
					<code>1</code>
					<description>Fecha rango final invalida</description>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
		</xsl:choose>
		</response>
	</xsl:template>

</xsl:stylesheet>


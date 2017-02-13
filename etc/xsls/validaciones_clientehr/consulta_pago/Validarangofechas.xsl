<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="xs">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>


	<xsl:template match="/">
		<response>
		<xsl:variable name="Datei" select="/request-context/request/message/body/starting_date"/>
		<xsl:variable name="Datei" select="translate(translate(translate(translate($Datei,' ',''),'-',''), '/',''), ':','')"/>
		<xsl:variable name="Datef" select="/request-context/request/message/body/end_date"/>
		<xsl:variable name="Datef" select="translate(translate(translate(translate($Datef,' ',''),'-',''), '/',''), ':','')"/>
		<xsl:choose>			
			 <xsl:when test="$Datei &gt; $Datef">
				<code>1</code>
				<description>La fecha inicio invalida</description>	
			</xsl:when>
			<xsl:otherwise>
				<code>0</code>
				<description>Ok</description>				
			</xsl:otherwise>

		</xsl:choose>
		</response>
	</xsl:template>

</xsl:stylesheet>
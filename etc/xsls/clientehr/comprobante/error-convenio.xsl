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
				<state_code>CEF101</state_code>
				<state_desc>Problemas al consultar convenio.</state_desc>				
			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>

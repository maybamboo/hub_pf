<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<type_msg>RCONV-PORTAL</type_msg>
				<date><xsl:value-of  select="current-dateTime()"/></date>
			</header>
			<body>
				<state_code>0</state_code>
				<state_desc>OK</state_desc>
				<xsl:copy-of select="/request-context/services-responses/default/convenio"/>

			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>

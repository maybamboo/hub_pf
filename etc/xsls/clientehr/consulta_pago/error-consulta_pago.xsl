<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
       
		<message>
			<header>
				<msg_type>RSCP01</msg_type>
				<xsl:copy-of select="/request-context/request/message/header/company_id" />
				<date><xsl:value-of select="current-dateTime()" /></date>
        <xsl:copy-of select="/request-context/request/message/header/country_code" />
			</header>
			<body>
				<status_code>CEF200</status_code>
				<status_desc>Problemas al acceder a la base de datos</status_desc>
				<payments>
					<q>0</q>
					<q_total>0</q_total>
					<page>1</page>
					<total_page>1</total_page>
				</payments>
			</body>
		</message>
    													
	</xsl:template>
</xsl:stylesheet>						

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>				
				<msg_type>RSNP01</msg_type>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_rev/self::node()"/>
				<id_trx_eft_rev></id_trx_eft_rev>
				<company_id/>
				<reverse_date>
					<xsl:value-of select="current-dateTime()" />
				</reverse_date>
			</header>
			<body>
				<status_code>CEH1</status_code>
				<status_desc>Tipo de mensaje no válido.</status_desc>				
			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>
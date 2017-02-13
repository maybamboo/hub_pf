<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>				
				<msg_type>RSCD01</msg_type>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_rec/self::node()"/>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_eft/self::node()"/>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_eps/self::node()"/>					
				<date>
					<xsl:value-of select="current-dateTime()" />
				</date>
				<xsl:copy-of select="/request-context/request/message/header/currency_code/self::node()"/>
			</header>
			<body>
				<status_code>CEH1</status_code>
				<status_desc>Tipo de mensaje no válido.</status_desc>				
				<xsl:copy-of select="/request-context/request/message/body/contract_id/self::node()" />				
				<decimal_places></decimal_places>				
				<total_amount>0</total_amount>
				<debts>
					<q>0</q>
				</debts>
			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>
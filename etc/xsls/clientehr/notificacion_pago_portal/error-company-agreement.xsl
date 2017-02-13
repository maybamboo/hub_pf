<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<type_msg>RSCD01</type_msg>				
				<xsl:copy-of select="/request-context/request/message/header/id_trx_rec/self::node()"/>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_eft/self::node()"/>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_eps/self::node()"/>
						
				<date>
					<xsl:value-of select="current-dateTime()" />
				</date>

				<xsl:copy-of select="/request-context/request/message/header/currency_code/self::node()"/>
			</header>
			<body>
				<status_code>CEF103</status_code>
				<status_desc>Empresa no existe en el convenio indicado.</status_desc>
				<contract_id>
					<xsl:value-of select="/request-context/request/message/body/contract_id" />
				</contract_id>
				<decimal_places>0</decimal_places>
				<total_amount>0</total_amount>
				<debts>
					<q>0</q>
				</debts>
			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>



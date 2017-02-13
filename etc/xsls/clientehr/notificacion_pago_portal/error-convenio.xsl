<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<type_msg>RSCD01</type_msg>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_rec/self::node()"/>										
				<date><xsl:value-of  select="current-dateTime()"/></date>
				<money_code><xsl:value-of select="/request-context/request/message/header/money_code" /></money_code>
			</header>
			<body>
				<state_code>CEF101</state_code>
				<state_desc>Problemas al consultar convenio.</state_desc>
				<agreement_id><xsl:value-of select="/request-context/request/message/body/agreement_id" /></agreement_id>
				<number_decimal>0</number_decimal>
				<total_amount>0</total_amount>
				<debts>
					<quantity>0</quantity>
				</debts>
			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>

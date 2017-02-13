<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="/">	
	   <message>
			<header>
				<msg_type>RSRP01</msg_type>				
				<xsl:copy-of select="/request-context/request/message/header/id_trx_rev/self::node()"/>
				<id_trx_eft_rev><xsl:value-of select="/request-context/services-responses/reversa_pagos/id_trx_eft_rev/response/data/Results/Row/NEXTVAL" /></id_trx_eft_rev>
				<xsl:copy-of select="/request-context/request/message/header/company_id/self::node()"/>
				<reverse_date>
					<xsl:value-of select="current-dateTime()" />
				</reverse_date>
			</header>

			<body>
				<status_code>CER302</status_code>
				<status_desc>No se pudo realizar la reversa del pago. Por favor intente en unos segundos.</status_desc>
			</body>
			
		</message>		
	</xsl:template>	
</xsl:stylesheet>
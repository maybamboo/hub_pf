<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>				
				<msg_type>RSNP01</msg_type>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_rec/self::node()"/>
				<!--Este tag se define, ya que no siempre vendrá en la consulta, y si no va en la respuesta obtendremos un mensaje de error-->
				<id_trx_eft></id_trx_eft>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_eps/self::node()"/>			
				<company_id/>
				<payment_date>
					<xsl:value-of select="current-dateTime()" />
				</payment_date>
			</header>
			<body>
				<status_code>CEH1</status_code>
				<status_desc>Tipo de mensaje no válido.</status_desc>				
			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>

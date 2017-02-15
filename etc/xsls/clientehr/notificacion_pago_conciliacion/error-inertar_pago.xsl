<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="/">	
	   <message>
			<header>
				<msg_type>RNP01</msg_type>
				<xsl:copy-of
					select="/request-context/request/message/header/id_trx_rec/self::node()" />
				<id_trx_eft>
					<xsl:value-of
						select="/request-context/services-responses/notificacion_pago/id_trx_pago_eft/response/data/Results/Row/NEXTVAL" />
				</id_trx_eft>
				<id_trx_eps></id_trx_eps>

				<xsl:copy-of select="/request-context/request/message/header/company_id/self::node()" />
				<xsl:copy-of select="/request-context/request/message/header/payment_date/self::node()" />
			</header>
			<body>
				<!--Indicar que hay un error en el pago y se debe revisar-->
				<status_code>CEH16</status_code>
				<status_desc>No se pudo realizar la notificación de pago. Por favor intente en unos segundos.</status_desc>	


			</body>
		</message>		
	</xsl:template>	
</xsl:stylesheet>
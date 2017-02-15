<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="request_message" select="/request-context/request/message" />
		
	<xsl:template match="/">


			<transmission>
				<type>basedatos</type>
				<properties>
					<datasource>bd_hub_trx</datasource>
				</properties>


				<xsl:variable name="payment" select="/request-context/request/message/body"/>
				<data>
					<!--Se usan los datos del primer pago-->
					CALL PKG_PAGO.ACTUALIZA_DEUDA(
						<!--client_id-->
						'<xsl:value-of select="$payment/payment/client_id"/>',
						<!--service_id-->
						'<xsl:value-of select="$payment/payment/service_id"/>',
						<!--total_amount-->
						<xsl:value-of select="$payment/total_amount"/>,
						'<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />'
					)
				</data>			

			</transmission>
					
	</xsl:template>
</xsl:stylesheet>
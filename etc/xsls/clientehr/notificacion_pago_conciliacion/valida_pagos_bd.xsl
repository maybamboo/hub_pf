<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<transmission>
			<type>basedatos</type>			
			<properties>
				<datasource>hrdemo</datasource>
			</properties>

			<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>

			<!--Se valida cada pago que venga en el mensaje-->
			<xsl:for-each select="$payment">
				<data>
					CALL PKG_PAGO.VALIDA_PAGO(
					<!--id_servicio-->
					'<xsl:value-of select="service_id" />',
					<!--id_cliente-->					
					'<xsl:value-of select="client_id" />',
					<!--id_folio-->
					'<xsl:value-of select="folio" />',
					<!--doc_id-->
					'<xsl:value-of select="document_id" />',
					<!--total_cuota-->
					'<xsl:value-of select="amount" />')
				</data>

  			</xsl:for-each>
		</transmission>

	</xsl:template>

</xsl:stylesheet>

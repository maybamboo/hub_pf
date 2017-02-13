<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<transmission>
			<type>basedatos</type>			
			<properties>
				<datasource>bd_hub_trx</datasource>
			</properties>

			<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>
                        <xsl:variable name="recaudador" select="/request-context/request/message/body/collector_id"/>
                         <xsl:variable name="convenio" select="/request-context/request/message/body/contract_id"/>


			<!--Se valida cada pago que venga en el mensaje-->
			<xsl:for-each select="$payment">
				<xsl:variable name="position" select="position()"/>
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
					<!--RECAUDADOR_id-->
					'<xsl:value-of select="$recaudador" />',
					<!--CONVENIO_id-->
					'<xsl:value-of select="$convenio" />',
					<!--position-->
					'<xsl:value-of select="$position"/>',
					<!--cantidad de pag's id requeridos-->
					<xsl:choose>
						<!--En el flujo de validaciones se valida que el tipo de pago coincida con el medio de pago-->
						<xsl:when test="/request-context/request/message/body/payment_type = 'PM'">
							'<xsl:value-of select="count(additional_data/add_data[substring-before(type,'-')='MP'])"/>',
						</xsl:when>
						<xsl:otherwise>
							'1',
						</xsl:otherwise>
					</xsl:choose>
					'<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />')
				</data>




  			</xsl:for-each>
		</transmission>

	</xsl:template>

</xsl:stylesheet>

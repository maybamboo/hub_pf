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
			<xsl:variable name="convenio" select="/request-context/services-responses/default/convenio/msg/reglas_pago/criteriosDuplicidad"/>

			<!--Se valida cada pago que venga en el mensaje-->
			<xsl:for-each select="$payment">
				<data>
					CALL PKG_PAGO.VERIFICAR_PAGOS_DUPLICADOS(

					<xsl:choose>
						<xsl:when test="$convenio[campo='FOLIO']">
							'<xsl:value-of select="folio"/>',
						</xsl:when>
						<xsl:otherwise>
							'',
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="$convenio[campo='MONTO_NETO']">
							'<xsl:value-of select="amount"/>',
						</xsl:when>
						<xsl:otherwise>
							'',
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="$convenio[campo='ID_CLIENTE']">
							'<xsl:value-of select="client_id"/>',
						</xsl:when>
						<xsl:otherwise>
							'',
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="$convenio[campo='FECHA_TRX']">
							'<xsl:value-of select="substring(/request-context/request/message/header/payment_date,1,10)" />',
						</xsl:when>
						<xsl:otherwise>
							'',
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="$convenio[campo='RECAUDADOR_ID']">
							'<xsl:value-of select="collector_id"/>',
						</xsl:when>
						<xsl:otherwise>
							'',
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="$convenio[campo='ID_TRX_REC']">
							'<xsl:value-of select="id_trx_rec"/>',
						</xsl:when>
						<xsl:otherwise>
							'',
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="$convenio[campo='ID_SERVICIO']">
							'<xsl:value-of select="service_id"/>',
						</xsl:when>
						<xsl:otherwise>
							'',
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="$convenio[campo='DOC_ID']">
							'<xsl:value-of select="document_id"/>',
						</xsl:when>
						<xsl:otherwise>
							'',
						</xsl:otherwise>						
					</xsl:choose>
					'<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />'
					<!--Se debe agregar el document_id-->
					)
				</data>

  			</xsl:for-each>
		</transmission>

	</xsl:template>

</xsl:stylesheet>

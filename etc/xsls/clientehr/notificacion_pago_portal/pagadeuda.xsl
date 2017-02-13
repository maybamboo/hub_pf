<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<transmission>
			<type>basedatos</type>
			<properties>
				<datasource>bd_hub_trx</datasource>
			</properties>
			<xsl:for-each select="/request-context/request/message/body/payment">
				<xsl:variable name="monto_total"
					select="/request-context/services-responses/notificacion_pago_portal/consultadeuda/response/data/Results/Row[position()]/MONTO_TOTAL" />

				<xsl:choose>
					<xsl:when test="amount  = $monto_total">
						<data>
							CALL PKG_NOTIFICACION_PAGO.NOTIFICAR_PAGO(
							'<xsl:value-of select="/request-context/request/message/header/id_trx_rec" />',
							'<xsl:value-of select="/request-context/request/message/header/id_trx_eft" />',													
							'<xsl:value-of select="service_id" />',
							'<xsl:value-of select="client_id" />',
							 <xsl:value-of select="document_id" />,
							 <xsl:value-of select="folio" />,
							'<xsl:value-of select="/request-context/request/message/header/company_id" />',
							'<xsl:value-of select="/request-context/request/message/header/payment_date" />',
							'<xsl:value-of select="/request-context/request/message/header/country_code" />',
							'<xsl:value-of select="/request-context/request/message/header/currency_code" />',
							'<xsl:value-of select="/request-context/request/message/body/contract_id" />',
							'<xsl:value-of select="/request-context/request/message/body/collector_id" />',
							'<xsl:value-of select="/request-context/request/message/body/settlement_date" />',
							'<xsl:value-of select="/request-context/request/message/body/channel" />',
							'<xsl:value-of select="/request-context/request/message/body/transmitter" />',
							'<xsl:value-of select="/request-context/request/message/body/payment_type" />',
							'<xsl:value-of select="/request-context/request/message/body/decimal_places" />',
						<!--	<xsl:value-of select="$monto_total" />,  -->
							<xsl:value-of select="amount" />,
							'<xsl:value-of select="/request-context/request/message/header/payment_status" />',
							'<xsl:value-of select="/request-context/request/message/header/rejection_status" />',
							'<xsl:value-of select="/request-context/request/message/body/payment_method" />',
							'<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />'
							
							)
						</data>
					</xsl:when>
				</xsl:choose>

			</xsl:for-each>
		</transmission>
	</xsl:template>
</xsl:stylesheet>

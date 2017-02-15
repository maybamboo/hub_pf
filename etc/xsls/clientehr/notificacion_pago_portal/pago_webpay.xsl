<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<transmission>
			<type>basedatos</type>
			<properties>
				<datasource>bd_hub_trx</datasource>
			</properties>
		<!--	<xsl:for-each select="/request-context/request/message/body/payment">   -->
				<xsl:variable name="monto_total"
					select="/request-context/services-responses/notificacion_pago_portal/consultadeuda/response/data/Results/Row[position()]/MONTO_TOTAL" />

		<!--		<xsl:choose>
					<xsl:when test="amount  = $monto_total">     -->
						<data>
							CALL PKG_NOTIFICACION_PAGO.PAGO_TRANSBANK(
							"<xsl:value-of select="/request-context/request/message/header/id_trx_eft" />",
							"<xsl:value-of select="/request-context/request/message/body/payment/additional_data/add_data[type='tbk_monto']/value" />",
							"<xsl:value-of select="/request-context/request/message/body/payment/additional_data/add_data[type='tbk_tarjeta']/value" />",
							"<xsl:value-of select="/request-context/request/message/body/payment/additional_data/add_data[type='tbk_tipo_pago']/value" />",
							"<xsl:value-of select="/request-context/request/message/body/payment/additional_data/add_data[type='tbk_cod_autorizacion']/value" />",
							"<xsl:value-of select="/request-context/request/message/body/payment/additional_data/add_data[type='tbk_cuotas']/value" />",
							"<xsl:value-of select="/request-context/request/message/body/payment/additional_data/add_data[type='tbk_id_trx']/value" />",
							"<xsl:value-of select="/request-context/request/message/body/payment/additional_data/add_data[type='tbk_fecha_transaccion']/value" />",
							"<xsl:value-of select="/request-context/request/message/body/payment/additional_data/add_data[type='tbk_hora_pago']/value" />",
							"<xsl:value-of select="/request-context/request/message/body/payment/additional_data/add_data[type='tbk_fecha_contable']/value" />",
							"<xsl:value-of select="/request-context/request/message/body/payment/additional_data/add_data[type='tbk_est_pgo_tbk']/value" />",
							"<xsl:value-of select="/request-context/request/message/body/payment/additional_data/add_data[type='tbk_codigo_comercio']/value" />",
							"<xsl:value-of select="/request-context/request/message/body/payment/additional_data/add_data[type='tbk_orden_compra']/value" />")
						</data>
			<!--		</xsl:when>
				</xsl:choose> -->

		<!--	</xsl:for-each>   -->
		</transmission>
	</xsl:template>
</xsl:stylesheet>

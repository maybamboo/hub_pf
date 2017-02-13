<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">


		<transmission>
			<type>basedatos</type>
			<properties>
				<datasource>bd_hub_trx</datasource>
			</properties>
			<data>
				update pago set estado_notificacion= 0, id_trx_eps = '<xsl:value-of select="/request-context/services-responses/notificacion_pago/transformarResp/response/data/message/header/id_trx_eps"/>' where COD_EMPRESA_HOLDING = '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />' and id_trx_eft='<xsl:value-of select="/request-context/request/message/body/id_trx_eft"/>'
			</data>
		</transmission>
	</xsl:template>
</xsl:stylesheet>
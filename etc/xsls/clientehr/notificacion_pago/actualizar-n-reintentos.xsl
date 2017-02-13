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
				update pago set reintentos= reintentos + 1 where COD_EMPRESA_HOLDING = '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />' and id_trx_eft='<xsl:value-of select="/request-context/request/message/body/id_trx_eft"/>'
			</data>
		</transmission>
	</xsl:template>
</xsl:stylesheet>
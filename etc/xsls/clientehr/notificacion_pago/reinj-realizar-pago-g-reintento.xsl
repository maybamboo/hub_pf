<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="request_message" select="/request-context/request/message" />
		
	<xsl:template match="/">

			<transmission>
				<type>basedatos</type>
				<properties>
					<datasource>gestion_hrpf</datasource>
				</properties>
				<data>
					update pago set estado_notificacion= 0, id_trx_eps = '<xsl:value-of select="/request-context/services-responses/notificacion_pago/transformarResp/response/data/message/header/id_trx_eps"/>' where COD_EMPRESA_HOLDING = '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />' and id_trx_eft='<xsl:value-of select="/request-context/services-responses/notificacion_pago/id_trx_eft/response/data/Results/Row/NEXTVAL" />'
				</data>
			</transmission>
	</xsl:template>
</xsl:stylesheet>

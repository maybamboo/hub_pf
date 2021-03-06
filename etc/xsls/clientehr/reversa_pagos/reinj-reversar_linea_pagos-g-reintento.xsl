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


			<xsl:variable name="body" select="/request-context/request/message/body"/>
			<xsl:variable name="reversa_ws" select="/request-context/services-responses/reversa_pagos/transformarResp/response/data"/>
			
     					<data>

				UPDATE PAGO SET ESTADO_PAGO=4,ID_TRX_REV='<xsl:value-of select="$body/id_trx_rev"/>',ID_TRX_EFT_REV='<xsl:value-of select="$body/id_trx_eft_rev"/>',ID_TRX_EPS_REV='<xsl:value-of select="$reversa_ws/message/header/id_trx_eps_rev"/>', ESTADO_NOTIFICACION_REVERSA =0, REVERSE_TRX = SYSDATE WHERE  COD_EMPRESA_HOLDING = '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />' and  ltrim(id_trx_rec,'0') = ltrim('<xsl:value-of select="$body/id_trx_rec"/>','0')
			</data>

		</transmission>
					
	</xsl:template>
</xsl:stylesheet>

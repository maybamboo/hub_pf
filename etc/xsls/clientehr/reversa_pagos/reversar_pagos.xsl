<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<transmission>
			<type>basedatos</type>
			<properties>
				<datasource>bd_hub_trx</datasource>
			</properties>
			<xsl:variable name="header" select="/request-context/request/message/header"/>
         	<data>
				UPDATE PAGO SET ESTADO_PAGO=4,ID_TRX_REV='<xsl:value-of select="$header/id_trx_rev"/>',ID_TRX_EFT_REV='<xsl:value-of select="/request-context/services-responses/reversa_pagos/id_trx_eft_rev/response/data/Results/Row/NEXTVAL"/>', REVERSE_TRX = SYSDATE, ESTADO_NOTIFICACION_REVERSA = 1 WHERE COD_EMPRESA_HOLDING = '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />' and ltrim(id_trx_rec,'0') = ltrim('<xsl:value-of select="$header/id_trx_rec"/>','0')		
			</data>
		</transmission>
	</xsl:template>
</xsl:stylesheet>
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
				 <data>
					CALL PKG_CONSULTA.CONSULTA_DEUDA('<xsl:value-of select="service_id" />','<xsl:value-of select="client_id" />',<xsl:value-of select="folio" />, '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />')				
				</data>  
			</xsl:for-each>
		</transmission>
	</xsl:template>
</xsl:stylesheet>

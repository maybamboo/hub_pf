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
				CALL PKG_CONSULTA.OBTIENE_DOC_ID('<xsl:value-of select="count(/request-context/services-responses/consulta_deuda/transformarResp/response/data/message/body/debts/debt)" />') 
			</data>					
		</transmission>

	</xsl:template>
</xsl:stylesheet>


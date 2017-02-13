<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<transmission>
			<type>basedatos</type>
			<properties>
				<datasource>bd_hub_trx</datasource>
			</properties>

			<xsl:variable name="body" select="/request-context/request/message/body"/>
         	<data>
				CALL PKG_CONSULTA.VALIDA_PARAMETROS_DEUDA('<xsl:value-of select="$body/service_id" />','<xsl:value-of select="$body/client_id" />','<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />')				
			</data>
			<!--De momento el folio no va incluido en la validación-->
			<!--,'<xsl:value-of select="folio" />'-->  

		</transmission>
	</xsl:template>
</xsl:stylesheet>

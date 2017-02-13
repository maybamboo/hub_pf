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
				select distinct id_servicio from DOCUMENTO where COD_EMPRESA_HOLDING='<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />' and id_cliente=&#39;<xsl:value-of select="$body/client_id"/>&#39;		
			</data>
			<!--De momento el folio no va incluido en la validación-->
			<!--,'<xsl:value-of select="folio" />'-->  

		</transmission>
	</xsl:template>
</xsl:stylesheet>

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
				select sum(monto_pago) as SUMA from pago where COD_EMPRESA_HOLDING = '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />' and ltrim(id_trx_rec,'0') = ltrim('<xsl:value-of select="$header/id_trx_rec"/>','0')	
			</data>


		</transmission>
	</xsl:template>
</xsl:stylesheet>
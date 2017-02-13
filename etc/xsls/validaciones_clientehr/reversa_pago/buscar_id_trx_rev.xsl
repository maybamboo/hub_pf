<?xml version="1.0" encoding="ISO-8859-1" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<transmission>
			<type>basedatos</type>
			<properties>
				<datasource>bd_hub_trx</datasource>
			</properties>
			
			<data>
				select 1 as existe from pago where 
				COD_EMPRESA_HOLDING='<xsl:value-of select="/request-context/request/message/body/convenio/msg/empresa_holding/cod_emp" />' and
				ltrim(id_trx_rev,'0') = ltrim('<xsl:value-of select="/request-context/request/message/body/id_trx_rev" />','0')
				and recaudador_id = '<xsl:value-of select="/request-context/request/message/body/collector_id" />' and rownum=1
			</data>
		</transmission>
	</xsl:template>
</xsl:stylesheet>

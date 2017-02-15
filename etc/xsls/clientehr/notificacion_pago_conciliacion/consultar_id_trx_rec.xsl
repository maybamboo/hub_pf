<?xml version="1.0" encoding="ISO-8859-1" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<transmission>
			<type>basedatos</type>
			<properties>
				<datasource>hrdemo</datasource>
			</properties>
			
			<data>
				select pag_id,id_trx_eft,doc_id,id_servicio,estado_notificacion,id_trx_eps,tipo_servicio,estado_pago from pago where ltrim(id_trx_rec,'0') = ltrim('<xsl:value-of select="/request-context/request/message/header/id_trx_rec" />','0')
				and recaudador_id = '<xsl:value-of select="/request-context/request/message/body/collector_id" />' and id_servicio='<xsl:value-of select="/request-context/request/message/body/payment/service_id" />' and 
				id_cliente='<xsl:value-of select="/request-context/request/message/body/payment/client_id" />' and folio='<xsl:value-of select="/request-context/request/message/body/payment/folio" />'
			</data>
		</transmission>
	</xsl:template>
</xsl:stylesheet>

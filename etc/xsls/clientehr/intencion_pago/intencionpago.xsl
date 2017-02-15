<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<transmission>
			<type>basedatos</type>
			<properties>
				<datasource>bd_hub_trx</datasource>
			</properties>
				<xsl:for-each select="/request-context/request/message/body/parameters">						
						<data>
							CALL PKG_NOTIFICACION_PAGO.INTENCION_PAGO(
							'<xsl:value-of select="/request-context/services-responses/intencion_pago/idtrxeft/response/data/Results/Row/NEXTVAL" />',
							'<xsl:value-of select="parameter[name/text()='doc_id']/value" />',							
							'<xsl:value-of select="parameter[name/text()='fecha_intencion']/value" />',
							'<xsl:value-of select="/request-context/request/message/header/collector_id" />',														
							'<xsl:value-of select="/request-context/request/message/header/company_id" />',
							'<xsl:value-of select="parameter[name/text()='cod_convenio']/value" />',
							'<xsl:value-of select="parameter[name/text()='id_servicio']/value" />',
							'<xsl:value-of select="parameter[name/text()='id_cliente']/value" />',
							'<xsl:value-of select="parameter[name/text()='folio']/value" />',
							<xsl:value-of select="parameter[name/text()='monto']/value" />,
							'<xsl:value-of select="/request-context/request/message/body/transmitter" />',
							'<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />')
						</data>				
			</xsl:for-each>
		</transmission>
	</xsl:template>
</xsl:stylesheet>
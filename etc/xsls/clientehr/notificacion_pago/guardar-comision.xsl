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
			
			<data>
			CALL PKG_COMISION.ADD_COMISION(
			 '<xsl:value-of select="substring(/request-context/request/message/header/payment_date,1,10)" />',
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/comisiones/tipoComisionRecaudador/dsc_val_atr" />',
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/comisiones/tipoComisionEPS/dsc_val_atr" />',
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/comisiones/tipoComisionEFT/dsc_val_atr" />',			  
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/comisiones/comisionLineaFijaRecaudador/valor" />',
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/comisiones/comisionLineaFijaEPS/valor" />',
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/comisiones/comisionLineaFijaEFT/valor" />',
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/comisiones/comisionLineaPorcentajeRecaudador/valor" />',
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/comisiones/comisionLineaPorcentajeEPS/valor" />',
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/comisiones/comisionLineaPorcentajeEFT/valor" />',
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/agreement-code" />',		
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/collector-id" />',
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/company-id" />',			  
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/collector-code" />',
			  '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/company-code" />'
			)						
			</data>
		</transmission>

	</xsl:template>
</xsl:stylesheet>
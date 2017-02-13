<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<transmission>
			<type>
				<xsl:value-of select="/request-context/services-responses/default/convenio/msg/reglas_consulta/tipoConector"/>
			</type>
			<xsl:copy-of select="/request-context/services-responses/default/convenio/msg/reglas_consulta/conector/properties"/>
			<xsl:copy-of select="/request-context/services-responses/consulta_deuda/transformar/response/data"/>
		</transmission>
	</xsl:template>
</xsl:stylesheet>
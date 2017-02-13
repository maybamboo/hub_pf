<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">

		<transmission>
			<xsl:choose>
				<xsl:when test="/request-context/request/message/header/msg_type = 'SRRP01'">
					<xsl:copy-of select="/request-context/request/message/body/transmission/*" />
				</xsl:when>
				<xsl:otherwise>
					<type><xsl:value-of select="/request-context/services-responses/default/convenio/msg/reglas_reversa/tipoConector"/></type>
					<xsl:copy-of select="/request-context/services-responses/default/convenio/msg/reglas_reversa/conector/properties"/>
					<xsl:copy-of select="/request-context/services-responses/reversa_pagos/transformar/response/data"/>
				</xsl:otherwise>
			</xsl:choose>
		</transmission>


	</xsl:template>
</xsl:stylesheet>

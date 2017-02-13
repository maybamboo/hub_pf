<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">

		<xsl:variable name="response" select="/request-context/services-responses/notificacion_pago/validar_pagos_mixtos/response" />

		<response>
			<xsl:choose>	
				<xsl:when test="contains($response,'1')" >
					<code>1</code>
					<description>Existen pagos mixtos incorrectos</description>
				</xsl:when>
				<xsl:otherwise>
					<code>0</code>
					<description>Los pagos mixtos estan correctos</description>
				</xsl:otherwise>
			</xsl:choose>
		</response>
	</xsl:template>
</xsl:stylesheet>
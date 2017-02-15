<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



	<xsl:template match="/">

		<xsl:variable name="response" select="/request-context/services-responses/notificacion_pago/validar_pagos_unicos/response" />

		<response>

			<xsl:choose>	

				<xsl:when test="contains($response,'1')" >
					<code>1</code>
					<description>Existen pagos duplicados</description>
				</xsl:when>

				<xsl:otherwise>
					<code>0</code>
					<description>Todos los pagos son únicos</description>
				</xsl:otherwise>

			</xsl:choose>

		</response>

	</xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="xs">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">
		<!--Tenemos que verificar si los formatos de las fechas son los mismos-->
		<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>

		<response>

			<xsl:for-each select="$payment">


				<xsl:variable name="monto_total" select="amount"/>
				<xsl:variable name="monto_acumulado" select="sum(additional_data/add_data[substring-before(type,'-')='MP']/value)"/>

				<xsl:choose>
					<!--Si se cumple la condicion significa que seria un pago parcial, lo cual no esta permitido-->
					<xsl:when test="$monto_acumulado != $monto_total">1</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>


		</response>
	</xsl:template>
</xsl:stylesheet>


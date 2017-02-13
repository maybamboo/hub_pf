<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="xs">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">
		<response>

			<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>

			<!--se suma el monto total de todas las deudas consultadas-->
			<xsl:variable name="suma_parcial" select="format-number(sum($payment/amount),0)" />

			<suma><xsl:value-of select="$suma_parcial"/></suma>

			<!--contamos cuantos pagos no son validos-->
			<xsl:choose>
				<xsl:when test="$suma_parcial != /request-context/request/message/body/total_amount">
					<code>1</code>
					<description>El total no coincide con la suma de los pagos</description>	
				</xsl:when>
				<xsl:otherwise>
					<code>0</code>
					<description>La total esta cuadrado con todos los pagos</description>
				</xsl:otherwise>
			</xsl:choose>
		</response>
	</xsl:template>
</xsl:stylesheet>
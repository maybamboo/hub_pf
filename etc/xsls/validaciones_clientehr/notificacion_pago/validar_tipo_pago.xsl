<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="xs">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:variable name="payment_type" select="/request-context/request/message/body/payment_type"/>
	<xsl:variable name="convenio" select="/request-context/request/message/body/convenio/msg/reglas_pago"/>

	<xsl:template match="/">
		<response>

			<xsl:choose>
				<xsl:when test="$payment_type = 'PP' and $convenio/pagosParciales = 0">
					<code>1</code>
					<description>Los pagos parciales no estan permitidos en el convenio</description>	
				</xsl:when>
				<xsl:when test="$payment_type = 'SP' and $convenio/sobrePagos = 0">
					<code>1</code>
					<description>Los sobrepagos no estan permitidos en el convenio</description>	
				</xsl:when>
				<xsl:when test="$payment_type = 'PM' and $convenio/pagosMixtos = 0">
					<code>1</code>
					<description>Los pagos mixtos no estan permitidos en el convenio</description>	
				</xsl:when>
				<xsl:when test="$payment_type = 'PD' and $convenio/duplicidadPagos = 0">
					<code>1</code>
					<description>Los pagos duplicados no estan permitidos en el convenio</description>	
				</xsl:when>
				<xsl:otherwise>
					<code>0</code>
					<description>El tipo de pago es valido segun el convenio</description>
				</xsl:otherwise>
			</xsl:choose>
		</response>
	</xsl:template>
</xsl:stylesheet>


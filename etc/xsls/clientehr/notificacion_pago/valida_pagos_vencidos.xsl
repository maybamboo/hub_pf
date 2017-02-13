<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="xs">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">
		<!--Tenemos que verificar si los formatos de las fechas son los mismos-->
		<!--Se quitan los guiones, ya que la comparacion se realiza numericamente-->
		<xsl:variable name="fecha_trx" select="translate(substring-before(/request-context/request/message/header/payment_date,'T'),'-','')"/>
		<xsl:variable name="payment" select="/request-context/services-responses/notificacion_pago/valida_pagos_bd/response/data"/>

		<!--El orden de las llamadas a los procedimientos sera el misom que el de las respuestas, por ende también sera el mismo que el de la peticion-->

		<response>
			<xsl:for-each select="$payment">
				<xsl:variable name="fecha_vcto" select="translate(Results/Row/FECHA_VCTO,'-','')"/>
				<xsl:choose>
					<xsl:when test="$fecha_vcto &lt; $fecha_trx">1</xsl:when><xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</response>
	</xsl:template>
</xsl:stylesheet>



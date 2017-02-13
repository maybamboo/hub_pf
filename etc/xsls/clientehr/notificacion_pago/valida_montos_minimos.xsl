<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="xs">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">
		<!--Tenemos que verificar si los formatos de las fechas son los mismos-->
		<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>
		<xsl:variable name="monto_minimo" select="/request-context/services-responses/default/convenio/msg/reglas_pago/monto_minimo/valor"/>


		<!--Se agrega para la comision en linea e impuestos-->
		<xsl:variable name="montos_actualizados" select="/request-context/services-responses/notificacion_pago/actualiza_montos/pagos/pago"/>

		<response>
			<!--El payment se utiliza como una referencia para obtener el position, pero podriamos haber usado cualquiera de los ciclos iterativos-->
			<xsl:for-each select="$payment">
				<xsl:variable name="position" select="position()"/>

				<!--Se agrega para la comision en linea e impuesto-->
				<!--El monto incluye el descuento de la cuota y el impuesto segun corresponda-->
				<xsl:variable name="monto_neto" select="$montos_actualizados[$position]/monto_neto"/>


				<xsl:choose>
					<!--Si se cumple la condicion significa que seria un pago parcial, lo cual no esta permitido-->
					<!--<xsl:when test="amount &lt; $monto_pago">1</xsl:when><xsl:otherwise>0</xsl:otherwise>-->
					<xsl:when test="$monto_neto &lt; $monto_minimo">1</xsl:when><xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>

		</response>
	</xsl:template>
</xsl:stylesheet>



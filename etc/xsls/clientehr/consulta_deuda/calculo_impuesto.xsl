<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:variable name="comision_linea" select="/request-context/services-responses/default/convenio/msg/reglas_generales/comision_linea"/>
	<xsl:variable name="impuesto" select="/request-context/services-responses/default/convenio/msg/reglas_generales/comision_linea/impuesto"/>
	<xsl:variable name="debts" select="/request-context/services-responses/consulta_deuda/transformarResp/response/data/message/body/debts/debt"/>
	<xsl:variable name="comisiones" select="/request-context/services-responses/consulta_deuda/calculo_comisiones_linea/comisiones/comision"/>

	<xsl:template match="/">

		<!--Se evalua si esta activada la comision en linea. Si no esta activada, entonces rellenamos con 0-->
		<impuestos>
			<xsl:choose>
				<xsl:when test="$comision_linea/habilitado = 1 and $impuesto/habilitado = 1">
					<xsl:variable name="porcentaje_impuesto" select="$impuesto/valor"/>

					<xsl:for-each select="$debts">
						<xsl:variable name="position" select="position()"/>
						<xsl:variable name="comision" select="$comisiones[$position]"/>
						<!--<xsl:variable name="monto_neto" select="net_amount"/>-->
	                    <!--<xsl:variable name="monto_bruto" select="$monto_neto + $comision"/>-->
	                    <!--Se debe revisar el tema de truncar y redondear-->
	                    <xsl:variable name="impuesto_sr" select="($comision * $porcentaje_impuesto) div 100"/>
	                    <impuesto><xsl:value-of select="round($impuesto_sr * 100) div 100"/></impuesto>

					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="$debts">
						<impuesto>0</impuesto>
					</xsl:for-each>

				</xsl:otherwise>
			</xsl:choose>
		</impuestos>
	</xsl:template>

</xsl:stylesheet>

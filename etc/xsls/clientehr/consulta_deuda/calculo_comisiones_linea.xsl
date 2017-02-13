<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="comision_linea" select="/request-context/services-responses/default/convenio/msg/reglas_generales/comision_linea" />
	<xsl:variable name="debts" select="/request-context/services-responses/consulta_deuda/transformarResp/response/data/message/body/debts/debt"/>

	<xsl:template match="/">

		<!--Se evalua si esta activada la comision en linea. Si no esta activada, entonces rellenamos con 0-->
		<comisiones>
			<xsl:choose>
				<xsl:when test="$comision_linea/habilitado = 1">
					<!--Se evalua si la comision es fija-->
					<xsl:choose>
						<xsl:when test="$comision_linea/tipo = 'fija'">
							<xsl:variable name="comision_fija" select="$comision_linea/valor"/>
							<xsl:for-each select="$debts">
								<comision><xsl:value-of select="$comision_fija"/></comision>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<!--la comision es porcentual-->
                        	<xsl:variable name="porcentaje" select="$comision_linea/valor"/>
                        	<xsl:for-each select="$debts">
                        		<xsl:variable name="monto_neto" select="net_amount"/>
                        		<!--Revisar el tema de truncar y redondear-->
                        		<xsl:variable name="comision_sr" select="($monto_neto * $porcentaje) div 100"/>
                        		<comision><xsl:value-of select="round($comision_sr * 100) div 100"/></comision>
                        	</xsl:for-each>            
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="$debts">
						<comision>0</comision>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</comisiones>

	</xsl:template>

</xsl:stylesheet>

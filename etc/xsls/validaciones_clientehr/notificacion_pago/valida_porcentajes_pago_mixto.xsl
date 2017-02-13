<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
			<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>
			<xsl:variable name="convenio" select="/request-context/request/message/body/convenio"/>

			<response>
				<!--Recorremos todos los pagos para ver si -->

				<xsl:for-each select="$payment">

					<!--Se recorren los medios de pago asociados a la cuota-->
					<xsl:variable name="monto" select="amount"/>


					<xsl:variable name="count">
						<xsl:for-each select="additional_data/add_data">

								<xsl:if test="substring-before(type,'-') = 'MP'">

									<xsl:variable name="medio_pago" select="substring-after(type,'-')"/>
									<xsl:variable name="valor" select="value"/>
									<xsl:variable name="porcentaje" select="($valor*100) div $monto"/>

									<xsl:variable name="porcentaje_convenio" select="$convenio/msg/reglas_pago/confPagosMixtos/medioPago[codigo=$medio_pago]/porcentaje"/>

									<!--Se puede dar el caso en que se este pasando un medio de pago que no está en la configuración de pagos mixtos, evaluar si se deberia obligar por interfaz a que asigne un valor a todos los medios de pago disponibles en el convenio-->

									<!--Se asume que el medio de pago esta configurado en la configuración de pagos mixtos-->
									<xsl:value-of select="$porcentaje"/>|<xsl:value-of select="$porcentaje_convenio"/>
									<xsl:choose>
										<!--Si encontramos el medio de pago-->
										<!--Considera el caso en que se esta usando como medio de pago mixto, un medio de pago que no se ha condigurado-->						 	
										<xsl:when test="($porcentaje_convenio = '') or ($porcentaje > $porcentaje_convenio)">1</xsl:when>
										<xsl:otherwise>0</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
						</xsl:for-each>
					</xsl:variable>

					<xsl:choose>
						<xsl:when test="contains($count,'1')">1</xsl:when><xsl:otherwise>0</xsl:otherwise>
					</xsl:choose>

				</xsl:for-each>			
			</response>
	</xsl:template>
</xsl:stylesheet>

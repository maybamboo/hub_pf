<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">


			<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>
			<xsl:variable name="channel" select="/request-context/request/message/body/channel"/>

			<response>
				<!--Recorremos todos los pagos para ver si -->

				<xsl:for-each select="$payment">

					<!--se recorren los medios de pago asociados a la cuota-->

					<xsl:variable name="count" >
						<xsl:for-each select="additional_data/add_data">

								<xsl:if test="substring-before(type,'-') = 'MP'">
									<xsl:variable name="valor" select="substring-after(type,'-')"/>
									<xsl:choose>
										<!--Si encontramos el medio de pago-->						 	
										<xsl:when test="/request-context/request/message/body/convenio/msg/canales/canal[dsc_cnl=$channel]/mediosPago[medioPago = $valor]">0</xsl:when><xsl:otherwise>1</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
						</xsl:for-each>

					</xsl:variable>

					<xsl:choose>
						<xsl:when test="$count > 0">1</xsl:when><xsl:otherwise>0</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>			
			</response>
	</xsl:template>

</xsl:stylesheet>


<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="pagos" select="/request-context/request/message/body/payment"/>
	<xsl:variable name="decimal_places" select="/request-context/request/message/body/decimal_places"/>

	<xsl:template match="/">


		<xsl:variable name="potencia">		
				<xsl:choose>					
					<xsl:when test="$decimal_places != ''">
						<xsl:call-template name="power-of-10">
							<xsl:with-param name="exponent" select="number($decimal_places)"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="power-of-10">
							<xsl:with-param name="exponent" select="0"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>			
		</xsl:variable>

		<pagos>
			<xsl:for-each select="$pagos">
				<xsl:variable name="additional_data" select="additional_data/add_data[substring-before(type,'-')= 'MP']"/>
				<pago>
					<xsl:for-each select="$additional_data">
					<!--Se asume que el type es MP-->
						<xsl:variable name="monto_bruto_sr" select="value div $potencia"/>
						<xsl:variable name="monto_bruto" select="round($monto_bruto_sr * 100) div 100"/>
						<medio_pago>															
							<monto_bruto><xsl:value-of select="$monto_bruto"/></monto_bruto>
						</medio_pago>
					</xsl:for-each>
				</pago>
			</xsl:for-each>								
		</pagos>

	</xsl:template>
	

	<xsl:template name="power-of-10">
	    <xsl:param name="exponent"/>
	    <xsl:param name="result" select="1"/>
	    <xsl:choose>
	        <xsl:when test="$exponent">
	            <xsl:call-template name="power-of-10">
	                <xsl:with-param name="exponent" select="$exponent - 1"/>
	                <xsl:with-param name="result" select="$result * 10"/>
	            </xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:value-of select="$result"/>
	        </xsl:otherwise>
	    </xsl:choose>
	</xsl:template>

</xsl:stylesheet>

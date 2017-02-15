<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">


			<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>

			<response>
				<!--Recorremos todos los pagos para ver si -->
				<xsl:for-each select="$payment">

						<xsl:choose>
							<xsl:when test="count($payment[service_id =current()/service_id and folio=current()/folio]) = 1">0</xsl:when>
							<xsl:otherwise>1</xsl:otherwise>
						</xsl:choose>
				</xsl:for-each>			
			</response>


	</xsl:template>

</xsl:stylesheet>


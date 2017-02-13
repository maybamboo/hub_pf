<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="xs">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">
		<response>
			<xsl:variable name="estado_pagos" select="/request-context/services-responses/notificacion_pago/valida_pagos_duplicados/response/data"/>

			<xsl:variable name="count" select="count($estado_pagos/Results/Row[RESULTADO > 0])"/>
			<!--contamos cuantos pagos no son validos-->
			<xsl:choose>
				<!--Ya no forman parte de esta validacion ni el monto ni los pagos duplicados, eso se dejara para despues-->
				<xsl:when test="$count > 0">
					<code>1</code>
					<description>Existen pagos duplicados</description>	
				</xsl:when>
				<xsl:otherwise>
					<code>0</code>
					<description>No existen pagos duplicados</description>
				</xsl:otherwise>
			</xsl:choose>
		</response>
	</xsl:template>
</xsl:stylesheet>

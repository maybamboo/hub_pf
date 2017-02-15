<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="/">	
	   <message>
			<header>
				<msg_type>RSNP01</msg_type>				
				<xsl:copy-of select="/request-context/request/message/header/id_trx_rec/self::node()"/>
				<id_trx_eft><xsl:value-of select="/request-context/services-responses/notificacion_pago/id_trx_eft/response/data/Results/Row/NEXTVAL" /></id_trx_eft>
				<xsl:copy-of select="/request-context/request/message/header/id_trx_eps/self::node()"/>
				<xsl:copy-of select="/request-context/request/message/header/company_id/self::node()"/>	

				<payment_date>
					<xsl:value-of select="current-dateTime()" />
				</payment_date>

			</header>
			<body>
				<!--Indicar que hay un error en el pago y se debe revisar-->
				<status_code>CEH15</status_code>
				<status_desc>Pago no completado satisfactoriamente</status_desc>


				<!--contiene un string con 1 y 0-->
				<xsl:variable name="pagos_duplicados" select="/request-context/services-responses/notificacion_pago/valida_pagos_duplicados/response/data" />
				<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>

				<!--Se supone que el orden es el mismo-->
				<xsl:for-each select="$payment">
					<payment>
						<service_id><xsl:value-of select="service_id"/></service_id>
						<!--Se devuelve el odc_id enviado por el usuario, en caso de que este no haya enviado ninguna se devuelve vacio-->
						<document_id><xsl:value-of select="document_id"/></document_id>

						<!--Si incluimos la variable en la misma expresión general problemas-->
						<xsl:variable name="position" select="position()"/>

						<!--Se obtiene la respuesta correspontiente-->
						<xsl:variable name="estado" select="$pagos_duplicados[$position]/Results/Row/RESULTADO"/>
						<!--Esto lo podemos hacer a través de un template-->
						<xsl:choose>
							<!--La deuda no existe-->
							<xsl:when test="$estado > 0">
								<status_code>CEH14</status_code>
								<status_desc>Pago ya registrado previamente (duplicado)</status_desc>
							</xsl:when>
							<xsl:otherwise>
								<status_code>0</status_code>
								<status_desc>OK</status_desc>
							</xsl:otherwise>
						</xsl:choose>

					</payment>

				</xsl:for-each>
			</body>
		</message>		
	</xsl:template>	
</xsl:stylesheet>
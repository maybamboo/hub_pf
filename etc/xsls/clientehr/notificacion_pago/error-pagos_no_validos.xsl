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


				<xsl:variable name="payment" select="/request-context/services-responses/notificacion_pago/valida_pagos_bd/response/data"/>

				<xsl:for-each select="$payment">
					<payment>
						<service_id><xsl:value-of select="Results/Row/ID_SERVICIO"/></service_id>
						<!--Se devuelve el odc_id enviado por el usuario, en caso de que este no haya enviado ninguna se devuelve vacio-->
						<document_id><xsl:value-of select="Results/Row/IN_DOC_ID"/></document_id>
						<!--Esto lo podemos hacer a través de un template-->
						<xsl:choose>
							<!--La deuda no existe-->
							<xsl:when test="Results/Row/ESTADO_PAGO = 1">
								<status_code>CEH6</status_code>
								<status_desc>No existe deuda para los identificadores informados</status_desc>
							</xsl:when>
							<!--La deuda existe pero ya fue pagada-->
							<xsl:when test="Results/Row/ESTADO_PAGO = 2">
								<status_code>CEH14</status_code>
								<status_desc>Pago ya registrado previamente (duplicado)</status_desc>
							</xsl:when>

							<xsl:when test="Results/Row/ESTADO_PAGO = 3">
								<status_code>CEH5</status_code>
								<status_desc>Numero de documento invalido</status_desc>
							</xsl:when>
							<!--Si no entra a ninguno significa que no hay error, por lo tanto se devuelve 0-->
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
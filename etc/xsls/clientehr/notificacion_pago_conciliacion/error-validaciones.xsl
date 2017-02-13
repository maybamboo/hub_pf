<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="error_msg">
	
		<xsl:param name="statusCode" />
		<xsl:param name="statusDesc" />
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
				<status_code><xsl:value-of select="$statusCode" /></status_code>
				<status_desc><xsl:value-of select="$statusDesc" /></status_desc>			  
			</body>
		</message>
         
		
	</xsl:template>

	
	<xsl:template match="/">

	<xsl:choose>


		<!--vamos a reservar una valdiacion para el id_trx_eft-->
		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '00'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH2'" />
					<xsl:with-param name="statusDesc" select="'Problemas al acceder a la base de datos'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '01'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF101'" />
					<xsl:with-param name="statusDesc" select="'Problemas al consultar el convenio informado'" />
			</xsl:call-template>	
		</xsl:when>


		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '02'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF104'" />
					<xsl:with-param name="statusDesc" select="'Convenio no se encuentra Activo'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '03'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF102'" />
					<xsl:with-param name="statusDesc" select="'Recaudador informado no existe habilitado en convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '04'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF103'" />
					<xsl:with-param name="statusDesc" select="'Empresa informada no existe habilitada en convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '05'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF105'" />
					<xsl:with-param name="statusDesc" select="'Moneda no válida para el convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '06'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF106'" />
					<xsl:with-param name="statusDesc" select="'País no válido para el convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '07'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH15'" />
					<xsl:with-param name="statusDesc" select="'Monto total no coincide'" />
			</xsl:call-template>	
		</xsl:when>
	
	</xsl:choose>	
	</xsl:template>
</xsl:stylesheet>
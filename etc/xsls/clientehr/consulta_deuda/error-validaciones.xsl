<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="error_msg">
	
		<xsl:param name="statusCode" />
		<xsl:param name="statusDesc" />


	   <message>
			<header>
				<msg_type>RSCD01</msg_type>				
				<xsl:copy-of select="/request-context/request/message/header/id_trx_rec/self::node()"/>
				<id_trx_eft><xsl:value-of select="/request-context/services-responses/consulta_deuda/idtrxeft/response/data/Results/Row/NEXTVAL" /></id_trx_eft>
				<id_trx_eps></id_trx_eps>					
				<date>
					<xsl:value-of select="current-dateTime()" />
				</date>
				<xsl:copy-of select="/request-context/request/message/header/currency_code/self::node()"/>
			</header>
			<body>
				<status_code><xsl:value-of select="$statusCode" /></status_code>
				<status_desc><xsl:value-of select="$statusDesc" /></status_desc>
				  
				<xsl:copy-of select="/request-context/request/message/body/contract_id/self::node()" />
				<decimal_places>0</decimal_places>				
				<total_amount>0</total_amount>
				<debts>
					<q>0</q>
				</debts>
			</body>
		</message>
         
		
	</xsl:template>
	
	<xsl:template match="/">

	<xsl:choose>
	
		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '00'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo id_trx_rec viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when> 


		<!--Este no tiene ningun error asignado-->
  		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '01'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo decimal_places viene vacío o exdede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '02'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo company_id viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '03'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo collector_id viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '04'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH18'" />
					<xsl:with-param name="statusDesc" select="'La fecha no cumple con el formato ISO8601'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '05'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo channel viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '06'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo country_code viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '07'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo currency_code viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '08'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo contract_id viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '09'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo service_id excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '10'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo client_id excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '11'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo folio excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '12'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo service_type excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '13'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF200'" />
					<xsl:with-param name="statusDesc" select="'Problemas al acceder a la base de datos'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '14'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF101'" />
					<xsl:with-param name="statusDesc" select="'Problemas al consultar el convenio informado'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '15'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF104'" />
					<xsl:with-param name="statusDesc" select="'Convenio no se encuentra Activo'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '16'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF102'" />
					<xsl:with-param name="statusDesc" select="'Recaudador informado no existe habilitado en convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '17'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF103'" />
					<xsl:with-param name="statusDesc" select="'Empresa informada no existe habilitada en convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '18'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF109'" />
					<xsl:with-param name="statusDesc" select="'Canal informado no existe habilitado en el convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '19'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF105'" />
					<xsl:with-param name="statusDesc" select="'Moneda no válida para el convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '20'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF106'" />
					<xsl:with-param name="statusDesc" select="'País no válido para el convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '21'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF303'" />
					<xsl:with-param name="statusDesc" select="'Debe especificar parametros de consulta(rut)'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '22'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF303'" />
					<xsl:with-param name="statusDesc" select="'Debe especificar parametros de consulta(id_servicio)'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '23'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF303'" />
					<xsl:with-param name="statusDesc" select="'Debe especificar parametros de consulta(folio)'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '24'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH8'" />
					<xsl:with-param name="statusDesc" select="'Cliente no Existe'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '25'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF307'" />
					<xsl:with-param name="statusDesc" select="'service_id no existe en base de datos'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_deuda/validaciones/message/body/validation_code = '26'">
            <xsl:call-template name="error_msg">
                <xsl:with-param name="statusCode" select="'CEH4'" />
                <xsl:with-param name="statusDesc" select="'Número de transacción ya informado previamente'" />
            </xsl:call-template>    
        </xsl:when>                                   		 		        
	
	</xsl:choose>
		
	</xsl:template>
</xsl:stylesheet>
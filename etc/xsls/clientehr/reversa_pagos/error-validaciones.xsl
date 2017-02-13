<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="error_msg">
	
		<xsl:param name="statusCode" />
		<xsl:param name="statusDesc" />

	   <message>
			<header>
				<msg_type>RSRP01</msg_type>				
				<xsl:copy-of select="/request-context/request/message/header/id_trx_rev/self::node()"/>
				<id_trx_eft_rev><xsl:value-of select="/request-context/services-responses/reversa_pagos/id_trx_eft_rev/response/data/Results/Row/NEXTVAL" /></id_trx_eft_rev>
				<xsl:copy-of select="/request-context/request/message/header/company_id/self::node()"/>
				<reverse_date>
					<xsl:value-of select="current-dateTime()" />
				</reverse_date>
			</header>
			<body>
				<status_code><xsl:value-of select="$statusCode" /></status_code>
				<status_desc><xsl:value-of select="$statusDesc" /></status_desc>
			</body>
		</message>
         
		
	</xsl:template>
	
	<xsl:template match="/">

	<xsl:choose>
	
		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '00'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo id_trx_rev viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when> 


		<!--Este no tiene ningun error asignado-->
  		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '01'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo id_trx_rec viene vacío o exdede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '02'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo id_trx_eft viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '03'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF200'" />
					<xsl:with-param name="statusDesc" select="'Problemas al acceder a la base de datos'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '04'">
			<xsl:call-template name="error_msg">
                <xsl:with-param name="statusCode" select="'CEH4'" />
                <xsl:with-param name="statusDesc" select="'Número de transacción ya informado previamente'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '05'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo company_id viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '06'">
			<xsl:call-template name="error_msg">
				<xsl:with-param name="statusCode" select="'CEH18'" />
				<xsl:with-param name="statusDesc" select="'La fecha no cumple con el formato ISO8601'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '07'">
			<xsl:call-template name="error_msg">
				<xsl:with-param name="statusCode" select="'CEH17'" />
				<xsl:with-param name="statusDesc" select="'El campo contract_id viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '08'">
			<xsl:call-template name="error_msg">
				<xsl:with-param name="statusCode" select="'CEH17'" />
				<xsl:with-param name="statusDesc" select="'El campo collector_id viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '09'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo total_amount viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '10'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF101'" />
					<xsl:with-param name="statusDesc" select="'Problemas al consultar el convenio informado'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '11'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF104'" />
					<xsl:with-param name="statusDesc" select="'Convenio no se encuentra Activo'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '12'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF102'" />
					<xsl:with-param name="statusDesc" select="'Recaudador informado no existe habilitado en convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '13'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF103'" />
					<xsl:with-param name="statusDesc" select="'Empresa informada no existe habilitada en convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/reversa_pagos/validaciones/message/body/validation_code = '14'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CE301'" />
					<xsl:with-param name="statusDesc" select="'El convenio no admite reversa'" />
			</xsl:call-template>	
		</xsl:when>
	</xsl:choose>
		
	</xsl:template>
</xsl:stylesheet>
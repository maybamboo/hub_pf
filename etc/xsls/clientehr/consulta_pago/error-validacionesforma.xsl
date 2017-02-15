<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="error_msg">
	
		<xsl:param name="statusCode" />
		<xsl:param name="statusDesc" />
			
		<message>
			<header>
				<msg_type>RSCP01</msg_type>
				<xsl:copy-of select="/request-context/request/message/header/company_id" />
				<date>
					<xsl:value-of select="current-dateTime()" />
				</date>
        <xsl:copy-of select="/request-context/request/message/header/country_code" />
			</header>
			<body>
				<status_code><xsl:value-of select="$statusCode" /></status_code>
				<status_desc><xsl:value-of select="$statusDesc" /></status_desc>
				<payments>
					<q>0</q>
					<q_total>0</q_total>
					<page>1</page>
					<total_page>1</total_page>
				</payments>
			</body>
		</message>
				
	</xsl:template>
	
	<xsl:template match="/">
	
	
	<xsl:choose>
	

		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '01'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF203'" />
					<xsl:with-param name="statusDesc" select="'Error, Fecha de transaccion invalida'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '02'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF204'" />
					<xsl:with-param name="statusDesc" select="'Error, tipo de fecha invalida'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '03'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF205'" />
					<xsl:with-param name="statusDesc" select="'Error, rango de fecha inicio invalida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '04'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF206'" />
					<xsl:with-param name="statusDesc" select="'Error, rango de fecha  final invalida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '324'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH324'" />
					<xsl:with-param name="statusDesc" select="'Fecha de pago se encuentra vacia'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '325'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH325'" />
					<xsl:with-param name="statusDesc" select="'Fecha de pago es invalida'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '326'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH326'" />
					<xsl:with-param name="statusDesc" select="'Fecha contable vacia'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '327'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH327'" />
					<xsl:with-param name="statusDesc" select="'Fecha contable es invalida'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '328'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH328'" />
					<xsl:with-param name="statusDesc" select="'Fecha de emisor vacia'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '329'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH329'" />
					<xsl:with-param name="statusDesc" select="'Fecha de emisor es invalida'" />
			</xsl:call-template>	
		</xsl:when>
	<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '330'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH330'" />
					<xsl:with-param name="statusDesc" select="'campo tipo de pago esta vacia'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '331'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH331'" />
					<xsl:with-param name="statusDesc" select="'Campo tipo de pago es invalida'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '332'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH332'" />
					<xsl:with-param name="statusDesc" select="'Campo metodo de pago esta vacia'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '333'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH333'" />
					<xsl:with-param name="statusDesc" select="'Metodo de pago es invalida'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '339'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH339'" />
					<xsl:with-param name="statusDesc" select="'Tipo de pago vacio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '336'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH336'" />
					<xsl:with-param name="statusDesc" select="'Monto total esta vacia'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '337'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH337'" />
					<xsl:with-param name="statusDesc" select="'Monto total es invalida'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '338'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH338'" />
					<xsl:with-param name="statusDesc" select="'El campo Monto es vacio'" />
			</xsl:call-template>	
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '340'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH340'" />
					<xsl:with-param name="statusDesc" select="'El campo Monto es invalido'" />
			</xsl:call-template>	
		</xsl:when>
		
		
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '301'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH301'" />
					<xsl:with-param name="statusDesc" select="'Identificador de recaudador es invalido'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '302'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH302'" />
					<xsl:with-param name="statusDesc" select="'Identificador de recaudador se encuentra vacio'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '303'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH303'" />
					<xsl:with-param name="statusDesc" select="'Identificador de compañia se encuentra vacio'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '304'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH304'" />
					<xsl:with-param name="statusDesc" select="'identificador de compañia es invalido'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '305'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH305'" />
					<xsl:with-param name="statusDesc" select="'identificador de recaudacion se encuetra vacio'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '306'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH306'" />
					<xsl:with-param name="statusDesc" select="'identificador de recaudacion es invalido'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '307'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH307'" />
					<xsl:with-param name="statusDesc" select="'Fecha se encuentra vacio'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '308'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH308'" />
					<xsl:with-param name="statusDesc" select="'Fecha es invalido'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '309'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH309'" />
					<xsl:with-param name="statusDesc" select="'Identificador de Channel esta vacio'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '310'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH310'" />
					<xsl:with-param name="statusDesc" select="'Identificador de channel es invalido'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '311'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH311'" />
					<xsl:with-param name="statusDesc" select="'Identificador de pais esta vacio'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '312'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH312'" />
					<xsl:with-param name="statusDesc" select="'Identificador de pais es invalido'" />
			</xsl:call-template>
		</xsl:when>
		
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '313'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH313'" />
					<xsl:with-param name="statusDesc" select="'Identificador de servicio esta vacio'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '314'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH314'" />
					<xsl:with-param name="statusDesc" select="'Identificador de servicio es invalido'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '315'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH315'" />
					<xsl:with-param name="statusDesc" select="'Identificador de cliente esta vacio'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '316'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH316'" />
					<xsl:with-param name="statusDesc" select="'Identificador de cliente es invalido'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '317'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH317'" />
					<xsl:with-param name="statusDesc" select="'Identificador de contrato esta vacio'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '318'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH318'" />
					<xsl:with-param name="statusDesc" select="'Identificador de contrato es invalido'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '319'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH319'" />
					<xsl:with-param name="statusDesc" select="'Identificador de Folio esta vacio'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '320'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH320'" />
					<xsl:with-param name="statusDesc" select="'Identificador de Folio es invalido'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '321'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH321'" />
					<xsl:with-param name="statusDesc" select="'Identificador de documento e identificador de servicio esta vacio'" />
			</xsl:call-template>
		</xsl:when>
			<!--	<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '321'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH321'" />
					<xsl:with-param name="statusDesc" select="'Identificador de documento y de servicio estan vacios'" />
			</xsl:call-template>
		</xsl:when>-->

		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '339'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH339'" />
					<xsl:with-param name="statusDesc" select="'Identificador de moneda se encuentra vacio'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '346'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH346'" />
					<xsl:with-param name="statusDesc" select="'Identificador monto es invalido'" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="/request-context/services-responses/consulta_pago/validacionesforma/message/body/validation_code = '340'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH340'" />
					<xsl:with-param name="statusDesc" select="'Identificador monto es invalido'" />
			</xsl:call-template>
		</xsl:when>
		
		<xsl:otherwise>
            <xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH2'" />
					<xsl:with-param name="statusDesc" select="'En estos momentos el sistema no se encuentra disponible'" />
			</xsl:call-template>
        </xsl:otherwise>
	 
	 
	</xsl:choose>
		
	</xsl:template>
</xsl:stylesheet>



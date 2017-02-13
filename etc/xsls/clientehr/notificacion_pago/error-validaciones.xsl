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


	<!--Template para devolver el error, pero con detalle de cada pago-->
	<!--Se debe entregarle como parametro la condición que se desea validar-->
	<!--Los pagos que tenga ese error lo devolveran, y los que no-->
	<xsl:template name="error_msg_detalle_service_id">
		
			<xsl:param name="statusCode"/>
			<xsl:param name="statusDesc"/>

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

					<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>
					<xsl:for-each select="$payment">
						<payment>
							<service_id><xsl:value-of select="$payment/service_id"/></service_id>
							<document_id><xsl:value-of select="$payment/document_id"/></document_id>
							<xsl:choose>
								<xsl:when test="service_id ='' or string-length(service_id) > 32">
									<status_code><xsl:value-of select="'CEH17'" /></status_code>
									<status_desc><xsl:value-of select="'El campo service_id viene vacío o excede la longitud permitida'"/></status_desc>
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

	<xsl:template name="error_msg_detalle_client_id">
		
			<xsl:param name="statusCode"/>
			<xsl:param name="statusDesc"/>

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

					<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>
					<xsl:for-each select="$payment">
						<payment>
							<service_id><xsl:value-of select="$payment/service_id"/></service_id>
							<document_id><xsl:value-of select="$payment/document_id"/></document_id>
							<xsl:choose>
								<xsl:when test="client_id ='' or string-length(client_id) > 32">
									<status_code><xsl:value-of select="'CEH17'" /></status_code>
									<status_desc><xsl:value-of select="'El campo client_id viene vacío o excede la longitud permitida'" /></status_desc>
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

	<xsl:template name="error_msg_detalle_document_id">
		
			<xsl:param name="statusCode"/>
			<xsl:param name="statusDesc"/>

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

					<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>
					<xsl:for-each select="$payment">
						<payment>
							<service_id><xsl:value-of select="$payment/service_id"/></service_id>
							<document_id><xsl:value-of select="$payment/document_id"/></document_id>
							<xsl:choose>
								<xsl:when test="document_id ='' or string-length(document_id) > 32">
									<status_code><xsl:value-of select="'CEH17'" /></status_code>
									<status_desc><xsl:value-of select="'El campo document_id viene vacío o excede la longitud permitida'" /></status_desc>
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


	<xsl:template name="error_msg_detalle_folio">
		
			<xsl:param name="statusCode"/>
			<xsl:param name="statusDesc"/>

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

					<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>
					<xsl:for-each select="$payment">
						<payment>
							<service_id><xsl:value-of select="$payment/service_id"/></service_id>
							<document_id><xsl:value-of select="$payment/document_id"/></document_id>
							<xsl:choose>
								<xsl:when test="folio ='' or string-length(folio) > 32">
									<status_code><xsl:value-of select="'CEH17'" /></status_code>
									<status_desc><xsl:value-of select="'El campo folio viene vacío o excede la longitud permitida'" /></status_desc>
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

	<xsl:template name="error_msg_detalle_amount">
		
			<xsl:param name="statusCode"/>
			<xsl:param name="statusDesc"/>

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

					<xsl:variable name="payment" select="/request-context/request/message/body/payment"/>
					<xsl:for-each select="$payment">
						<payment>
							<service_id><xsl:value-of select="$payment/service_id"/></service_id>
							<document_id><xsl:value-of select="$payment/document_id"/></document_id>
							<xsl:choose>
								<xsl:when test="amount ='' or string-length(amount) > 32">
									<status_code><xsl:value-of select="'CEH17'" /></status_code>
									<status_desc><xsl:value-of select="'El campo amount viene vacío o excede la longitud permitida'" /></status_desc>
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


	
	<xsl:template match="/">

	<xsl:choose>
	
		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '00'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo id_trx_rec viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when> 

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '01'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo company_id viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '02'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH18'" />
					<xsl:with-param name="statusDesc" select="'La fecha no cumple con el formato ISO8601'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '03'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo country_code viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '04'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo currency_code viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '05'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo contract_id viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '06'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo collector_id viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '07'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo canal viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

  		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '08'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo decimal_places viene vacío o exdede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

  		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '09'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH18'" />
					<xsl:with-param name="statusDesc" select="'El campo settlement_date no cumple con el formato yyyy-mm-dd'" />
			</xsl:call-template>	
		</xsl:when>

  		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '10'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo transmitter excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

  		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '11'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo payment_type excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

  		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '12'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'El campo payment_method excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>


		<!--vamos a reservar una valdiacion para el id_trx_eft-->
		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '26'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF200'" />
					<xsl:with-param name="statusDesc" select="'Problemas al acceder a la base de datos'" />
			</xsl:call-template>	
		</xsl:when>

        <xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '13'">
            <xsl:call-template name="error_msg">
                <xsl:with-param name="statusCode" select="'CEH4'" />
                <xsl:with-param name="statusDesc" select="'Número de transacción ya informado previamente'" />
            </xsl:call-template>    
        </xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '14'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF101'" />
					<xsl:with-param name="statusDesc" select="'Problemas al consultar el convenio informado'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '15'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF104'" />
					<xsl:with-param name="statusDesc" select="'Convenio no se encuentra Activo'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '16'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF102'" />
					<xsl:with-param name="statusDesc" select="'Recaudador informado no existe habilitado en convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '17'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF103'" />
					<xsl:with-param name="statusDesc" select="'Empresa informada no existe habilitada en convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '18'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF105'" />
					<xsl:with-param name="statusDesc" select="'Moneda no válida para el convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '19'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF106'" />
					<xsl:with-param name="statusDesc" select="'País no válido para el convenio'" />
			</xsl:call-template>	
		</xsl:when>

		<!--aqui comienzan las validaciones iterativas-->

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '20'">
			<xsl:call-template name="error_msg_detalle_service_id">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'Uno de los campos service_id  viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '21'">
			<xsl:call-template name="error_msg_detalle_client_id">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'Uno de los campos client_id viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '22'">
			<xsl:call-template name="error_msg_detalle_document_id">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'Uno de los campos document_id viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>



		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '23'">
			<xsl:call-template name="error_msg_detalle_folio">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'Uno de los campos folio viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>


		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '24'">
			<xsl:call-template name="error_msg_detalle_amount">
					<xsl:with-param name="statusCode" select="'CEH17'" />
					<xsl:with-param name="statusDesc" select="'Uno de los campos amount viene vacío o excede la longitud permitida'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '25'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH21'" />
					<xsl:with-param name="statusDesc" select="'El monto total no coincide con la suma de los pagos'" />
			</xsl:call-template>	
		</xsl:when>

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '27'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH19'" />
					<xsl:with-param name="statusDesc" select="'Existen pagos duplicados en el mensaje'" />
			</xsl:call-template>	
		</xsl:when>					

		<!--Nuevos codigos de error para los nuevos casos-->
		<!--A futuro se deben revisar los codigos-->
		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '28'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEH20'" />
					<xsl:with-param name="statusDesc" select="'El tipo de pago no esta permitido en el convenio'" />
			</xsl:call-template>	
		</xsl:when>		

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '29'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF109'" />
					<xsl:with-param name="statusDesc" select="'Canal informado no esta habilitado en el convenio'" />
			</xsl:call-template>	
		</xsl:when>		

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '30'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF107'" />
					<xsl:with-param name="statusDesc" select="'El medio de pago no esta habilitado en el convenio'" />
			</xsl:call-template>	
		</xsl:when>		

		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '31'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF117'" />
					<xsl:with-param name="statusDesc" select="'El medio de pago no esta configurado como medio de pago mixto'" />
			</xsl:call-template>	
		</xsl:when>


		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '32'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF118'" />
					<xsl:with-param name="statusDesc" select="'El medio de pago no coincide con el tipo de pago (PP y MPM)'" />
			</xsl:call-template>	
		</xsl:when>		


		<xsl:when test="/request-context/services-responses/notificacion_pago/validaciones/message/body/validation_code = '33'">
			<xsl:call-template name="error_msg">
					<xsl:with-param name="statusCode" select="'CEF119'" />
					<xsl:with-param name="statusDesc" select="'El monto asociado al medio de pago excede el maximo configurado'" />
			</xsl:call-template>	
		</xsl:when>				
	</xsl:choose>
		
	</xsl:template>






</xsl:stylesheet>
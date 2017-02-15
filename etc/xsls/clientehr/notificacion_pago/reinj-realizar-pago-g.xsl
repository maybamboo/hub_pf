<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="request_message" select="/request-context/request/message" />
		
	<xsl:template match="/">


		<transmission>
			<type>basedatos</type>
			<properties>
				<datasource>gestion_hrpf</datasource>
			</properties>			

		<xsl:variable name="payment" select="/request-context/services-responses/notificacion_pago/valida_pagos_bd/response/data"/>
		<xsl:variable name="payment_request" select="$request_message/body/payment" />
		<!--De manera paralela tenemos que capturar los datos de los pagos que vienen en linea, esto usando el position-->

		<!--Se valida cada pago que venga en el mensaje-->
		<!--Se corroboro que los data llegan en el mismo orden en el que se realizan las llamadas, por lo que no es necesario mapear las respuestas con el flag POSITION-->


		<xsl:choose>
			<xsl:when test="/request-context/request/message/body/payment_type = 'PM'">
				<!--Debemos generar un pago por cada medio de pago que se este utilizando en el pago-->

				<data>
					INSERT ALL
					<!--Se recorren los pagos que vienen en la notficacion-->
					<xsl:for-each select="$payment_request">


						<!--Aqui recorremos todos los pagos mixtos que existen en el pago-->
						<!--Corresponde a la posicion del pago dentro de la notificacion, y nos permite encontrar el pago en la respuesta de las validacion de base de datos, ya que se pasó como parametro-->
						<xsl:variable name="position" select="position()"/>
						<!--Otra opcion es almacenar id_servicio,id_cliente,folio como variables, para no tener que ir a buscar el echo que hace cada procedimiento almacenado-->

						<xsl:variable name="additional_data" select="additional_data/add_data[substring-before(type,'-')= 'MP']"/>

						<xsl:for-each select="$additional_data">
							<!--Tomamos en cuenta el dato adicional, solo si es un medio de pago-->
							<!--Dentro de este if tenemos que generar el insert-->

							<!--Corresponde a la posicion dentro de los datos adicionales que corresponden a medios de pago-->
							<xsl:variable name="position_data" select="position()"/>


							<xsl:if test="substring-before(type,'-') = 'MP'">

						        INTO PAGO(
						      		   pag_id
						              ,id_trx_rec
						              ,id_trx_eft
						              ,id_trx_eps
						              ,fecha_sistema
						              ,doc_id
						              ,tipo_pago
						              ,fecha_trx
						              ,recaudador_id
						              ,empresa_id
						              ,num_convenio
						              ,id_servicio
						              ,id_cliente
						              ,monto_pago
						              ,moneda
						              ,numero_decimales
						              ,canal
						              ,medio_pago
						              ,estado_pago
						              ,estado_notificacion          
						              ,folio
						              ,emisor
						              ,fecha_contable
						              ,reintentos
						              ,estado_conciliacion,
						              tipo_servicio,
						              fecha_vcto,
						              COD_EMPRESA_HOLDING)
						              values (
						                <!--'<xsl:value-of select="$payment[$position]/Results/Row/PAG_ID"/>'-->
						                '<xsl:value-of select="$payment[$position]/Results/Row/PAG_ID/row[$position_data]"/>'
						                ,'<xsl:value-of select="$request_message/header/id_trx_rec" />'
						                ,'<xsl:value-of select="/request-context/services-responses/notificacion_pago/id_trx_eft/response/data/Results/Row/NEXTVAL" />'
						                ,'<xsl:value-of select="/request-context/services-responses/notificacion_pago/transformarResp/response/data/message/header/id_trx_eps"/>'
						                ,SYSDATE
						                ,'<xsl:value-of select="$payment[$position]/Results/Row/DOC_ID"/>'<!--Debe venir de base de datos-->     
						                ,'<xsl:value-of select="$request_message/body/payment_type" />'                      
						                ,(case when LENGTH('<xsl:value-of select="$request_message/header/payment_date" />') > 1  then   to_timestamp_tz('<xsl:value-of select="$request_message/header/payment_date" />','YYYY-MM-DD"T"HH24:MI:SS.FF3TZR') else NULL end)
						                ,'<xsl:value-of select="$request_message/body/collector_id" />'
						                ,'<xsl:value-of select="$request_message/header/company_id" />'
						                ,'<xsl:value-of select="$request_message/body/contract_id" />'
						                ,'<xsl:value-of select="$payment[$position]/Results/Row/ID_SERVICIO" />'
						                ,'<xsl:value-of select="$payment[$position]/Results/Row/ID_CLIENTE" />'
						                ,'<xsl:value-of select="value"/>'<!--Sale del dato adicional,AQUI-->
						                ,'<xsl:value-of select="$request_message/header/currency_code" />'
						                ,'<xsl:value-of select="$request_message/body/decimal_places" />'
						                ,'<xsl:value-of select="$request_message/body/channel" />'
						                ,'<xsl:value-of select="substring-after(type,'-')" />'<!--Sale del dato adicional, AQUI-->
						                ,0 <!--Se inserta el pago como aceptado-->
						                ,0 <!--El pago se inserta como notificado-->
						                ,'<xsl:value-of select="$payment[$position]/Results/Row/FOLIO" />'
						                ,'<xsl:value-of select="$request_message/body/transmitter" />'
						                ,to_timestamp_tz('<xsl:value-of select="$request_message/body/settlement_date" />','YYYY-MM-DD')
						                ,0
						                ,4
						                ,1
						                ,to_timestamp_tz('<xsl:value-of select="Results/Row/FECHA_VCTO" />','YYYY-MM-DD')
						                ,'<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />'
						                )
							</xsl:if>
						</xsl:for-each>

					</xsl:for-each>

					SELECT * FROM DUAL
				</data>
			</xsl:when>
			<xsl:otherwise>
				<!--Hacemos todo de manera normal-->
				<data>
					INSERT ALL
						<!--Para cada pago concatemaos su insert-->
						<xsl:for-each select="$payment">

							<!--posicion del pago-->

					        INTO PAGO(
					      		   pag_id
					              ,id_trx_rec
					              ,id_trx_eft
					              ,id_trx_eps
					              ,fecha_sistema
					              ,doc_id
					              ,tipo_pago
					              ,fecha_trx
					              ,recaudador_id
					              ,empresa_id
					              ,num_convenio
					              ,id_servicio
					              ,id_cliente
					              ,monto_pago
					              ,moneda
					              ,numero_decimales
					              ,canal
					              ,medio_pago
					              ,estado_pago
					              ,estado_notificacion          
					              ,folio
					              ,emisor
					              ,fecha_contable
					              ,reintentos
					              ,estado_conciliacion,
					              tipo_servicio,
					              fecha_vcto,
					              COD_EMPRESA_HOLDING)
					              values (
					                 '<xsl:value-of select="Results/Row/PAG_ID/row" />'
					                ,'<xsl:value-of select="$request_message/header/id_trx_rec" />'
					                ,'<xsl:value-of select="/request-context/services-responses/notificacion_pago/id_trx_eft/response/data/Results/Row/NEXTVAL" />'
					                ,'<xsl:value-of select="/request-context/services-responses/notificacion_pago/transformarResp/response/data/message/header/id_trx_eps"/>'
					                ,SYSDATE
					                ,'<xsl:value-of select="Results/Row/DOC_ID" />'   
					                ,'<xsl:value-of select="$request_message/body/payment_type" />'                      
					                ,(case when LENGTH('<xsl:value-of select="$request_message/header/payment_date" />') > 1  then   to_timestamp_tz('<xsl:value-of select="$request_message/header/payment_date" />','YYYY-MM-DD"T"HH24:MI:SS.FF3TZR') else NULL end)
					                ,'<xsl:value-of select="$request_message/body/collector_id" />'
					                ,'<xsl:value-of select="$request_message/header/company_id" />'
					                ,'<xsl:value-of select="$request_message/body/contract_id" />'
					                ,'<xsl:value-of select="Results/Row/ID_SERVICIO" />'
					                ,'<xsl:value-of select="Results/Row/ID_CLIENTE" />'
					                ,'<xsl:value-of select="$request_message/body/payment[position()]/amount"/>'<!--Se usa el monto del pago que viene desde la peticion-->
					                ,'<xsl:value-of select="$request_message/header/currency_code" />'
					                ,'<xsl:value-of select="$request_message/body/decimal_places" />'
					                ,'<xsl:value-of select="$request_message/body/channel" />'
					                ,'<xsl:value-of select="$request_message/body/payment_method" />'
					                ,0 <!--El pago se inserta como aceptado-->
					                ,0 <!--El pago se inserta como notificado-->
					                ,'<xsl:value-of select="Results/Row/FOLIO"/>'<!--Este dato puede ser cualquiera, asi que sirve usar la respuesta de bd-->                  
					                ,'<xsl:value-of select="$request_message/body/transmitter" />'
					                ,to_timestamp_tz('<xsl:value-of select="$request_message/body/settlement_date" />','YYYY-MM-DD')
					                ,0
					                ,4
					                ,1
					                ,to_timestamp_tz('<xsl:value-of select="Results/Row/FECHA_VCTO" />','YYYY-MM-DD')
					                ,'<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />'
					                )
			  			</xsl:for-each>

 			        		SELECT * FROM DUAL
 					</data>
			</xsl:otherwise>
		</xsl:choose>




		</transmission>
				
	</xsl:template>
</xsl:stylesheet>



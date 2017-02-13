<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:variable name="request_message" select="/request-context/request/message" />

	
	<xsl:template match="/">
		
		<transmission>
			<type>basedatos</type>
			<properties>
				<datasource>gestion_hrdemo</datasource>
			</properties>

			<data>

				 INSERT INTO PAGO(
					pag_id
	  				,id_trx_rec
		 			,id_trx_eft
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
					tipo_servicio)
					values (
					'<xsl:value-of select="/request-context/services-responses/notificacion_pago_conciliacion/consultar_id_trx_rec/response/data/Results/Row/PAG_ID" />'
					,'<xsl:value-of select="$request_message/header/id_trx_rec" />'
					,'<xsl:value-of select="/request-context/services-responses/notificacion_pago_conciliacion/consultar_id_trx_rec/response/data/Results/Row/ID_TRX_EFT" />'
					,SYSDATE
		 			,'<xsl:value-of select="$request_message/body/payment/document_id" />'  
					,'<xsl:value-of select="$request_message/body/payment_type" />' 
					,(case when LENGTH('<xsl:value-of select="$request_message/header/payment_date" />') > 1  then  to_timestamp_tz('<xsl:value-of select="$request_message/header/payment_date" />','YYYY-MM-DD"T"HH24:MI:SS.FF3TZR') else NULL end)
					,'<xsl:value-of select="$request_message/body/collector_id" />'
					,'<xsl:value-of select="$request_message/header/company_id" />'
					,'<xsl:value-of select="$request_message/body/contract_id" />'
					,'<xsl:value-of select="$request_message/body/payment/service_id" />'
					,'<xsl:value-of select="$request_message/body/payment/client_id" />'
					,'<xsl:value-of select="$request_message/body/payment/amount" />'
					,'<xsl:value-of select="$request_message/header/currency_code" />'
					,'<xsl:value-of select="$request_message/body/decimal_places" />'
					,'<xsl:value-of select="$request_message/body/channel" />'
					,'<xsl:value-of select="$request_message/body/payment_method" />'
					,0
					,1
		 			,'<xsl:value-of select="$request_message/body/payment/folio" />'
					,'<xsl:value-of select="$request_message/body/transmitter" />'
		 			,to_timestamp_tz('<xsl:value-of select="$request_message/body/settlement_date" />','YYYY-MM-DD')
					,0
					,1
					,1)
			</data>							
		</transmission>
	</xsl:template>
</xsl:stylesheet>
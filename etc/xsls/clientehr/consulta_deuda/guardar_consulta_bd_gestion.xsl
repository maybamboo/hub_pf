<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="request_message" select="/request-context/request/message" />

	<xsl:template match="/">
		<transmission>
			<type>basedatos</type>			
			<properties>
				<datasource>gestion_hrpf</datasource>
			</properties>

			<xsl:variable name="debts" select="/request-context/services-responses/consulta_deuda/transformarResp/response/data/message/body/debts/debt"/>

			<!--Se valida cada pago que venga en el mensaje-->
			<data>
				INSERT ALL
				/*+ APPEND */
			<!--Para cada pago concatemaos su insert-->

			<!--vamos a usar el id_trx_eft tanto para la columna doc_id como para la columna id_trx_eft-->
			<xsl:for-each select="$debts">

          <xsl:variable name="posicion" select="position()"/>

  			 		<!--TIPO_DOCUMENTO-->
  			 		<!--PRODUCTO-->

					INTO CONSULTA(
              							DOC_ID,
              							ID_TRX_REC,
              							ID_TRX_EFT,
                            ID_TRX_EPS,
              							FECHA_SISTEMA,
              							FECHA_TRX,
              							FECHA_VCTO,
              							RECAUDADOR_ID,
              							EMPRESA_ID,
              							CANAL,
              							CONVENIO,
              							ID_CLIENTE,
              							ID_SERVICIO,
              							FOLIO,
              							TOTAL_CUOTA,
              							MONEDA,
              							NUMERO_DECIMALES,
                           	MONTO_NETO,
                           	MONTO_IMPUESTO,
                          	MONTO_INTERES,
                          	MONTO_TOTAL,
                          	MONTO_SALDO,
                          	CODIGO_PAIS,
                          	NOMBRE_CLIENTE,
                          	DIRECCION,
                          	EMAIL,         
                          	DATOS_ADICIONALES,
                          	NOMBRE_SERVICIO,
                            COMISION_LINEA,
                            IMPUESTO,
                            COD_EMPRESA_HOLDING
                          	)
  			 				values(
  			 				'<xsl:value-of select="/request-context/services-responses/consulta_deuda/obtener_doc_id/response/data/Results/Row[$posicion]/NEXTVAL"/>',
  			 				'<xsl:value-of select="/request-context/request/message/header/id_trx_rec" />',
  			 				'<xsl:value-of select="/request-context/services-responses/consulta_deuda/id_trx_eft/response/data/Results/Row/NEXTVAL" />',
                '<xsl:value-of select="/request-context/services-responses/consulta_deuda/transformarResp/response/data/message/header/id_trx_eps"/>',
  			 				SYSDATE,
  			 				(case when LENGTH('<xsl:value-of select="/request-context/request/message/header/date" />') > 1  then   to_timestamp_tz('<xsl:value-of select="/request-context/request/message/header/date" />','YYYY-MM-DD"T"HH24:MI:SS.FF3TZR') else NULL end),
  			 				to_timestamp_tz('<xsl:value-of select="expiration_date" />','YYYY-MM-DD'),
  			 				'<xsl:value-of select="/request-context/request/message/header/collector_id" />',
  			 				'<xsl:value-of select="/request-context/request/message/header/company_id" />',
  			 				'<xsl:value-of select="/request-context/request/message/header/channel" />',
  			 				'<xsl:value-of select="/request-context/request/message/body/contract_id" />',
 			 				   '<xsl:value-of select="client_id" />',
  			 				'<xsl:value-of select="service_id" />',
  			 				'<xsl:value-of select="folio" />',
  			 				'<xsl:value-of select="replace(total_amount, '\.' ,'')" />',  			 				
  			 				'<xsl:value-of select="/request-context/request/message/header/currency_code" />',
  			 				2,
  			 				0,
  			 				0,
  			 				0,
  			 				0,
  			 				0,
  			 				'<xsl:value-of select="/request-context/request/message/header/country_code" />',
  			 				'<xsl:value-of select="additional_data/add_data/value" />',
  			 				'',
  			 				'',
  			 				'',
  			 				'',
                '<xsl:value-of select="/request-context/services-responses/consulta_deuda/calculo_comisiones_linea/comisiones/comision[$posicion]"/>',
                '<xsl:value-of select="/request-context/services-responses/consulta_deuda/calculo_impuesto/impuestos/impuesto[$posicion]"/>',
                '<xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />')


  			</xsl:for-each>
  			        SELECT * FROM DUAL

  			</data>
		</transmission>

	</xsl:template>

</xsl:stylesheet>

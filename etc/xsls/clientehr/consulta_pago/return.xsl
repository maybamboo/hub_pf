<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:template match="/">

        <xsl:variable name="cant_total" select="/request-context/services-responses/consulta_pago/consulta_pago_total_registros/response/data/Results/Row/TOTAL_REG" />   
        <xsl:variable name="cant_reg_pag" select="count(/request-context/services-responses/consulta_pago/consulta_pago_bd/response/data/Results/Row)" />             
        <xsl:variable name="tamano_pag">


            <!--evaluar si se va a incluir esto en el xml-->
            <xsl:choose>
                <xsl:when test="request-context/services-responses/consulta_pago/convenio/agreements/response/policies/collector-channel/consultadeuda/consulta_deuda/msg/tamano_pag">
                    <xsl:copy-of select="/request-context/services-responses/consulta_pago/convenio/agreements/response/policies/collector-channel/consultadeuda/consulta_deuda/msg/tamano_pag"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="'100'"/>
                </xsl:otherwise>
            </xsl:choose>

        </xsl:variable>
      
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
  
                <xsl:choose>

                    <xsl:when test="$cant_reg_pag &gt; 0">
                				<status_code>001</status_code>
                				<status_desc>OK</status_desc>
                				<payments>
                					<q><xsl:value-of select="$cant_reg_pag" /></q>
                					<q_total><xsl:value-of select="$cant_total" /></q_total>
                					<page><xsl:value-of select="/request-context/request/message/body/page" /></page>
                					<total_page><xsl:value-of select="format-number(ceiling($cant_total div $tamano_pag),'0')" /></total_page>
                								
                                                <xsl:for-each select="/request-context/services-responses/consulta_pago/consulta_pago_bd/response/data/Results/Row">
                									<payment>
                                						<service_id><xsl:value-of select="ID_SERVICIO"/></service_id>
                                						<client_id><xsl:value-of select="ID_CLIENTE"/></client_id>
                                						<folio><xsl:value-of select="FOLIO"/></folio>
                                						<total_amount><xsl:value-of select="MONTO_PAGO"/></total_amount>
                                						<payment_date><xsl:value-of select="FECHA_SISTEMA"/></payment_date>
                                						<settlement_date><xsl:value-of select="FECHA_CONTABLE"/></settlement_date>
                                						<id_trx_rec><xsl:value-of select="ID_TRX_REC"/></id_trx_rec>
                                						<id_trx_eft><xsl:value-of select="ID_TRX_EFT"/></id_trx_eft>
                                						<id_trx_eps><xsl:value-of select="ID_TRX_EPS"/></id_trx_eps>
                                						<collector_id><xsl:value-of select="RECAUDADOR_ID"/></collector_id>
                                						<chanel><xsl:value-of select="CANAL"/></chanel>
                                						<transmitter><xsl:value-of select="EMISOR"/></transmitter>
                                						<decimal_places><xsl:value-of select="NUMERO_DECIMALES"/></decimal_places>
                                						<currency_code><xsl:value-of select="USD"/></currency_code>
                                						<contract_id><xsl:value-of select="NUM_CONVENIO"/></contract_id>
                                						<payment_method><xsl:value-of select="MEDIO_PAGO"/></payment_method>
                                						<payment_type><xsl:value-of select="TIPO_PAGO"/></payment_type>
                    									<!--se agrega dato adicional con fecha de transaccion informada por el recaudador y se suma 1 a la cuenta de datos adicionales-->
                    									<additional_data>         
                    										<q_add_data><xsl:value-of select="count(DATOS_ADICIONALES/additional_data/add_data) + 1"/></q_add_data>
                    										<add_data>
                    											<type>fecha_recaudador</type>
                    											<value><xsl:value-of select="FECHA_TRX"/></value>
                    										</add_data>
                    										<xsl:copy-of select="DATOS_ADICIONALES/additional_data/add_data" />
                    									</additional_data>  								
                									</payment>
                								</xsl:for-each>	           
                				</payments>
                    </xsl:when>
          
                    <xsl:otherwise>
                				<status_code>002</status_code>
                				<status_desc>Sin resultados</status_desc>
                				<payments>
                					<q>0</q>
                					<q_total>0</q_total>
                					<page><xsl:value-of select="/request-context/request/message/body/page" /></page>
                					<total_page>1</total_page>         
                				</payments>
                    </xsl:otherwise>

                </xsl:choose>  
            
			</body>
		</message>
    													
	</xsl:template>
</xsl:stylesheet>						

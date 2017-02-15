<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<msg_type>RSCD01</msg_type>   
				<xsl:copy-of select="/request-context/request/message/header/id_trx_rec/self::node()" />
				<id_trx_eft><xsl:value-of select="/request-context/services-responses/consulta_deuda/id_trx_eft/response/data/Results/Row/NEXTVAL" /></id_trx_eft>
				<id_trx_eps></id_trx_eps>
				<date><xsl:value-of select="current-dateTime()" /></date>
				<currency_code><xsl:value-of select="/request-context/request/message/header/currency_code" /></currency_code>
			</header>
			<body>

		       <status_code><xsl:value-of select="/request-context/services-responses/consulta_deuda/transformarResp/response/data/message/body/status/status_code" /></status_code>
		  		<status_desc><xsl:value-of select="/request-context/services-responses/consulta_deuda/transformarResp/response/data/message/body/status/status_desc" /></status_desc>   
				<contract_id><xsl:value-of select="/request-context/request/message/body/contract_id" /></contract_id>

		     <!--   <decimal_places>2</decimal_places> -->
		<decimal_places><xsl:value-of select="/request-context/services-responses/default/convenio/msg/empresa_holding/atributo_empresa_holding/numero_decimales" /></decimal_places>   


				<!--se suma el monto total de todas las deudas consultadas-->
				<total_amount>
					<!--<xsl:value-of select="format-number(sum(/request-context/services-responses/consulta_deuda/transformarResp/response/data/message/body/debts/debt/total_amount),0)" />-->

					<xsl:variable name="suma_comisiones" select="sum(/request-context/services-responses/consulta_deuda/calculo_comisiones_linea/comisiones/comision)"/>
					<xsl:variable name="suma_impuestos" select="sum(/request-context/services-responses/consulta_deuda/calculo_impuesto/impuestos/impuesto)"/>
					<!--<xsl:value-of select="format-number(sum(/request-context/services-responses/consulta_deuda/transformarResp/response/data/message/body/debts/debt/total_amount),0)" />-->
					<xsl:variable name="total_neto" select="sum(/request-context/services-responses/consulta_deuda/transformarResp/response/data/message/body/debts/debt/total_amount)"/>

					<xsl:value-of select="format-number(($suma_comisiones + $suma_impuestos + $total_neto) * 100,0)"/>

				</total_amount>
				

				<debts>
					<!--tambien se puede usar el q que se mapea, ya que ya hacemos el count una vez-->
					<q><xsl:value-of select="count(/request-context/services-responses/consulta_deuda/transformarResp/response/data/message/body/debts/debt)" /></q>
					<xsl:for-each select="/request-context/services-responses/consulta_deuda/transformarResp/response/data/message/body/debts/debt">


						<xsl:variable name="posicion" select="position()"/>

					<debt>
     
	      				<status_code>0</status_code>
	      				<status_desc>OK</status_desc>

	      					<xsl:variable name="comision" select="/request-context/services-responses/consulta_deuda/calculo_comisiones_linea/comisiones/comision[$posicion]"/>
	      					<xsl:variable name="impuesto" select="/request-context/services-responses/consulta_deuda/calculo_impuesto/impuestos/impuesto[$posicion]"/>
	      					<xsl:variable name="net_amount" select="net_amount"/>

                  
							<service_id><xsl:value-of select="/request-context/request/message/body/service_id" /></service_id>   
							<client_id><xsl:value-of select="client_id" /></client_id>
							<!--El document_id lo tenemos nosotros, lo debemos sacar de la consulta que hicimos a la base de datos-->
							<document_id><xsl:value-of select="/request-context/services-responses/consulta_deuda/obtener_doc_id/response/data/Results/Row[$posicion]/NEXTVAL" /></document_id> 						
							<folio><xsl:value-of select="folio" /></folio>
              				<!--Este campo se guarda en la base de datos?-->				
							<document_type/>			
							<product/>
							<service_name/>
							<!--Se devuelve la deuda original, sin cuota ni impuesto-->              
							<net_amount><xsl:value-of select="format-number($net_amount * 100,0)" /></net_amount>

							<interest_amount><xsl:value-of select="format-number(interest_amount * 100,0)" /></interest_amount>
							<!--<tax_amount><xsl:value-of select="tax_amount" /></tax_amount>-->
							<tax_amount><xsl:value-of select="format-number($impuesto * 100,0)"/></tax_amount>
							<commission_amount><xsl:value-of select="format-number($comision * 100,0)"/></commission_amount>
							<balance_amount><xsl:value-of select="format-number(balance_amount * 100,0)" /></balance_amount>


							<!--Debe incluir la cuota de conveniencia y el impuesto-->
							<!--<total_amount><xsl:value-of select="total_amount" /></total_amount>-->
							<!--<total_amount><xsl:value-of select="net_amount"></total_amount>-->
							<total_amount><xsl:value-of select="format-number(($net_amount + $comision + $impuesto) * 100,0)"/></total_amount>
              				<!--este dato es muy importante, ya que indica cuando vence la cuota-->
							<expiration_date><xsl:value-of select="expiration_date"/></expiration_date>
													
							<!--Posteriormente le daremos una vuelta, para ver como complementamos el tema del q_add_data-->	           
			                <additional_data><xsl:copy-of select="additional_data/*"/></additional_data>					
						</debt>

					</xsl:for-each>
				</debts>
			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>						

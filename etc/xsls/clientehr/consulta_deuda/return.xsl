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

		        <xsl:choose>              
		          <xsl:when test="count(/request-context/services-responses/consulta_deuda/consulta_deuda_bd/response/data/Results/Row)= 0">
		    				<status_code>CEH6</status_code>
		    				<status_desc>No existe deuda para los identificadores informados</status_desc>                         
		          </xsl:when>              
		          <xsl:otherwise>
		  				<status_code>0</status_code>
		  				<status_desc>OK</status_desc>
		          </xsl:otherwise>
		        </xsl:choose>
                    
				<contract_id><xsl:value-of select="/request-context/request/message/body/contract_id" /></contract_id>

		        <decimal_places>0</decimal_places>
		

				<!--se suma el monto total de todas las deudas consultadas-->
				<total_amount><xsl:value-of select="format-number(sum(/request-context/services-responses/consulta_deuda/consulta_deuda_bd/response/data/Results/Row/TOTAL_CUOTA),0)" /></total_amount>

				<debts>
					<q><xsl:value-of select="count(/request-context/services-responses/consulta_deuda/consulta_deuda_bd/response/data/Results/Row/DOC_ID)" /></q>
					<xsl:for-each select="/request-context/services-responses/consulta_deuda/consulta_deuda_bd/response/data/Results/Row">

					<debt>
     
	      				<status_code>0</status_code>
	      				<status_desc>OK</status_desc>

                  
							<service_id><xsl:value-of select="ID_SERVICIO" /></service_id>   
							<client_id><xsl:value-of select="ID_CLIENTE" /></client_id>
							<document_id><xsl:value-of select="DOC_ID" /></document_id> 						
							<folio><xsl:value-of select="FOLIO" /></folio>
              				<!--Este campo se guarda en la base de datos?-->				
							<document_type/>			
							<product/>
							<service_name/>              
							<net_amount><xsl:value-of select="TOTAL_CUOTA" /></net_amount>
							<interest_amount>0</interest_amount>
							<tax_amount>0</tax_amount>
							<balance_amount>0</balance_amount>
							<total_amount><xsl:value-of select="TOTAL_CUOTA" /></total_amount>
              				<!--este dato es muy importante, ya que indica cuando vence la cuota-->
							<expiration_date><xsl:value-of select="FECHA_VCTO"/></expiration_date>
														           
			                <additional_data>					
			              	<q_add_data>1</q_add_data>				
			              	<add_data>				
			              		<type>NOMBRE</type>			
			              		<value><xsl:value-of select="NOMBRE_CLIENTE" /></value>			
			              	</add_data>

			              </additional_data>					
              
						</debt>

					</xsl:for-each>
				</debts>
			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>						

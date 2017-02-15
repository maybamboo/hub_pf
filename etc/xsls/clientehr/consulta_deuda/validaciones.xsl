<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<msg_type>consulta_deuda</msg_type>
			</header>
			<body>
				<!--<convenio><xsl:copy-of select="/request-context/services-responses/consulta_deuda/convenio/*"/></convenio>-->
				<convenio><xsl:copy-of select="/request-context/services-responses/default/convenio/*"/></convenio>

				
				<!--De momento las politicas ya no van-->
  				<id_trx_eft><xsl:copy-of select="/request-context/services-responses/consulta_deuda/id_trx_eft/*"/></id_trx_eft>
  				<!--Se envia el resultado de los filtros que se enviaron a base de datos-->
  				<!--darle una vuelta adicional a la validacion del folio-->    
        	        	<parametrosBD><xsl:copy-of select="/request-context/services-responses/consulta_deuda/consulta_parametros/response/data/Results/Row/*"/></parametrosBD>                			
        	        	<id_trx_rec><xsl:value-of select="/request-context/request/message/header/id_trx_rec" /></id_trx_rec>
				<collector_id><xsl:value-of select="/request-context/request/message/header/collector_id" /></collector_id>
				<company_id><xsl:value-of select="/request-context/request/message/header/company_id" /></company_id>
				<currency_code><xsl:value-of select="/request-context/request/message/header/currency_code" /></currency_code>
				<country_code><xsl:value-of select="/request-context/request/message/header/country_code" /></country_code>
			        <contract_id><xsl:value-of select="/request-context/request/message/body/contract_id" /></contract_id>	
			        <channel><xsl:value-of select="/request-context/request/message/header/channel"/></channel>
			        <date><xsl:value-of select="/request-context/request/message/header/date"/></date>
			        <service_id><xsl:value-of select="/request-context/request/message/body/service_id" /></service_id>
			        <client_id><xsl:value-of select="/request-context/request/message/body/client_id" /></client_id>
        		        <folio><xsl:value-of select="/request-context/request/message/body/folio" /></folio>
			</body>		
		</message>
	</xsl:template>
</xsl:stylesheet>

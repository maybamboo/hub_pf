<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<msg_type>notificacion_pago</msg_type>
			</header>
			<body>
				<convenio><xsl:copy-of select="/request-context/services-responses/default/convenio/*"/></convenio>
				<!--De momento las politicas ya no van-->
  				<id_trx_eft><xsl:copy-of select="/request-context/services-responses/notificacion_pago/id_trx_eft/*"/></id_trx_eft><!--Se envia el resultado de los filtros que se enviaron a base de datos-->
  				<!--darle una vuelta adicional a la validacion del folio-->    
                				
				<id_trx_rec><xsl:value-of select="/request-context/request/message/header/id_trx_rec" /></id_trx_rec>
				<payment_date><xsl:value-of select="/request-context/request/message/header/payment_date" /></payment_date>

				<collector_id><xsl:value-of select="/request-context/request/message/body/collector_id" /></collector_id>
				<company_id><xsl:value-of select="/request-context/request/message/header/company_id" /></company_id>
				<currency_code><xsl:value-of select="/request-context/request/message/header/currency_code" /></currency_code>
				<country_code><xsl:value-of select="/request-context/request/message/header/country_code" /></country_code>
				<contract_id><xsl:value-of select="/request-context/request/message/body/contract_id" /></contract_id>
				<channel><xsl:value-of select="/request-context/request/message/body/channel" /></channel>
				<decimal_places><xsl:value-of select="/request-context/request/message/body/decimal_places" /></decimal_places>
				<total_amount><xsl:value-of select="/request-context/request/message/body/total_amount" /></total_amount>


				<xsl:copy-of select="/request-context/request/message/body/settlement_date" />
				<!--transmitter-->
				<xsl:copy-of select="/request-context/request/message/body/transmitter" />
				<!--payment_type-->
				<xsl:copy-of select="/request-context/request/message/body/payment_type" />
				<!--payment_method-->
				<xsl:copy-of select="/request-context/request/message/body/payment_method" />

				<xsl:copy-of select="/request-context/request/message/body/payment"/>
						
			</body>		
		</message>
	</xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<msg_type>reversa_pago</msg_type>
			</header>
			<body>
				<convenio><xsl:copy-of select="/request-context/services-responses/default/convenio/*"/></convenio>
				<!--De momento las politicas ya no van-->
  				<id_trx_eft_rev><xsl:copy-of select="/request-context/services-responses/reversa_pagos/id_trx_eft_rev/*"/></id_trx_eft_rev><!--Se envia el resultado de los filtros que se enviaron a base de datos-->
  				<!--darle una vuelta adicional a la validacion del folio-->    
                				
				<id_trx_rev><xsl:value-of select="/request-context/request/message/header/id_trx_rev" /></id_trx_rev>
				<id_trx_rec><xsl:value-of select="/request-context/request/message/header/id_trx_rec"/></id_trx_rec>
				<id_trx_eft><xsl:value-of select="/request-context/request/message/header/id_trx_eft"/></id_trx_eft>

				<company_id><xsl:value-of select="/request-context/request/message/header/company_id" /></company_id>
				<reverse_date><xsl:value-of select="/request-context/request/message/header/reverse_date" /></reverse_date>


				<contract_id><xsl:value-of select="/request-context/request/message/body/contract_id"/></contract_id>
				<collector_id><xsl:value-of select="/request-context/request/message/body/collector_id" /></collector_id>
				<total_amount><xsl:value-of select="/request-context/request/message/body/total_amount" /></total_amount>

						
			</body>		
		</message>
	</xsl:template>
</xsl:stylesheet>

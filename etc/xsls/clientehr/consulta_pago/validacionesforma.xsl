<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<msg_type>val_cns_pago_forma</msg_type>
			</header>
			<body>
				
			<date><xsl:value-of          select="/request-context/request/message/header/date" /></date>
			<date_type><xsl:value-of     select="/request-context/request/message/body/filters/date_type" /></date_type>
			<company_id><xsl:value-of    select="/request-context/request/message/header/company_id" /></company_id>
			<country_code><xsl:value-of  select="/request-context/request/message/header/country_code" /></country_code>
    		<service_id><xsl:value-of    select="/request-context/request/message/body/filters/service_id" /></service_id>						
    		<client_id><xsl:value-of     select="/request-context/request/message/body/filters/client_id" /></client_id>												
    		<starting_date><xsl:value-of select="/request-context/request/message/body/filters/starting_date" /></starting_date>						
    		<end_date><xsl:value-of      select="/request-context/request/message/body/filters/end_date" /></end_date>
			<folio><xsl:value-of         select="/request-context/request/message/body/filters/folio" /></folio>
			<collector_id><xsl:value-of  select="/request-context/request/message/body/filters/collector_id" /></collector_id>
			<contract_id><xsl:value-of   select="/request-context/request/message/body/filters/contract_id" /></contract_id>

			</body>		
		</message>
	</xsl:template>
</xsl:stylesheet>
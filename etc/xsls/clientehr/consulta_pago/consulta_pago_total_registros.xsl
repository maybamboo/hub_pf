<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      
      <!--retorna la cantidad de registros encontrados en la tabla pago que coincidan los los filtros de busqueda-->        
      <xsl:template match="/">
            <transmission>
            	<type>basedatos</type>
	            <properties>
                   <datasource>gestion_hrpf</datasource>				       
	            </properties>	

      			<data>
      				CALL PKG_CONSULTA_PAGO.TOTAL_REG_CONSULTA_PAGOS
				      (
                              '<xsl:value-of select='/request-context/request/message/body/filters/date_type' />',
				      '<xsl:value-of select='/request-context/request/message/body/filters/service_id' />',
                              '<xsl:value-of select='/request-context/request/message/body/filters/client_id' />',
                              '<xsl:value-of select='/request-context/request/message/body/filters/starting_date' />',
                              '<xsl:value-of select='/request-context/request/message/body/filters/end_date' />',
				      '<xsl:value-of select='/request-context/request/message/body/filters/folio' />',
				      '<xsl:value-of select='/request-context/request/message/body/filters/collector_id' />',
				      '<xsl:value-of select='/request-context/request/message/body/filters/contract_id' />'
				      )					    				
      			</data>

            </transmission>
      </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">	
      
      <!--retorna todos los registros encontrados en la tabla pago que coincidan los los filtros de busqueda-->      
    	<xsl:variable name="pagina" select="/request-context/request/message/body/page - 1" />                             
      <xsl:variable name="tamano_pag">
          <xsl:choose>
              <xsl:when test="request-context/services-responses/consulta_pago/convenio/agreements/response/policies/collector-channel/consultadeuda/consulta_deuda/msg/tamano_pag">
                  <xsl:copy-of select="/request-context/services-responses/consulta_pago/convenio/agreements/response/policies/collector-channel/consultadeuda/consulta_deuda/msg/tamano_pag"/>
              </xsl:when>
              <xsl:otherwise>
                  <xsl:copy-of select="'100'"/><!-- paginacion por defecto si no la puede obtener del adm convenio -->
              </xsl:otherwise>
          </xsl:choose>
      </xsl:variable>
                      
      <xsl:template match="/">
            <transmission>
            	<type>basedatos</type>
	            <properties>
                   <datasource>gestion_hrpf</datasource>				       
	            </properties>	
             
      				<data>
      				    CALL PKG_CONSULTA_PAGO.CONSULTA_PAGOS(
                  '<xsl:value-of select='/request-context/request/message/body/filters/date_type' />',
				          '<xsl:value-of select='/request-context/request/message/body/filters/service_id' />',
                  '<xsl:value-of select='/request-context/request/message/body/filters/client_id' />',
                  '<xsl:value-of select='/request-context/request/message/body/filters/starting_date' />',
                  '<xsl:value-of select='/request-context/request/message/body/filters/end_date' />',
				          '<xsl:value-of select='/request-context/request/message/body/filters/folio' />',
				          '<xsl:value-of select='/request-context/request/message/body/filters/collector_id' />',
				          '<xsl:value-of select='/request-context/request/message/body/filters/contract_id' />',
      				    '<xsl:value-of select='$pagina' />',
      				    '<xsl:value-of select='$tamano_pag' />')				    				
      				</data>
                      		  			  				               
            </transmission>
      </xsl:template>
</xsl:stylesheet>
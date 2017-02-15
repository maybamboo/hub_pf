<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
	
	<!-- 
	 <xsl:variable name="uid" select="uuid:randomUUID()"/>		
	 <response><code>0</code><data><Results><Row><NEXTVAL><xsl:value-of select="replace($uid,'-','')"/></NEXTVAL></Row></Results></data></response>
	 -->
	 
		<transmission>
			<type>basedatos</type>
			<properties>
				<datasource>bd_hub_trx</datasource>
			</properties>
			   <data>select SEQ_TRX_REVERSA.nextval from dual</data>					
		</transmission>
	
	 
	</xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="settlement_date" select="/request-context/request/message/body/settlement_date" />

	<xsl:template match="/">
		<response>
			<xsl:choose>			
				<xsl:when test="string-length($settlement_date)=10 and substring($settlement_date,5,1)= '-' and substring($settlement_date,8,1)" >
					<xsl:call-template name="valida_fecha">
							<xsl:with-param name="yyyy-mm-dd" select="$settlement_date" />
					</xsl:call-template>	
				</xsl:when>
				<xsl:otherwise>
					<code>1</code>
					<description>La fecha no cumple con el formato yyyy-mm-dd</description>
				</xsl:otherwise>
			</xsl:choose>
		</response>
	</xsl:template>


    <xsl:template name="valida_fecha">

        <xsl:param name="yyyy-mm-dd" />

    	<xsl:variable name="yyyy" select="substring-before($yyyy-mm-dd,'-')"/>
    	<xsl:variable name="mm-dd" select="substring-after($yyyy-mm-dd, '-')"/>
    	<xsl:variable name="mm" select="substring-before($mm-dd, '-')"/>
    	<xsl:variable name="dd" select="substring-after($mm-dd, '-')"/>


		<xsl:choose>
			<xsl:when test="not(number($yyyy) &gt; 0)">				
				<code>1</code>
				<description>La fecha no cumple con el formato yyyy-mm-dd</description>
			</xsl:when>
			<xsl:when test="not(number($mm) &gt; 0 and number($mm) &lt; 13)">				
				<code>1</code>
				<description>La fecha no cumple con el formato yyyy-mm-dd</description>
			</xsl:when>
			<xsl:when test="not(number($dd) &gt; 0 and number($dd) &lt; 32)">				
				<code>1</code>
				<description>La fecha no cumple con el formato yyyy-mm-dd</description>
			</xsl:when>
			<xsl:otherwise>
				<code>0</code>
				<description>La fecha cumple con el formato yyyy-mm-dd</description>																		
			</xsl:otherwise>

		</xsl:choose>

    </xsl:template>

</xsl:stylesheet>





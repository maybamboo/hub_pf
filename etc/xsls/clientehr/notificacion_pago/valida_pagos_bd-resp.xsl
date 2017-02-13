<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">

                <response>
                    <code><xsl:value-of select="/response/code"/></code>
                    <xsl:for-each select="/response/data">
                        <data>
                            <xsl:choose>
                                <xsl:when test="current() != '-1'">
                                    <Results>
                                        <Row>
                                            <ESTADO_PAGO><xsl:value-of select="Results/Row/ESTADO_PAGO"/></ESTADO_PAGO>
                                            <ID_SERVICIO><xsl:value-of select="Results/Row/ID_SERVICIO"/></ID_SERVICIO>
                                            <FOLIO><xsl:value-of select="Results/Row/FOLIO"/></FOLIO>
                                            <ID_CLIENTE><xsl:value-of select="Results/Row/ID_CLIENTE"/></ID_CLIENTE>
                                            <DOC_ID><xsl:value-of select="Results/Row/DOC_ID"/></DOC_ID>
                                            <PAG_ID>
                                                <xsl:call-template name="split_value">
                                                        <xsl:with-param name="text" select="Results/Row/PAG_ID" />
                                                        <xsl:with-param name="separator" select="','" />
                                                </xsl:call-template>    
                                            </PAG_ID>
                                            <IN_DOC_ID><xsl:value-of select="Results/Row/IN_DOC_IN"/></IN_DOC_ID>
                                            <TOTAL_CUOTA><xsl:value-of select="Results/Row/TOTAL_CUOTA"/></TOTAL_CUOTA>
                                            <FECHA_VCTO><xsl:value-of select="Results/Row/FECHA_VCTO"/></FECHA_VCTO>
                                            <MONTO_DEUDA_TOTAL><xsl:value-of select="Results/Row/MONTO_DEUDA_TOTAL"/></MONTO_DEUDA_TOTAL>
                                            <COMISION_LINEA><xsl:value-of select="Results/Row/COMISION_LINEA"/></COMISION_LINEA>
                                            <IMPUESTO><xsl:value-of select="Results/Row/IMPUESTO"/></IMPUESTO>
					    <DECIMALES><xsl:value-of select="Results/Row/DECIMALES"/></DECIMALES>
                                            <POSITION><xsl:value-of select="Results/Row/POSITION"/></POSITION>
                                        </Row>
                                    </Results>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="current()"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </data>
                    </xsl:for-each>
                </response>

    </xsl:template>

    <xsl:template name="split_value">
        
        <xsl:param name="text"/>
        <xsl:param name="separator"/>
        <xsl:choose>
            <xsl:when test="not(contains($text, $separator))">
                <row>
                    <xsl:value-of select="normalize-space($text)"/>
                </row>
            </xsl:when>
            <xsl:otherwise>
                <row>
                    <xsl:value-of select="normalize-space(substring-before($text, $separator))"/>
                </row>
                <xsl:call-template name="split_value">
                    <xsl:with-param name="text" select="substring-after($text, $separator)"/>
                    <xsl:with-param name="separator" select="','" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>

</xsl:stylesheet>




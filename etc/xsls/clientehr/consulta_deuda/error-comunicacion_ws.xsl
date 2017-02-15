<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
        <xsl:template match="/">

                <message>
                        <header>
                                <msg_type>RSCD01</msg_type>
                                <xsl:copy-of select="/request-context/request/message/header/id_trx_rec/self::node()"/>
                                <id_trx_eft>
                                        <xsl:value-of select="/request-context/services-responses/consulta_deuda/id_trx_eft/response/data/Results/Row/NEXTVAL"/>
                                </id_trx_eft>
                                <id_trx_eps/>
                                <date>
                                        <xsl:value-of select="current-dateTime()"/>
                                </date>
                                <xsl:copy-of select="/request-context/request/message/header/currency_code"/>
                        </header>
                        <body>

                                <status_code>CEH3</status_code>
                                <status_desc>Problemas de comunicación con la empresa de servicio</status_desc>
                                <xsl:copy-of select="/request-context/request/message/body/contract_id"/>
                                <decimal_places>0</decimal_places>
                                <total_amount>0</total_amount>

                                <debts>
                                        <q>0</q>
                                </debts>
                        </body>
                </message>
        </xsl:template>
</xsl:stylesheet>

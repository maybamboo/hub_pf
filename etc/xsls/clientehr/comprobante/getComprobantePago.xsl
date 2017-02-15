<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <xsl:template match="/">
            <transmission>
                  <type>basedatos</type>
                  <properties>
	                  <datasource>bd_hub_trx</datasource>
                  </properties>
				  <xsl:for-each select="/request-context/request/message/body/parameters">
				  <data>
					SELECT
                                        NVL(P.ID_TRX_REC,'-') AS ID_TRX_REC,
                                        NVL(P.ID_TRX_EFT,'-') AS ID_TRX_EFT,
                                        NVL(P.ID_TRX_EPS,'-') AS ID_TRX_EPS,
                                        P.FECHA_TRX AS FECHA_TRX,
                                        NVL(P.RECAUDADOR_ID, '-')AS RECAUDADOR_ID,
                                        NVL(P.EMPRESA_ID,'-')AS EMPRESA_ID,
                                        NVL(P.NUM_CONVENIO, '-') AS NUM_CONVENIO,
                                        NVL(P.ID_CLIENTE, '-') AS ID_CLIENTE,
                                        NVL(P.ID_SERVICIO,'-') AS ID_SERVICIO,
                                        NVL(P.MONTO_PAGO,0)AS MONTO_PAGO,
                                        NVL(D.MONTO_SALDO,0)AS MONTO_SALDO,
                                        NVL(P.MEDIO_PAGO,'-') AS COD_MEDIO_PAGO,
                                        NVL(P.EMISOR,'-') AS EMISOR,
                                        NVL(P.CUOTA,0) AS CUOTA,
                                        NVL(MP.DESCRIPCION,'-') AS MEDIO_PAGO,
                                        NVL(P.ESTADO_PAGO,0) AS ESTADO_PAGO,
                                        EP.DESCRIPCION AS DESC_ESTADO_PAGO
                                        FROM PAGO P, ESTADO_PAGO EP, MEDIO_PAGO MP, DOCUMENTO D
				  	where p.id_trx_eft = <xsl:value-of select="parameter[name/text()='id_trx']/value" />
					     
					     and P.ESTADO_PAGO=EP.CODIGO 
					     and MP.CODIGO=P.MEDIO_PAGO
					     and p.doc_id=d.doc_id
				  </data>
				  
				  </xsl:for-each>
                  
            </transmission>
      </xsl:template>
</xsl:stylesheet>

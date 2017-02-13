<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<msg_type>RNP01</msg_type>
				<xsl:copy-of
					select="/request-context/request/message/header/id_trx_rec/self::node()" />

				<id_trx_eft>
					<xsl:value-of
						select="/request-context/services-responses/notificacion_pago_portal/idtrxeft/response/data/Results/Row/NEXTVAL" />
				</id_trx_eft>
				<id_trx_eps>
					<xsl:value-of
						select="/request-context/services-responses/notificacion_pago_portal/idtrxeft/response/data/Results/Row/NEXTVAL" />
				</id_trx_eps>


				<xsl:copy-of select="/request-context/request/header/company_id" />
				<payment_date>
					<xsl:value-of select="current-dateTime()" />
				</payment_date>

			</header>
			<body>
				<status_code>0</status_code>
				<status_desc>OK</status_desc>
				<voucher_code></voucher_code>
				<payment>

					<xsl:for-each select="/request-context/request/message/body/payment">
						<xsl:variable name="monto_total" select="/request-context/services-responses/notificacion_pago_portal/consultadeuda/response/data/Results/Row[position()]/MONTO_TOTAL" />
						<xsl:variable name="service_id" select="service_id"/>
						<xsl:variable name="client_id" select="client_id"/>
						<xsl:variable name="document_id" select="document_id"/>
						<xsl:variable name="pago" select="/request-context/services-responses/notificacion_pago_portal/pagadeuda/response/data/Results/Row[RETORNO = 0 and ID_SERVICIO = $service_id and ID_CLIENTE = $client_id and DOC_ID = $document_id]"/>
						
						<service_id><xsl:value-of select="$service_id" /></service_id>
						<document_id><xsl:value-of select="$document_id" /></document_id>
						
																			
						<xsl:choose>
							<xsl:when test="amount  = $monto_total">																					
								<xsl:choose>
									<xsl:when test = "$pago">
										<status_code>0</status_code>
										<status_desc>OK</status_desc>
									</xsl:when>
									<xsl:otherwise>
										<status_code>CEH2</status_code>
										<status_desc>En estos momentos el sistema no se encuentra disponible</status_desc>
									</xsl:otherwise>
								</xsl:choose>																
							</xsl:when>
							<xsl:otherwise>
										<status_code>CEF201</status_code>
										<status_desc>Monto no coincide.</status_desc>
							</xsl:otherwise>
						</xsl:choose>
						
					</xsl:for-each>
				</payment>
			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>						

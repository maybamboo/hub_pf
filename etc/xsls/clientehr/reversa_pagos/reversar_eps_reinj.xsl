<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="request_message" select="/request-context/request/message" />
		
	<xsl:template match="/">

		<reinject>
			<type>ADD</type>
			<id>
				<!--r=reintentar n=reversa e=eps-->
				<xsl:value-of
					select="concat('r-r-e',/request-context/services-responses/reversa_pagos/id_trx_eft_rev/response/data/Results/Row/NEXTVAL)" />
			</id>

			<!--La configuracion se obtiene directamente del convenio-->
			<xsl:copy-of select="/request-context/services-responses/default/convenio/msg/reglas_reversa/reintento/*"/>
			<!--El cut-hour se dejara, ya que no se esta configurando a travez de la interfaz-->
			<cut-hour></cut-hour>
			
			<message>

				<message>

					<header>
						<msg_type>SRRP01</msg_type>
					</header>

					<body>
						<!--Se envia el contract_id para poder encontrar la carpeta con las transformaciones-->
						<contract_id><xsl:value-of select="/request-context/request/message/body/contract_id"/></contract_id>
						<!--El mensaje se arma utilizando la transformacion guardada en el administrador de convenios-->
						<id_trx_eft><xsl:value-of select="/request-context/request/message/header/id_trx_eft"/></id_trx_eft>
						<id_trx_rec><xsl:value-of select="/request-context/request/message/header/id_trx_rec"/></id_trx_rec>
						<id_trx_eft_rev><xsl:value-of select="/request-context/services-responses/reversa_pagos/id_trx_eft_rev/response/data/Results/Row/NEXTVAL"/></id_trx_eft_rev>
						<id_trx_rev><xsl:value-of select="/request-context/request/message/header/id_trx_rev"/></id_trx_rev>
						<transmission>
							<type><xsl:value-of select="/request-context/services-responses/default/convenio/msg/reglas_reversa/tipoConector"/></type>
							<xsl:copy-of select="/request-context/services-responses/default/convenio/msg/reglas_reversa/conector/properties"/>
							<xsl:copy-of select="/request-context/services-responses/reversa_pagos/transformar/response/data"/>
						</transmission>	

					</body>

				</message>
			</message>
		</reinject>
	</xsl:template>
</xsl:stylesheet>
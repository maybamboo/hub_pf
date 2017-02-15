<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="request_message" select="/request-context/request/message" />
		
	<xsl:template match="/">

		<reinject>
			<type>ADD</type>
			<id>
				<!--r=reintentar n=notificacion e=eps-->
				<xsl:value-of
					select="concat('r-n-e',/request-context/services-responses/notificacion_pago/id_trx_eft/response/data/Results/Row/NEXTVAL)" />
			</id>

			<!--La configuracion se obtiene directamente del convenio-->
			<xsl:copy-of select="/request-context/services-responses/default/convenio/msg/reglas_pago/reintento/*"/>
			<!--El cut-hour se dejara, ya que no se esta configurando a travez de la interfaz-->
			<cut-hour></cut-hour>
			
			<message>

				<message>

					<header>
						<msg_type>SRNP01</msg_type>
					</header>

					<body>
						<!--Se envia el contract_id para que se pueda encontrar la carpeta con transformaciones-->
						<contract_id><xsl:value-of select="/request-context/request/message/body/contract_id"/></contract_id>
						<!--Se necesita para actualizar el estado de los pagos a notificados en caso de exito-->
						<id_trx_eft><xsl:value-of select="/request-context/services-responses/notificacion_pago/id_trx_eft/response/data/Results/Row/NEXTVAL"/></id_trx_eft>
						<!--El mensaje se arma utilizando la transformacion guardada en el administrador de convenios-->
						<transmission>
							<type><xsl:value-of select="/request-context/services-responses/default/convenio/msg/reglas_pago/tipoConector"/></type>
							<xsl:copy-of select="/request-context/services-responses/default/convenio/msg/reglas_pago/conector/properties"/>
							<xsl:copy-of select="/request-context/services-responses/notificacion_pago/transformar/response/data"/>
						</transmission>	

					</body>

				</message>
			</message>
		</reinject>
	</xsl:template>
</xsl:stylesheet>
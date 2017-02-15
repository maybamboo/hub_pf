<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="comision_linea" select="/request-context/services-responses/default/convenio/msg/reglas_generales/comision_linea" />
	<xsl:variable name="impuesto" select="/request-context/services-responses/default/convenio/msg/reglas_generales/comision_linea/impuesto" />
	<xsl:variable name="pagos" select="/request-context/request/message/body/payment"/>
	<xsl:variable name="decimal_places" select="/request-context/request/message/body/decimal_places"/>

	<xsl:template match="/">


		<xsl:variable name="potencia">		
				<xsl:choose>					
					<xsl:when test="$decimal_places != ''">
						<xsl:call-template name="power-of-10">
							<xsl:with-param name="exponent" select="$decimal_places"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="power-of-10">
							<xsl:with-param name="exponent" select="'0'"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>			
		</xsl:variable>

		<pagos>
			<xsl:choose>
				<xsl:when test="$comision_linea/habilitado = 1">
					<!--Se evalua si la comision es fija-->					
					<xsl:choose>
						<xsl:when test="$comision_linea/tipo = 'fija'">
							<xsl:variable name="comision" select="$comision_linea/valor"/>
							<xsl:choose>
								<xsl:when test="$impuesto/habilitado = 1">
									<!--Comision fija e impuesto habilitado-->
									<xsl:variable name="porcentaje_impuesto" select="$impuesto/valor"/>
									<xsl:for-each select="$pagos">


										<!--Se almacenan todos los datos adicionales que correspondan a un medio de pago-->
										<xsl:variable name="additional_data" select="additional_data/add_data[substring-before(type,'-')= 'MP']"/>
										<pago>
											<xsl:for-each select="$additional_data">
												<!--Se asume que el type es MP-->
												<xsl:variable name="monto_bruto_sr" select="value div $potencia"/>
												<xsl:variable name="monto_bruto" select="round($monto_bruto_sr * 100) div 100"/>
												<xsl:variable name="impuesto_sr" select="($comision * $porcentaje_impuesto) div 100"/>
												<!--Se calcula en funcion de la comision-->
												<xsl:variable name="impuesto" select="round( $impuesto_sr * 100) div 100"/>
												<xsl:variable name="monto_neto" select="$monto_bruto_sr - $comision -$impuesto"/>
												<medio_pago>											
													<comision><xsl:value-of select="$comision"/></comision>
													<impuesto><xsl:value-of select="$impuesto"/></impuesto>
													<monto_neto><xsl:value-of select="$monto_neto"/></monto_neto>
													<monto_bruto><xsl:value-of select="$monto_bruto"/></monto_bruto>
												</medio_pago>
											</xsl:for-each>
										</pago>


									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<!--Comisión fija e impuesto no habilitado-->				
									<xsl:for-each select="$pagos">
										<pago>
											<xsl:variable name="additional_data" select="additional_data/add_data[substring-before(type,'-')= 'MP']"/>
											<xsl:for-each select="$additional_data">
												<xsl:variable name="monto_bruto_sr" select="value div $potencia"/>
												<xsl:variable name="monto_bruto" select="round($monto_bruto_sr * 100) div 100 "/>
												<xsl:variable name="monto_neto" select="$monto_bruto_sr - $comision"/>
													<medio_pago>
														<comision><xsl:value-of select="$comision"/></comision>
														<impuesto>0</impuesto>
														<monto_neto><xsl:value-of select="$monto_neto"/></monto_neto>
														<monto_bruto><xsl:value-of select="$monto_bruto"/></monto_bruto>
													</medio_pago>
											</xsl:for-each>
										</pago>



									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>

						</xsl:when>
						<xsl:otherwise>
							<xsl:variable name="porcentaje_comision" select="$comision_linea/valor"/>
							<xsl:choose>
								<xsl:when test="$impuesto/habilitado = 1">
									<xsl:for-each select="$pagos">

										<xsl:variable name="additional_data" select="additional_data/add_data[substring-before(type,'-')= 'MP']"/>
										<pago>
											<xsl:for-each select="$additional_data">

												<xsl:variable name="porcentaje_impuesto" select="$impuesto/valor"/>
												<xsl:variable name="monto_bruto_sr" select="value div $potencia"/>
												<xsl:variable name="monto_bruto" select="round($monto_bruto_sr) div 100"/>
												<xsl:variable name="monto_neto_sr" select="$monto_bruto_sr div (1 + (($porcentaje_comision * $porcentaje_impuesto) div 10000) + ($porcentaje_comision div 100))"/>
												<xsl:variable name="monto_neto" select="round($monto_neto_sr * 100) div 100"/>
												<xsl:variable name="comision_sr" select="($porcentaje_comision * $monto_neto) div 100"/>
												<xsl:variable name="comision" select="round($comision_sr * 100) div 100"/>
												<!--vamos a usar la comision para calcular el impuesto, tambien podemos calcularlo por formula directamente-->
												<xsl:variable name="impuesto_sr" select="($porcentaje_comision * $monto_neto * $porcentaje_impuesto) div 10000"/>
												<xsl:variable name="impuesto" select="round($impuesto_sr * 100) div 100"/>
												
												<medio_pago>
													<comision><xsl:value-of select="$comision"/></comision>
													<impuesto><xsl:value-of select="$impuesto"/></impuesto>
													<monto_neto><xsl:value-of select="$monto_neto"/></monto_neto>
													<monto_bruto><xsl:value-of select="$monto_bruto"/></monto_bruto>
												</medio_pago>
											</xsl:for-each>
										</pago>

									</xsl:for-each>


									<!--Comision porcentual e impuesto habilitado-->
								</xsl:when>
								<xsl:otherwise>
									<!--Comision porcentual e impuesto no habilitado-->
									<xsl:for-each select="$pagos">

										<xsl:variable name="additional_data" select="additional_data/add_data[substring-before(type,'-')= 'MP']"/>

										<xsl:for-each select="$additional_data">
											<xsl:variable name="monto_bruto_sr" select="value div $potencia"/>
											<xsl:variable name="monto_bruto" select="round($monto_bruto_sr * 100) div 100"/>
											<xsl:variable name="monto_neto_sr" select="$monto_bruto_sr div (1 + ($porcentaje_comision div 100))"/>
											<xsl:variable name="monto_neto" select="round($monto_neto_sr * 100) div 100"/>
											<xsl:variable name="comision_sr" select="($porcentaje_comision * $monto_neto) div 100"/>
											<xsl:variable name="comision" select="round($comision_sr * 100) div 100"/>
											<medio_pago>
												<comision><xsl:value-of select="$comision"/></comision>
												<impuesto>0</impuesto>
												<monto_neto><xsl:value-of select="$monto_neto"/></monto_neto>
												<monto_bruto><xsl:value-of select="$monto_bruto"/></monto_bruto>
											</medio_pago>
										</xsl:for-each>



									</xsl:for-each>

								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!--No esta activada la configuracion de comision en linea, ni tampoco de impuesto-->
					<xsl:for-each select="$pagos">
						<pago>
							<xsl:variable name="additional_data" select="additional_data/add_data[substring-before(type,'-')= 'MP']"/>

							<xsl:for-each select="$additional_data">
								<medio_pago>
									<comision>0</comision>
									<impuesto>0</impuesto>
									<monto_neto><xsl:value-of select="value"/></monto_neto>
									<monto_bruto><xsl:value-of select="value"/></monto_bruto>
								</medio_pago>

							</xsl:for-each>


						</pago>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</pagos>

	</xsl:template>
	

	<xsl:template name="power-of-10">
	    <xsl:param name="exponent"/>
	    <xsl:param name="result" select="1"/>
	    <xsl:choose>
	        <xsl:when test="$exponent">
	            <xsl:call-template name="power-of-10">
	                <xsl:with-param name="exponent" select="$exponent - 1"/>
	                <xsl:with-param name="result" select="$result * 10"/>
	            </xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:value-of select="$result"/>
	        </xsl:otherwise>
	    </xsl:choose>
	</xsl:template>

</xsl:stylesheet>

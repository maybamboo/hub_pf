<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="comision_linea" select="/request-context/services-responses/default/convenio/msg/reglas_generales/comision_linea" />
	<xsl:variable name="impuesto" select="/request-context/services-responses/default/convenio/msg/reglas_generales/comision_linea/impuesto" />
	<xsl:variable name="pagos" select="/request-context/request/message/body/payment"/>	
	<xsl:variable name="decimal_places" select="/request-context/request/message/body/decimal_places"/>
	<xsl:variable name="pagos_bd" select="/request-context/services-responses/notificacion_pago/valida_pagos_bd/response/data/Results/Row"/>

	<xsl:template match="/">



		<xsl:variable name="potencia">		
				<xsl:choose>					
					<xsl:when test="$decimal_places != ''">
						<xsl:call-template name="power-of-10">
							<xsl:with-param name="exponent" select="number($decimal_places)"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="power-of-10">
							<xsl:with-param name="exponent" select="0"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>			
		</xsl:variable>
		


		<!--Se evalua si esta activada la comision en linea. Si no esta activada, entonces rellenamos con 0-->
		<pagos>
			<!--Esto funciona en el caso ideal que solo se paguen montos exactos
			<xsl:for-each select="$pagos">
					<xsl:variable name="comision" select="COMISION_LINEA"/>
					<xsl:variable name="impuesto" select="IMPUESTO"/>
					<xsl:variable name="monto_neto" select="TOTAL_CUOTA"/>
				<pago>
					<comision><xsl:value-of select="$comision"/></comision>
					<impuesto><xsl:value-of select="$impuesto"/></impuesto>
					<monto_neto><xsl:value-of select="$monto_neto"/></monto_neto>
					<monto_bruto><xsl:value-of select="$comision + $impuesto + $monto_neto"/></monto_bruto>
				</pago>
			</xsl:for-each>-->

			<!--Como se admiten pagos parciales y sobrepagos, tenemos que calcular la comision y cuota en base a los valores que tenemos-->


			<!--El monto bruto incluye la comision y el impuesto-->
			<!--El monto neto es lo que realmente se esta pagando luego de descontar el impuesto y la comisión-->


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
									
									
										<xsl:variable name="potencia_bd">																													
														<xsl:call-template name="power-of-10">
															<xsl:with-param name="exponent" select="number($pagos_bd[position()]/DECIMALES)"/>
														</xsl:call-template>														
										</xsl:variable>
												
														
										<xsl:variable name="monto_bruto_bd" select="format-number( ($pagos_bd[position()]/TOTAL_CUOTA div $potencia_bd ) + substring(concat($pagos_bd[position()]/COMISION_LINEA, '0000000000000000000000000000000'), 1, string-length($pagos_bd[position()]/COMISION_LINEA)+$pagos_bd[position()]/DECIMALES) + $pagos_bd[position()]/IMPUESTO,'0.##') * $potencia_bd"/>																			
										<xsl:variable name="monto_bruto_sr" select="amount"/>
														
										<monto_bruto_sr><xsl:value-of select="$monto_bruto_sr"/></monto_bruto_sr>
										<monto_bruto_bd><xsl:value-of select="$monto_bruto_bd"/></monto_bruto_bd>						
										<xsl:choose>
											<xsl:when test="$monto_bruto_bd = $monto_bruto_sr">
												<!--Pago exacto-->	
												<xsl:variable name="comision" select="$pagos_bd[position()]/COMISION_LINEA"/>
												<xsl:variable name="impuesto" select="$pagos_bd[position()]/IMPUESTO"/>
												<xsl:variable name="monto_neto" select="$pagos_bd[position()]/TOTAL_CUOTA"/>
												<xsl:variable name="monto_bruto" select="$monto_bruto_sr"/>
												
												
												<pago>
													<comision><xsl:value-of select="$comision"/></comision>
													<impuesto><xsl:value-of select="$impuesto"/></impuesto>
													<monto_neto><xsl:value-of select="$monto_neto"/></monto_neto>
													<monto_bruto><xsl:value-of select="$monto_bruto"/></monto_bruto>
												</pago>
												
											</xsl:when>
											<xsl:otherwise>
												<xsl:variable name="monto_bruto" select="round($monto_bruto_sr * 100) div 100 "/>
												<xsl:variable name="impuesto_sr" select="($comision * $porcentaje_impuesto) div 100"/>
												<!--Se calcula en funcion de la comision-->
												<xsl:variable name="impuesto" select="round( $impuesto_sr * 100) div 100"/>
												<xsl:variable name="monto_neto_sr" select="(($monto_bruto_sr div $potencia) - $comision - $impuesto) * $potencia"/>
												<xsl:variable name="monto_neto" select="round($monto_neto_sr * 100) div 100"/>
												
												<pago>												
													<comision><xsl:value-of select="$comision"/></comision>
													<impuesto><xsl:value-of select="$impuesto"/></impuesto>
													<monto_neto><xsl:value-of select="$monto_neto"/></monto_neto>
													<monto_bruto><xsl:value-of select="$monto_bruto"/></monto_bruto>
												</pago>
											</xsl:otherwise>	
										</xsl:choose>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<!--Comisión fija e impuesto no habilitado-->				
									<xsl:for-each select="$pagos">
					<!--a la comision en linea se le agrega los decimales -->
					
					
										<xsl:variable name="potencia_bd">																													
														<xsl:call-template name="power-of-10">
															<xsl:with-param name="exponent" select="number($pagos_bd[position()]/DECIMALES)"/>
														</xsl:call-template>														
										</xsl:variable>
												
														
										<xsl:variable name="monto_bruto_bd" select="format-number( ($pagos_bd[position()]/TOTAL_CUOTA div $potencia_bd ) + substring(concat($pagos_bd[position()]/COMISION_LINEA, '0000000000000000000000000000000'), 1, string-length($pagos_bd[position()]/COMISION_LINEA)+$pagos_bd[position()]/DECIMALES) + $pagos_bd[position()]/IMPUESTO,'0.##') * $potencia_bd"/>					
										<!-- <xsl:variable name="monto_bruto_bd" select="format-number($pagos_bd[position()]/TOTAL_CUOTA + substring(concat($pagos_bd[position()]/COMISION_LINEA, '0000000000000000000000000000000'), 1, string-length($pagos_bd[position()]/COMISION_LINEA)+$pagos_bd[position()]/DECIMALES) + $pagos_bd[position()]/IMPUESTO,'0.##')"/> -->
										<xsl:variable name="monto_bruto_sr" select="amount"/>
										
										
											<monto_bruto_sr><xsl:value-of select="$monto_bruto_sr"/></monto_bruto_sr>
										<monto_bruto_bd><xsl:value-of select="$monto_bruto_bd"/></monto_bruto_bd>						
										<xsl:choose>
											<xsl:when test="$monto_bruto_bd = $monto_bruto_sr">
												<!--Pago exacto-->	
												<xsl:variable name="comision" select="$pagos_bd[position()]/COMISION_LINEA"/>
												<xsl:variable name="monto_neto" select="$pagos_bd[position()]/TOTAL_CUOTA"/>
												<xsl:variable name="monto_bruto" select="$monto_bruto_sr"/>
												
												<pago>
													<comision><xsl:value-of select="$comision"/></comision>
													<impuesto>0</impuesto>
													<monto_neto><xsl:value-of select="$monto_neto"/></monto_neto>
													<monto_bruto><xsl:value-of select="$monto_bruto"/></monto_bruto>
												</pago>
											</xsl:when>
											<xsl:otherwise>
												<xsl:variable name="monto_bruto" select="round($monto_bruto_sr * 100) div 100"/>
												<xsl:variable name="monto_neto_sr" select="(($monto_bruto_sr div $potencia) - $comision) * $potencia"/>
												<xsl:variable name="monto_neto" select="round($monto_neto_sr * 100) div 100"/>
												
												<pago>
													<comision><xsl:value-of select="$comision"/></comision>
													<impuesto>0</impuesto>
													<monto_neto><xsl:value-of select="$monto_neto"/></monto_neto>
													<monto_bruto><xsl:value-of select="$monto_bruto"/></monto_bruto>
												</pago>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>

						</xsl:when>
						<xsl:otherwise>
							<xsl:variable name="porcentaje_comision" select="$comision_linea/valor"/>
							<xsl:choose>
								<xsl:when test="$impuesto/habilitado = 1">
									<!--Comision porcentual e impuesto habilitado-->
									<xsl:for-each select="$pagos">	
									
									
									
									
									<!--se suman los valores obtenidos de la base de datos sin los separadores de decimales-->
										<xsl:variable name="monto_bruto_bd" select="$pagos_bd[position()]/TOTAL_CUOTA  + $pagos_bd[position()]/COMISION_LINEA *100 + $pagos_bd[position()]/IMPUESTO *100"/>
										
										<xsl:variable name="monto_bruto_sr" select="amount"/>
										
										<monto_bruto_sr><xsl:value-of select="$monto_bruto_sr"/></monto_bruto_sr>
										<monto_bruto_bd><xsl:value-of select="$monto_bruto_bd"/></monto_bruto_bd>
										
										<xsl:choose>
											<xsl:when test="$monto_bruto_bd = $monto_bruto_sr">
												<!--Pago exacto-->
												<xsl:variable name="comision" select="$pagos_bd[position()]/COMISION_LINEA"/>
												
												<xsl:variable name="impuesto" select="$pagos_bd[position()]/IMPUESTO"/>
												
												<xsl:variable name="monto_neto" select="$pagos_bd[position()]/TOTAL_CUOTA"/>
												
												<xsl:variable name="monto_bruto" select="$monto_bruto_sr"/>
												
												<pago>
												<prueba>MIGA</prueba>
													<comision><xsl:value-of select="$comision"/></comision>
													<impuesto><xsl:value-of select="$impuesto"/></impuesto>
													<monto_neto><xsl:value-of select="$monto_neto"/></monto_neto>
													<monto_bruto><xsl:value-of select="$monto_bruto"/></monto_bruto>
												</pago>
											</xsl:when>
											<xsl:otherwise>
												<xsl:variable name="porcentaje_impuesto" select="$impuesto/valor"/>
												<!-- <xsl:variable name="monto_bruto" select="round($monto_bruto_sr * 100) div 100 "/>  -->
												<xsl:variable name="monto_bruto" select="$monto_bruto_sr"/>
												<xsl:variable name="comision_sr" select="(100*($monto_bruto_sr div $potencia)*$porcentaje_comision) div (10000 + 100 * $porcentaje_comision +  $porcentaje_comision* $porcentaje_impuesto )" />		
												<xsl:variable name="monto_neto_sr" select="(100*($monto_bruto_sr div $potencia) - $comision_sr*$porcentaje_impuesto) div (100 + $porcentaje_comision)" />												
												<xsl:variable name="monto_neto" select="round($monto_neto_sr * 100) div 100"/>
												<!--
												<xsl:variable name="monto_neto_sr" select="$monto_bruto_sr div (1 + (($porcentaje_comision * $porcentaje_impuesto) div 10000) + ($porcentaje_comision div 100))"/>
												
												 -->
												<!-- <xsl:variable name="comision_sr" select="($porcentaje_comision * $monto_neto_sr) div 100"/>
												<xsl:variable name="comision" select="round($comision_sr * 100) div 100"/>  -->
												<!--vamos a usar la comision para calcular el impuesto, tambien podemos calcularlo por formula directamente-->
												<xsl:variable name="comision" select="round($comision_sr * 100) div 100"/>
												<xsl:variable name="impuesto_sr" select="($porcentaje_comision * $monto_neto_sr * $porcentaje_impuesto) div 10000"/>
												<xsl:variable name="impuesto" select="round($impuesto_sr * 100) div 100"/>
												
												<pago>																					
													<comision><xsl:value-of select="$comision"/></comision>
													<impuesto><xsl:value-of select="$impuesto"/></impuesto>
													<monto_neto><xsl:value-of select="$monto_neto * $potencia"/></monto_neto>
													<monto_bruto><xsl:value-of select="$monto_bruto"/></monto_bruto>
												</pago>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<!--Comision porcentual e impuesto no habilitado-->
									<xsl:for-each select="$pagos">
									
										<xsl:variable name="potencia_bd">																													
														<xsl:call-template name="power-of-10">
															<xsl:with-param name="exponent" select="number($pagos_bd[position()]/DECIMALES)"/>
														</xsl:call-template>														
										</xsl:variable>
												
														
										<xsl:variable name="monto_bruto_bd" select="format-number( ($pagos_bd[position()]/TOTAL_CUOTA div $potencia_bd ) + substring(concat($pagos_bd[position()]/COMISION_LINEA, '0000000000000000000000000000000'), 1, string-length($pagos_bd[position()]/COMISION_LINEA)+$pagos_bd[position()]/DECIMALES) + $pagos_bd[position()]/IMPUESTO,'0.##') * $potencia_bd"/>																			
									
									
									<!-- <xsl:variable name="monto_bruto_bd" select="format-number($pagos_bd[position()]/TOTAL_CUOTA + substring(concat($pagos_bd[position()]/COMISION_LINEA, '0000000000000000000000000000000'), 1, string-length($pagos_bd[position()]/COMISION_LINEA)+$pagos_bd[position()]/DECIMALES) + $pagos_bd[position()]/IMPUESTO,'0.##')"/> -->					
									
										<xsl:variable name="monto_bruto_sr" select="amount"/>
												<monto_bruto_sr><xsl:value-of select="$monto_bruto_sr"/></monto_bruto_sr>
										    <monto_bruto_bd><xsl:value-of select="$monto_bruto_bd"/></monto_bruto_bd>		
										<xsl:choose>
										
									
										
											<xsl:when test="$monto_bruto_bd = $monto_bruto_sr">
												<!--Pago exacto-->	
												<xsl:variable name="comision" select="$pagos_bd[position()]/COMISION_LINEA"/>
												<xsl:variable name="monto_neto" select="$pagos_bd[position()]/TOTAL_CUOTA"/>
												<xsl:variable name="monto_bruto" select="$monto_bruto_sr"/>
												
												<pago>
													<comision><xsl:value-of select="$comision"/></comision>
													<impuesto>0</impuesto>
													<monto_neto><xsl:value-of select="$monto_neto"/></monto_neto>
													<monto_bruto><xsl:value-of select="$monto_bruto"/></monto_bruto>
												</pago>
											</xsl:when>
											<xsl:otherwise>
											
												<xsl:variable name="porcentaje_impuesto" select="'0'"/>
												<xsl:variable name="monto_bruto" select="$monto_bruto_sr"/>
												<xsl:variable name="comision_sr" select="(100*($monto_bruto_sr div $potencia)*$porcentaje_comision) div (10000 + 100 * $porcentaje_comision +  $porcentaje_comision* $porcentaje_impuesto )" />		
												<xsl:variable name="monto_neto_sr" select="(100*($monto_bruto_sr div $potencia) - $comision_sr*$porcentaje_impuesto) div (100 + $porcentaje_comision)" />												
												<xsl:variable name="monto_neto" select="round($monto_neto_sr * 100) div 100"/>
											
												<xsl:variable name="comision" select="round($comision_sr * 100) div 100"/>
												<xsl:variable name="impuesto_sr" select="($porcentaje_comision * $monto_neto_sr * $porcentaje_impuesto) div 10000"/>
												<xsl:variable name="impuesto" select="round($impuesto_sr * 100) div 100"/>
											
												<!-- <xsl:variable name="monto_bruto" select="round($monto_bruto_sr * 100) div 100"/>
												<xsl:variable name="monto_neto_sr" select="$monto_bruto_sr div (1 + ($porcentaje_comision div 100))"/>
												<xsl:variable name="monto_neto" select="round($monto_neto_sr * 100) div 100"/>
												<xsl:variable name="comision_sr" select="($porcentaje_comision * $monto_neto_sr) div 100"/>
												<xsl:variable name="comision" select="round($comision_sr * 100) div 100"/>
												 -->
												 
												<pago>
													<comision><xsl:value-of select="$comision"/></comision>
													<impuesto>0</impuesto>
													<monto_neto><xsl:value-of select="$monto_neto * $potencia"/></monto_neto>
													<monto_bruto><xsl:value-of select="$monto_bruto"/></monto_bruto>
												</pago>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>

								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!--No esta activada la configuracion de comision en linea, ni tampoco de impuesto-->
					<xsl:for-each select="$pagos">
						<xsl:variable name="monto_neto" select="amount"/>
						<pago>
							<comision>0</comision>
							<impuesto>0</impuesto>
							<monto_neto><xsl:value-of select="$monto_neto"/></monto_neto>
							<monto_bruto><xsl:value-of select="$monto_neto"/></monto_bruto>
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

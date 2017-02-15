<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:variable name="cod_empresa_holding" select="/request-context/services-responses/default/convenio/msg/empresa_holding/cod_emp" />

	<xsl:template name="data_folio">
		<xsl:variable name="id_servicio" select="/request-context/request/message/body/service_id"/>
		<xsl:variable name="folio" select="/request-context/request/message/body/folio"/>
		<data>
			select doc_id,nombre_cliente,id_cliente,id_servicio,folio,total_cuota,fecha_vcto from documento where cod_empresa_holding = $cod_empresa_holding and id_servicio=&#39;<xsl:value-of select="$id_servicio"/>&#39; and folio=&#39;<xsl:value-of select="$folio"/>&#39; and doc_id not in (select doc_id from pago where pago.doc_id = documento.doc_id and estado_pago=0)		    
		</data>
	</xsl:template>
	

	<xsl:template name="data_idservicio">

			<xsl:variable name="msg" select="/request-context/services-responses/default/convenio/msg/reglas_consulta"/>

			<xsl:variable name="filtros" select="$msg/campo_filtro/filtros/filtro"/>
			<xsl:variable name="query_base" select="'select * from (select doc_id,nombre_cliente,id_cliente,id_servicio,folio,total_cuota,fecha_vcto from documento where cod_empresa_holding = $cod_empresa_holding and id_servicio='"/>
			<xsl:variable name="filtro_deuda_pagada" select="'and doc_id not in (select doc_id from pago where pago.doc_id = documento.doc_id and estado_pago = 0)'"/>
			<xsl:variable name="ordenDeuda" select="$msg/ordenDeuda"/>
			<xsl:variable name="filtroCuotas" select="$msg/filtroCuotas"/>
			<xsl:variable name="id_servicio" select="/request-context/request/message/body/service_id"/>

			<data>

  				<xsl:value-of select="$query_base"/>
  				&#39;<xsl:value-of select="$id_servicio"/>&#39;
  				<xsl:value-of select="$filtro_deuda_pagada"/>

  				  				
  				<xsl:for-each select="$filtros">
  					<!--agregamos la columna-->
		        	<xsl:choose>
		            	<xsl:when test="condicion/campo = 'monto_cuota'">
							and total_cuota
		            	</xsl:when>
		            	<xsl:when test="condicion/campo = 'fecha_vencimiento'">
							and fecha_vcto
		            	</xsl:when>
		            	<xsl:otherwise>
		            		<!--de momento no hacemos nada-->
		            	</xsl:otherwise>
		            </xsl:choose>
		            <!--agregamos la operacion-->
		            <xsl:choose>

			        	<xsl:when test="condicion/operador = 'menor'">
			        		&lt; 
			            </xsl:when>

			            <xsl:when test="condicion/operador = 'mayor'">
			              	&gt; 
			            </xsl:when>

			            <xsl:when test="condicion/operador = 'igual'">
			              	=
			            </xsl:when>
			            	
		            	<xsl:when test="condicion/operador = 'menorigual'">
							&lt;=
		            	</xsl:when>

		            	<xsl:when test="condicion/operador = 'mayorigual'">
							&gt;= 
		            	</xsl:when>

	
			            <xsl:otherwise>
		            		<!--de momento no hacemos nada-->
		            	</xsl:otherwise>
		            </xsl:choose>
		            <!--agregamos el valor-->
		            <!--debemos distinguir si es fecha o monto-->
		            <xsl:choose>
		            	<xsl:when test="condicion/campo = 'fecha_vencimiento'">
						to_date(&#39;<xsl:value-of select="condicion/valor"/>&#39;,'dd/mm/yy')   
				</xsl:when>
		            	<xsl:otherwise>
		            		<xsl:value-of select="condicion/valor"/>
		            	</xsl:otherwise>

		            </xsl:choose>
  				</xsl:for-each>


		        <xsl:choose>
		           	<!--Se ordenan las deudas desde la más antigua en adelante-->
			        <xsl:when test="$msg/ordenDeuda = 'asc'">
			        	order by fecha_vcto asc&#41;
			        </xsl:when>
			            
			        <!--Se ordenan las deudas desde la más vieja en adelante-->
			        <xsl:otherwise>
		            	order by fecha_vcto desc&#41;
		            </xsl:otherwise>
		        
		        </xsl:choose>
		        <!--consultamos si esta activado el filtro de número de cuotas-->
		        
		        <xsl:if test="$filtroCuotas = 1">
		            where rownum &lt;=  <xsl:value-of select="$msg/cantidadCuotas"/>
		        </xsl:if>	
		    
			</data>
	</xsl:template>


	<xsl:template name="data_rut">

		<!--Acá debemos poner todos los if-->

		<!--Esto se realiza para acortar la llamada a ciertos parametros-->
		<!--esto eventualmente puede cambiar, solo estamos emulando la salida del administrador de convenios nuevo-->

		<xsl:variable name="msg" select="/request-context/services-responses/default/convenio/msg/reglas_consulta"/>

		<xsl:variable name="filtros" select="$msg/campo_filtro/filtros/filtro"/>
		<xsl:variable name="query_rut" select="'select * from (select doc_id,nombre_cliente,id_cliente,id_servicio,folio,total_cuota,fecha_vcto from documento where cod_empresa_holding = $cod_empresa_holding and id_cliente='"/>
		<xsl:variable name="query_servicio" select="'select * from (select doc_id,nombre_cliente,id_cliente,id_servicio,folio,total_cuota,fecha_vcto from documento where cod_empresa_holding = $cod_empresa_holding and id_servicio='"/>
		<xsl:variable name="filtro_deuda_pagada" select="'and doc_id not in (select doc_id from pago where pago.doc_id = documento.doc_id and estado_pago = 0)'"/>
		<xsl:variable name="ordenDeuda" select="$msg/ordenDeuda"/>
		<xsl:variable name="filtroCuotas" select="$msg/filtroCuotas"/>
		<!--nos indica si la consulta es general o por cada servicio que este asociado al rut-->
		<xsl:variable name="contextoFiltro" select="$msg/contextoFiltro"/>

		<!--Debe apuntar al nodo que contiene los id_servicio del rut por el cual estamos consultando-->
		<xsl:variable name="creditos" select="/request-context/services-responses/consulta_deuda/consulta_creditos/response/data/Results/Row"/>

		<!--<xsl:variable name="creditos" select="creditos_arrojados por la query anterior"/>-->

		<xsl:variable name="client_id" select="/request-context/request/message/body/client_id"/>


			<data>

				<!--Significa que la consulta la hacemos considerando todos los filtros al todal de cuotas asociadas al rut, sin importar el credito al cual pertenecen-->

				<xsl:choose>
					<xsl:when test="$contextoFiltro = 'general'">

		  				<xsl:value-of select="$query_rut"/>
		  				<!--Acá debemos reemplazar el id_cliente-->
		  				&#39;<xsl:value-of select="$client_id"/>&#39;
		  				<xsl:value-of select="$filtro_deuda_pagada"/>

		  				  				
		  				<xsl:for-each select="$filtros">
		  					<!--agregamos la columna-->
				        	<xsl:choose>
				            	<xsl:when test="condicion/campo = 'monto_cuota'">
									and total_cuota
				            	</xsl:when>
				            	<xsl:when test="condicion/campo = 'fecha_vencimiento'">
									and fecha_vcto
				            	</xsl:when>
				            	<xsl:otherwise>
				            		<!--de momento no hacemos nada-->
				            	</xsl:otherwise>
				            </xsl:choose>
				            <!--agregamos la operacion-->
				            <xsl:choose>

					        	<xsl:when test="condicion/operador = 'menor'">
					        		&lt; 
					            </xsl:when>

					            <xsl:when test="condicion/operador = 'mayor'">
					              	&gt; 
					            </xsl:when>

					            <xsl:when test="condicion/operador = 'igual'">
					              	=
					            </xsl:when>
					            	
				            	<xsl:when test="condicion/operador = 'menorigual'">
									&lt;=
				            	</xsl:when>

				            	<xsl:when test="condicion/operador = 'mayorigual'">
									&gt;= 
				            	</xsl:when>

			
					            <xsl:otherwise>
				            		<!--de momento no hacemos nada-->
				            	</xsl:otherwise>
				            </xsl:choose>
				            <!--agregamos el valor-->
				            <!--debemos distinguir si es fecha o monto-->
				            <xsl:choose>
				            	<xsl:when test="condicion/campo = 'fecha_vencimiento'">
								to_date(&#39;<xsl:value-of select="condicion/valor"/>&#39;,'dd/mm/yy')
				            	</xsl:when>
				            	<xsl:otherwise>
				            		<xsl:value-of select="condicion/valor"/>
				            	</xsl:otherwise>

				            </xsl:choose>
		  				</xsl:for-each>


				        <xsl:choose>
				           	<!--Se ordenan las deudas desde la más antigua en adelante-->
					        <xsl:when test="$msg/ordenDeuda = 'asc'">
					        	order by fecha_vcto asc&#41;
					        </xsl:when>
					            
					        <!--Se ordenan las deudas desde la más vieja en adelante-->
					        <xsl:otherwise>
				            	order by fecha_vcto desc&#41;
				            </xsl:otherwise>
				        
				        </xsl:choose>
				        <!--consultamos si esta activado el filtro de número de cuotas-->
				        
				        <xsl:if test="$filtroCuotas = 1">
				            where rownum &lt;=  <xsl:value-of select="$msg/cantidadCuotas"/>
				        </xsl:if>

					</xsl:when>


					<!--Acá tenemos que hacer una query para cada uno de los id_servicio que se encuentran en la variable creditos-->
					<xsl:otherwise>
						<!--Acá anidamos cada query en un select y la concatenamos con un union all-->
						
						<xsl:for-each select="$creditos">

							select * from &#40;

							<xsl:value-of select="$query_servicio"/>
			  				&#39;<xsl:value-of select="ID_SERVICIO"/>&#39;
			  				<xsl:value-of select="$filtro_deuda_pagada"/>

	  				  				
		  					<xsl:for-each select="$filtros">
				  				<!--agregamos la columna-->
						        <xsl:choose>
						            <xsl:when test="condicion/campo = 'monto_cuota'">
										and total_cuota
						            </xsl:when>
						            <xsl:when test="condicion/campo = 'fecha_vencimiento'">
										and fecha_vcto
						            </xsl:when>
						            <xsl:otherwise>
						            	<!--de momento no hacemos nada-->
						            </xsl:otherwise>
						        </xsl:choose>
						        <!--agregamos la operacion-->
						        <xsl:choose>

							        <xsl:when test="condicion/operador = 'menor'">
							        	&lt; 
							        </xsl:when>

							        <xsl:when test="condicion/operador = 'mayor'">
							            &gt; 
							        </xsl:when>

							        <xsl:when test="condicion/operador = 'igual'">
							            =
							        </xsl:when>
							            	
						            <xsl:when test="condicion/operador = 'menorigual'">
										&lt;=
						            </xsl:when>

						            <xsl:when test="condicion/operador = 'mayorigual'">
										&gt;= 
						            </xsl:when>

					
							        <xsl:otherwise>
						            	<!--de momento no hacemos nada-->
						            </xsl:otherwise>
						        </xsl:choose>
						        <!--agregamos el valor-->
						        <!--debemos distinguir si es fecha o monto-->
						        <xsl:choose>
						            <xsl:when test="condicion/campo = 'fecha_vencimiento'">
									    to_date(&#39;<xsl:value-of select="condicion/valor"/>&#39;,'dd/mm/yy')
						            </xsl:when>
						            <xsl:otherwise>
						            	<xsl:value-of select="condicion/valor"/>
						            </xsl:otherwise>

						        </xsl:choose>	
						        
						    </xsl:for-each>
						    <!--cerramos el parentesis que encapsula la query por id_servicio-->

							<xsl:choose>
						           	<!--Se ordenan las deudas desde la más antigua en adelante-->
							        <xsl:when test="$msg/ordenDeuda = 'asc'">
							        	order by fecha_vcto asc&#41;
							        </xsl:when>
							            
							        <!--Se ordenan las deudas desde la más vieja en adelante-->
							        <xsl:otherwise>
						            	order by fecha_vcto desc&#41;
						            </xsl:otherwise>
						        
						    </xsl:choose>
						        <!--consultamos si esta activado el filtro de número de cuotas-->
						        
						    <xsl:if test="$filtroCuotas = 1">
						        where rownum &lt;=  <xsl:value-of select="$msg/cantidadCuotas"/>
						    </xsl:if>

						    &#41;

						    <!--agregamos un union all para concatenar las querys, menos la ultima-->
						    <xsl:if test="position() != last()">
	     					union all
	    					</xsl:if>

						</xsl:for-each>

					</xsl:otherwise>
				</xsl:choose>
    
		</data>
	</xsl:template>




	<xsl:template match="/">
		<!--Acá se obtiene la politica, y en base a eso elegimos la plantilla que vamos a usar-->

		<xsl:variable name="msg" select="/request-context/services-responses/default/convenio/msg/reglas_consulta"/>		
		<xsl:variable name="politica" select="$msg/politica"/>
		<transmission>
			<type>basedatos</type>			
			<properties>
				<datasource>bd_hub_trx</datasource>
			</properties>


			<xsl:choose>
				<!--politica rut-->
				<xsl:when test="$politica =1">
					<xsl:call-template name="data_rut"/>
				</xsl:when>			
				<!--politica id_servicio-->
				<xsl:when test="$politica =2">		
					<xsl:call-template name="data_idservicio"/>
				</xsl:when>
				<!--politica id_servicio + folio-->
				<xsl:when test="$politica =3">
					<xsl:call-template name="data_folio"/>					
				</xsl:when>

			</xsl:choose>


		</transmission>

	</xsl:template>

</xsl:stylesheet>

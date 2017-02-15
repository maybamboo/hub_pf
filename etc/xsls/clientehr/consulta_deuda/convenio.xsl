<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<agreements>
			<entity>agreement</entity>
			<action>all</action>
			<!--este es el cid de tanner configurado en el administrador de convenios antiguo-->
			<cid>999</cid>
			<!--De momento esto va a devolver un XML que tiene todas las politicas asociadas al convenio, y que sería igual a lo que devuelve el administrador de convenios que forma parte del portal de gestión-->
			<parameters>
				<code><xsl:value-of select="/request-context/request/message/body/contract_id" /></code>
			</parameters>
		</agreements>
	</xsl:template>
	</xsl:stylesheet>

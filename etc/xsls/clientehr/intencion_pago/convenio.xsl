<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<agreements>
			<entity>agreement</entity>
			<action>all</action>
			<cid>209</cid>
			<parameters>
				<code><xsl:value-of select="/request-context/request/message/body/detalle/parameters/parameter[name/text()='cod_convenio']/value" /></code>
			</parameters>
		</agreements>
	</xsl:template>
	</xsl:stylesheet>

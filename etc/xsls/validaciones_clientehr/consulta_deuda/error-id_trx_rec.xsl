<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<message>
			<header>
				<status_code>ERRV</status_code>
				<description>Error de validacion</description>
			</header>
			<body>
				<validation_code>26</validation_code>				
				<description>Id_trx_rec ya utilizado.</description>
			</body>
		</message>
	</xsl:template>
</xsl:stylesheet>
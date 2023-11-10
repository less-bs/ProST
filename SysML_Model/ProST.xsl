<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:uml="http://www.eclipse.org/uml2/5.0.0/UML"
                xmlns:sysml="http://www.eclipse.org/papyrus/1.6.0/SysML"
                xmlns:xmi="http://www.omg.org/spec/XMI/20131001"
                exclude-result-prefixes="uml sysml xmi">

    <xsl:output method="html" indent="yes"/>

    <!-- Template for the XMI root element -->
    <xsl:template match="/xmi:XMI">
        <html>
            <head>
                <title>SysML Model</title>
            </head>
            <body>
                <h1>SysML Model Elements</h1>
                <!-- Apply templates to all contained elements -->
                <xsl:apply-templates select="//uml:Model"/>
            </body>
        </html>
    </xsl:template>

    <!-- Template for UML Model -->
    <xsl:template match="uml:Model">
        <h2>Model: <xsl:value-of select="@name"/></h2>
		
        <!-- Apply templates to all first children of the model element -->
		<ul>
        <xsl:apply-templates select="nestedClassifier|packagedElement"/>
		</ul>
    </xsl:template>

    <!-- Template for building a element including it sub elements -->
    <xsl:template match="nestedClassifier|packagedElement">
		<xsl:variable name="id" select="@xmi:id" />
		<li>
			Element: <xsl:value-of select="@name"/><br/>
			UML ID: <xsl:value-of select="@xmi:id"/><br/>
			UML Type: <xsl:value-of select="@xmi:type"/><br/>
			<xsl:for-each select="//*[@base_NamedElement=$id]">
				SysML ID: <xsl:value-of select="@xmi:id"/><br/>
				SysML Text: <xsl:value-of select="@text"/><br/>
				SysML Type: <xsl:value-of select ="name(.)"/>
			</xsl:for-each>
			<xsl:if test="*">
				<ul>
				<xsl:apply-templates select="nestedClassifier|packagedElement"/>
				</ul>
			</xsl:if>
		</li>
    </xsl:template>
</xsl:stylesheet>
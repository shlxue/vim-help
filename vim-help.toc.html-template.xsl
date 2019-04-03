<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="utf-8" indent="yes"/>

    <xsl:template match="/root">
        <html>
            <head>
                <title>vim-help</title>
            </head>
            <body>
                <xsl:for-each select="chapter">
                    <xsl:call-template name="gen-chapter"/>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>


    <xsl:template name="gen-chapter" match="chapter">
        <h3>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="section[1]/@src"/>
                </xsl:attribute>
                <xsl:value-of select="@title"/>
            </a>
        </h3>
        <div>
            <ul>
                <xsl:for-each select="section">
                    <xsl:call-template name="gen-section"/>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>

    <xsl:template name="gen-section" match="section">
        <li>
            <a>
                <!--<xsl:attribute name="title">-->
                    <!--<xsl:value-of select="@title"/>-->
                <!--</xsl:attribute>-->
                <xsl:attribute name="href">
                    <xsl:value-of select="@href"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </a>
        </li>
    </xsl:template>

</xsl:stylesheet>

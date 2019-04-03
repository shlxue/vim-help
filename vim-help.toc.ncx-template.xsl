<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes"
                doctype-public="-//NISO//DTD ncx 2005-1//EN"
                doctype-system="http://www.daisy.org/z3986/2005/ncx-2005-1.dtd"/>

    <xsl:template match="/root">
        <ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1" xml:lang="en-US">
            <head>
                <meta name="dtd:uid" content="vim-help"/>
                <meta name="dtd:depth" content="2"/>
                <meta name="dtd:totalPageCount" content="0"/>
                <meta name="dtd:maxPageNumber" content="0"/>
            </head>
            <docTitle>
                <text>vim help</text>
            </docTitle>
            <docAuthor>
                <text>shl.xue</text>
            </docAuthor>

            <navMap>
                <navPoint>
                    <navLabel>
                        <text>Cover</text>
                    </navLabel>
                    <content src="welcome.html"/>
                </navPoint>
                <xsl:for-each select="chapter">
                    <xsl:call-template name="gen-nav-chapter"/>
                </xsl:for-each>
            </navMap>
        </ncx>
    </xsl:template>

    <xsl:template name="gen-nav-chapter" match="chapter">
        <navPoint xmlns="http://www.daisy.org/z3986/2005/ncx/">
            <navLabel>
                <text>
                    <xsl:value-of select="concat(position(), '. ', @title)"/>
                </text>
            </navLabel>
            <content>
                <xsl:attribute name="src">
                    <xsl:value-of select="section[1]/@src"/>
                </xsl:attribute>
            </content>
            <xsl:for-each select="section">
                <xsl:call-template name="gen-nav-section"/>
            </xsl:for-each>
        </navPoint>
    </xsl:template>

    <xsl:template name="gen-nav-section" match="section">
        <navPoint xmlns="http://www.daisy.org/z3986/2005/ncx/">
            <navLabel>
                <text>
                    <xsl:value-of select="concat(@title, '. ', text())"/>
                </text>
            </navLabel>
            <content>
                <xsl:attribute name="src">
                    <xsl:value-of select="@href"/>
                </xsl:attribute>
            </content>
        </navPoint>
    </xsl:template>

</xsl:stylesheet>


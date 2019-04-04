<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes"/>

    <xsl:template match="/root">
        <package xmlns="http://www.idpf.org/2007/opf" version="2.0" unique-identifier="">
            <metadata xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:opf="http://www.idpf.org/2007/opf">
                <meta name="fixed-layout" content="false"/>
                <meta name="original-resolution" content="1024x768"/>
                <meta name="zero-margin" content="true"/>
                <meta name="cover" content="cover"/>

                <dc:title>vim-help</dc:title>
                <dc:language>en-us</dc:language>
                <dc:identifier id="vim-help" opf:scheme="ISBN">0000</dc:identifier>
                <dc:creator>shl.xue</dc:creator>
                <dc:publisher>shl.xue</dc:publisher>
                <dc:subject>Help document</dc:subject>
                <dc:date>2019-04-01</dc:date>
                <dc:description>VIM help for kindle</dc:description>
            </metadata>

            <manifest>
                <xsl:for-each select="chapter">
                    <xsl:for-each select="section[not(@src=preceding-sibling::section/@src)]">
                        <xsl:call-template name="gen-item" />
                    </xsl:for-each>
                </xsl:for-each>

                <item id="stylesheet" href="vim-stylesheet.css" media-type="text/css"/>

                <item id="ncx" media-type="application/x-dtbncx+xml" href="vim-help.ncx"/>
                <item id="vim-header" media-type="images/gif" href="images/vim_header.gif"/>
                <item id="cover" media-type="images/gif" href="images/cover.gif"/>
                <item id="welcome" media-type="application/xhtml+xml" href="welcome.html"/>
            </manifest>

            <spine toc="ncx">
                <itemref idref="welcome"/>
                <xsl:for-each select="chapter">
                    <xsl:for-each select="section[not(@src=preceding-sibling::section/@src)]">
                        <xsl:call-template name="gen-spine" />
                    </xsl:for-each>
                </xsl:for-each>
            </spine>
        </package>
    </xsl:template>


    <xsl:template name="gen-item" match="section">
        <item media-type="application/xhtml+xml" xmlns="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id">
                <xsl:value-of select="@title"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:value-of select="@src"/>
            </xsl:attribute>
        </item>
    </xsl:template>

    <xsl:template name="gen-spine" match="section">
        <itemref xmlns="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref">
                <xsl:value-of select="@title"/>
            </xsl:attribute>
        </itemref>
    </xsl:template>


</xsl:stylesheet>

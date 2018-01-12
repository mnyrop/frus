<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:dc="http://www.dublincore.org/documents/dcmi-namespace/"
    xmlns:frus="http://history.state.gov/frus/ns/1.0" xmlns:functx="http://www.functx.com"
    xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:variable name="volume-dates-min" select="//dc:coverage/@notBefore"/>
    <xsl:variable name="volume-dates-max" select="//dc:coverage/@notAfter"/>
    
    <!-- Add volumes dates as @frus:doc-dateTime-min and @frus:doc-dateTime-max to //front//div[@type="section"] -->

    <xsl:template match="tei:front//tei:div[@type = 'section']">
        <xsl:choose>
            <xsl:when test=".[empty(@frus:doc-dateTime-min)]">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:attribute name="frus:doc-dateTime-min">
                        <xsl:value-of select="$volume-dates-min"/>
                    </xsl:attribute>
                    <xsl:attribute name="frus:doc-dateTime-max">
                        <xsl:value-of select="$volume-dates-max"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="node()"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="node()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Add volumes dates as @frus:doc-dateTime-min and @frus:doc-dateTime-max to //back//div[@type="section"] -->

    <xsl:template match="tei:back//tei:div[@type = 'section']">
        <xsl:choose>
            <xsl:when test=".[empty(@frus:doc-dateTime-min)]">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:attribute name="frus:doc-dateTime-min">
                        <xsl:value-of select="$volume-dates-min"/>
                    </xsl:attribute>
                    <xsl:attribute name="frus:doc-dateTime-max">
                        <xsl:value-of select="$volume-dates-max"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="node()"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="node()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>

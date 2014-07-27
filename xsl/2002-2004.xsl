<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<xsl:for-each select="PATDOC/SDOBI">
<xsl:variable name="docNumber">
    <xsl:call-template name="url-encode">
        <xsl:with-param name="str" select="B100/B110/DNUM/PDAT"/>
    </xsl:call-template>
</xsl:variable>
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>&gt;     &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt;    &lt;http://us.patents.aksw.org/schema/Patent&gt;  .
</xsl:text>
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/docNo&gt;  "</xsl:text><xsl:value-of select="B100/B110/DNUM/PDAT"/><xsl:text>"@en    .
</xsl:text>
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/country&gt;  &lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="B100/B190/PDAT"/><xsl:text>&gt;  .
</xsl:text>
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="B100/B190/PDAT"/><xsl:text>&gt;    &lt;http://www.w3.org/2000/01/rdf-schema#label&gt;  "</xsl:text><xsl:value-of select="B100/B190/PDAT"/><xsl:text>"@en  .
</xsl:text>
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/kind&gt;  "</xsl:text><xsl:value-of select="B100/B130/PDAT"/><xsl:text>"@en  .
</xsl:text>
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>&gt;    &lt;http://purl/org/dc/terms/date&gt;  "</xsl:text><xsl:value-of select="substring(B100/B140/DATE/PDAT,0,5)"/>-<xsl:value-of select="substring(B100/B140/DATE/PDAT,5,2)"/>-<xsl:value-of select="substring(B100/B140/DATE/PDAT,7,9)"/><xsl:text>"^^xsd:date  .
</xsl:text>
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>&gt;    &lt;http://us.patents.aksw.org/inventionTitle&gt;  "</xsl:text><xsl:value-of select="B500/B540/STEXT/PDAT"/><xsl:text>"@en  .
</xsl:text>
<xsl:for-each select="B500/B560/B561/PCIT"><xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/citedBy&gt;    &lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="DOC/DNUM/PDAT"/><xsl:text>&gt;  .
</xsl:text>
</xsl:for-each>
<xsl:text>
</xsl:text>
<xsl:for-each select="B500/B560/B561/PCIT">
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="DOC/DNUM/PDAT"/><xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/number&gt;  "</xsl:text><xsl:value-of select="DOC/DNUM/PDAT"/><xsl:text>"@en  .
</xsl:text>
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="DOC/DNUM/PDAT"/><xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/kind&gt;  "</xsl:text><xsl:value-of select="DOC/KIND/PDAT"/><xsl:text>"@en  .
</xsl:text>
<xsl:if test="substring(DOC/DATE/PDAT,7,9) != '00'"><xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="DOC/DNUM/PDAT"/><xsl:text>&gt;    &lt;http://purl/org/dc/terms/date&gt;  "</xsl:text><xsl:value-of select="substring(DOC/DATE/PDAT,0,5)"/>-<xsl:value-of select="substring(DOC/DATE/PDAT,5,2)"/>-<xsl:value-of select="substring(DOC/DATE/PDAT,7,9)"/><xsl:text>"^^xsd:date  .
</xsl:text>
</xsl:if><xsl:if test="substring(DOC/DATE/PDAT,7,9) = '00'"><xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="DOC/DNUM/PDAT"/><xsl:text>&gt;    &lt;http://purl/org/dc/terms/date&gt;  "</xsl:text><xsl:value-of select="substring(DOC/DATE/PDAT,0,5)"/>-<xsl:value-of select="substring(DOC/DATE/PDAT,5,2)"/><xsl:text>-01"^^xsd:date  .
</xsl:text>
<xsl:text>
</xsl:text>
</xsl:if>
</xsl:for-each>
</xsl:for-each> 
</xsl:template>

    <!-- Characters we'll support. We could add control chars 0-31 and 127-159, but we won't. -->
    <xsl:variable name="ascii"> !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~</xsl:variable>
    <xsl:variable name="latin1">&#160;&#161;&#162;&#163;&#164;&#165;&#166;&#167;&#168;&#169;&#170;&#171;&#172;&#173;&#174;&#175;&#176;&#177;&#178;&#179;&#180;&#181;&#182;&#183;&#184;&#185;&#186;&#187;&#188;&#189;&#190;&#191;&#192;&#193;&#194;&#195;&#196;&#197;&#198;&#199;&#200;&#201;&#202;&#203;&#204;&#205;&#206;&#207;&#208;&#209;&#210;&#211;&#212;&#213;&#214;&#215;&#216;&#217;&#218;&#219;&#220;&#221;&#222;&#223;&#224;&#225;&#226;&#227;&#228;&#229;&#230;&#231;&#232;&#233;&#234;&#235;&#236;&#237;&#238;&#239;&#240;&#241;&#242;&#243;&#244;&#245;&#246;&#247;&#248;&#249;&#250;&#251;&#252;&#253;&#254;&#255;</xsl:variable>

    <!-- Characters that usually don't need to be escaped -->
    <xsl:variable name="safe">!()*-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz~</xsl:variable>
    <xsl:variable name="hex" >0123456789ABCDEF</xsl:variable>

    <!--  url-encode function -->
    <xsl:template name="url-encode">
        <xsl:param name="str"/>
        <xsl:if test="$str">
            <xsl:variable name="first-char" select="substring($str,1,1)"/>
            <xsl:choose>
                <xsl:when test="contains($safe,$first-char)">
                    <xsl:value-of select="$first-char"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="codepoint">
                        <xsl:choose>
                            <xsl:when test="contains($ascii,$first-char)">
                                <xsl:value-of select="string-length(substring-before($ascii,$first-char)) + 32"/>
                            </xsl:when>
                            <xsl:when test="contains($latin1,$first-char)">
                                <xsl:value-of select="string-length(substring-before($latin1,$first-char)) + 160"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- <xsl:message terminate="no">Warning: string contains a character that is out of range! Substituting "?".</xsl:message> -->
                                <xsl:text>63</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="hex-digit1" select="substring($hex,floor($codepoint div 16) + 1,1)"/>
                    <xsl:variable name="hex-digit2" select="substring($hex,$codepoint mod 16 + 1,1)"/>
                    <xsl:value-of select="concat('%',$hex-digit1,$hex-digit2)"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="string-length($str) &gt; 1">
                <xsl:call-template name="url-encode">
                    <xsl:with-param name="str" select="substring($str,2)"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>


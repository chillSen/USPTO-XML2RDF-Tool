<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
@prefix xsd:	&lt;http://www.w3.org/2001/XMLSchema#&gt;  .
<xsl:for-each select="PATDOC/SDOBI">
&lt;http://us.patents.aksw.org/patent/<xsl:value-of select="B100/B110/DNUM/PDAT"/>&gt;    &lt;http://us.patents.aksw.org/schema/hasDocNo&gt;  "<xsl:value-of select="B100/B110/DNUM/PDAT"/>"@en    .
&lt;http://us.patents.aksw.org/patent/<xsl:value-of select="B100/B110/DNUM/PDAT"/>&gt;    &lt;http://us.patents.aksw.org/schema/hasCountry&gt;  &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="B100/B110/DNUM/PDAT"/>/<xsl:value-of select="B100/B190/PDAT"/>&gt;  .
&lt;http://us.patents.aksw.org/patent/<xsl:value-of select="B100/B110/DNUM/PDAT"/>/<xsl:value-of select="B100/B190/PDAT"/>&gt;    &lt;http://www.w3.org/2000/01/rdf-schema#label&gt;  "<xsl:value-of select="B100/B190/PDAT"/>"@en  .
&lt;http://us.patents.aksw.org/patent/<xsl:value-of select="B100/B110/DNUM/PDAT"/>&gt;    &lt;http://us.patents.aksw.org/schema/kind&gt;  "<xsl:value-of select="B100/B130/PDAT"/>"@en  .
&lt;http://us.patents.aksw.org/patent/<xsl:value-of select="B100/B110/DNUM/PDAT"/>&gt;    &lt;http://purl/org/dc/terms/date&gt;  "<xsl:value-of select="substring(B100/B140/DATE/PDAT,0,5)"/>-<xsl:value-of select="substring(B100/B140/DATE/PDAT,5,2)"/>-<xsl:value-of select="substring(B100/B140/DATE/PDAT,7,9)"/>"^^xsd:date  .
&lt;http://us.patents.aksw.org/patent/<xsl:value-of select="B100/B110/DNUM/PDAT"/>&gt;    &lt;http://us.patents.aksw.org/hasInventionTitle&gt;  "<xsl:value-of select="B500/B540/STEXT/PDAT"/>"@en  .
<xsl:for-each select="B500/B560/B561/PCIT">&lt;http://us.patents.aksw.org/patent/<xsl:value-of select="../../../../B100/B110/DNUM/PDAT"/>&gt;    &lt;http://us.patents.aksw.org/schema/citedBy&gt;    &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="DOC/DNUM/PDAT"/>&gt;  .   
</xsl:for-each>
<xsl:for-each select="B500/B560/B561/PCIT">
&lt;http://us.patents.aksw.org/patent/<xsl:value-of select="DOC/DNUM/PDAT"/>&gt;    &lt;http://us.patents.aksw.org/schema/hasNumber&gt;  "<xsl:value-of select="DOC/DNUM/PDAT"/>"@en  . 
&lt;http://us.patents.aksw.org/patent/<xsl:value-of select="DOC/DNUM/PDAT"/>&gt;    &lt;http://us.patents.aksw.org/schema/kind&gt;  "<xsl:value-of select="DOC/KIND/PDAT"/>"@en  . 
<xsl:if test="substring(DOC/DATE/PDAT,7,9) != '00'">&lt;http://us.patents.aksw.org/patent/<xsl:value-of select="DOC/DNUM/PDAT"/>&gt;    &lt;http://purl/org/dc/terms/date&gt;  "<xsl:value-of select="substring(DOC/DATE/PDAT,0,5)"/>-<xsl:value-of select="substring(DOC/DATE/PDAT,5,2)"/>-<xsl:value-of select="substring(DOC/DATE/PDAT,7,9)"/>"^^xsd:date  .
</xsl:if><xsl:if test="substring(DOC/DATE/PDAT,7,9) = '00'">&lt;http://us.patents.aksw.org/patent/<xsl:value-of select="DOC/DNUM/PDAT"/>&gt;    &lt;http://purl/org/dc/terms/date&gt;  "<xsl:value-of select="substring(DOC/DATE/PDAT,0,5)"/>-<xsl:value-of select="substring(DOC/DATE/PDAT,5,2)"/>-01"^^xsd:date  .
</xsl:if>
</xsl:for-each>
</xsl:for-each> 
</xsl:template>
</xsl:stylesheet>

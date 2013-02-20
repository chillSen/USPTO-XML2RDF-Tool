<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
	@prefix xsd:	&lt;http://www.w3.org/2001/XMLSchema#&gt; .
		<xsl:for-each select="us-patent-grant/us-bibliographic-data-grant">
        &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="publication-reference/document-id/doc-number"/>&gt;    &lt;http://us.patents.aksw.org/schema/hasDocNo&gt;"<xsl:value-of select="publication-reference/document-id/doc-number"/>"^^xsd:string.
        &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="publication-reference/document-id/doc-number"/>&gt;    &lt;http://us.patents.aksw.org/schema/hasCountry&gt;"<xsl:value-of select="publication-reference/document-id/country"/>"^^xsd:string.
        &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="publication-reference/document-id/doc-number"/>&gt;    &lt;http://us.patents.aksw.org/schema/kind&gt;"<xsl:value-of select="publication-reference/document-id/kind"/>"^^xsd:string.
        &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="publication-reference/document-id/doc-number"/>&gt;    &lt;http://www.w3.org/TR/owl-time/&gt;"<xsl:value-of select="substring(publication-reference/document-id/date,0,5)"/>-<xsl:value-of select="substring(publication-reference/document-id/date,7,9)"/>-<xsl:value-of select="substring(publication-reference/document-id/date,5,2)"/>"^^xsd:date.
        &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="publication-reference/document-id/doc-number"/>&gt;    &lt;http://us.patents.aksw.org/hasInventionTitle&gt;"<xsl:value-of select="invention-title"/>"^^xsd:string.


			<xsl:for-each select="references-cited/citation">
			  &lt;http://us.patents.aksw.org/patent/D0651376<xsl:value-of select="/././publication-reference/document-id/doc-number"/>&gt;     &lt;http://us.patents.aksw.org/schema/citedBy&gt;    &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="patcit/document-id/doc-number"/>&gt;.   
			</xsl:for-each>

		<xsl:for-each select="references-cited/citation">
			  &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="patcit/document-id/doc-number"/>&gt;    &lt;http://us.patents.aksw.org/schema/hasCountry&gt;"<xsl:value-of select="patcit/document-id/country"/>"^^xsd:string. 
 			  &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="patcit/document-id/doc-number"/>&gt;    &lt;http://us.patents.aksw.org/schema/hasNumber&gt;"<xsl:value-of select="patcit/document-id/doc-number"/>"^^xsd:string. 
			  &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="patcit/document-id/doc-number"/>&gt;    &lt;http://us.patents.aksw.org/schema/kind&gt;"<xsl:value-of select="patcit/document-id/kind"/>"^^xsd:string. 
			  &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="patcit/document-id/doc-number"/>&gt;    &lt;http://us.patents.aksw.org/schema/hasName&gt;"<xsl:value-of select="patcit/document-id/name"/>"@en.
				<xsl:if test="substring(patcit/document-id/date,7,9) != '00'">
					&lt;http://us.patents.aksw.org/patent/<xsl:value-of select="patcit/document-id/doc-number"/>&gt;    &lt;http://www.w3.org/TR/owl-time/&gt;"<xsl:value-of select="substring(patcit/document-id/date,0,5)"/>-<xsl:value-of select="substring(patcit/document-id/date,5,2)"/>-<xsl:value-of select="substring(patcit/document-id/date,7,9)"/>"^^xsd:date.
				</xsl:if>
				<xsl:if test="substring(patcit/document-id/date,7,9) = '00'">
					&lt;http://us.patents.aksw.org/patent/<xsl:value-of select="patcit/document-id/doc-number"/>&gt;    &lt;http://www.w3.org/TR/owl-time/&gt;"<xsl:value-of select="substring(patcit/document-id/date,0,5)"/>-<xsl:value-of select="substring(patcit/document-id/date,5,2)"/>"^^xsd:date.
				</xsl:if>
			  &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="patcit/document-id/doc-number"/>&gt;    &lt;http://us.patents.aksw.org/schema/hasCategory&gt;"<xsl:value-of select="category"/>"^^xsd:string.
		</xsl:for-each>
		 &lt;http://us.patents.aksw.org/patent/<xsl:value-of select="publication-reference/document-id/doc-number"/>-<xsl:value-of select="parties/applicants/applicant/addressbook/last-name"/>&gt;     &lt;http://us.patents.aksw.org/schema/hasapplicant&gt; &lt;http://us.patents.aksw.org/applicant/<xsl:value-of select="publication-reference/document-id/doc-number"/>-<xsl:value-of select="parties/applicants/applicant/addressbook/last-name"/>&gt;.                   
		 &lt;http://us.patents.aksw.org/applicant/<xsl:value-of select="publication-reference/document-id/doc-number"/>-<xsl:value-of select="parties/applicants/applicant/addressbook/last-name"/>&gt;   &lt;http://xmlns.com/foaf/0.1/lastname&gt;"<xsl:value-of select="parties/applicants/applicant/addressbook/last-name"/>"@en.
		 &lt;http://us.patents.aksw.org/applicant/<xsl:value-of select="publication-reference/document-id/doc-number"/>-<xsl:value-of select="parties/applicants/applicant/addressbook/last-name"/>&gt;   &lt;http://xmlns.com/foaf/0.1/firstname&gt;"<xsl:value-of select="parties/applicants/applicant/addressbook/first-name"/>"@en.
		 &lt;http://us.patents.aksw.org/applicant/<xsl:value-of select="publication-reference/document-id/doc-number"/>-<xsl:value-of select="parties/applicants/applicant/addressbook/last-name"/>&gt;   &lt;http://us.patents.aksw.org/schema/hasNationality&gt;"<xsl:value-of select="parties/applicants/applicant/nationality/country"/>"^^xsd:string.
		 &lt;http://us.patents.aksw.org/applicant/<xsl:value-of select="publication-reference/document-id/doc-number"/>-<xsl:value-of select="parties/applicants/applicant/addressbook/last-name"/>&gt;   &lt;http://us.patents.aksw.org/schema/hasResidence&gt;"<xsl:value-of select="parties/applicants/applicant/residence/country"/>"^^xsd:string.
		 &lt;http://us.patents.aksw.org/applicant/<xsl:value-of select="publication-reference/document-id/doc-number"/>-<xsl:value-of select="parties/applicants/applicant/addressbook/last-name"/>&gt;   &lt;http://us.patents.aksw.org/schema/city&gt;"<xsl:value-of select="parties/applicants/applicant/addressbook/address/city"/>"^^xsd:string.
		 &lt;http://us.patents.aksw.org/applicant/<xsl:value-of select="publication-reference/document-id/doc-number"/>-<xsl:value-of select="parties/applicants/applicant/addressbook/last-name"/>&gt;   &lt;http://us.patents.aksw.org/schema/state&gt;"<xsl:value-of select="parties/applicants/applicant/addressbook/address/state"/>"^^xsd:string.
		 &lt;http://us.patents.aksw.org/applicant/<xsl:value-of select="publication-reference/document-id/doc-number"/>-<xsl:value-of select="parties/applicants/applicant/addressbook/last-name"/>&gt;   &lt;http://us.patents.aksw.org/schema/country&gt;"<xsl:value-of select="parties/applicants/applicant/addressbook/address/country"/>"^^xsd:string.

		

	</xsl:for-each> 

</xsl:template>


</xsl:stylesheet>

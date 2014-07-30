<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Characters we'll support. We could add control chars 0-31 and 127-159, but we won't. -->
<xsl:variable name="ascii"> !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~</xsl:variable>
<xsl:variable name="latin1">&#160;&#161;&#162;&#163;&#164;&#165;&#166;&#167;&#168;&#169;&#170;&#171;&#172;&#173;&#174;&#175;&#176;&#177;&#178;&#179;&#180;&#181;&#182;&#183;&#184;&#185;&#186;&#187;&#188;&#189;&#190;&#191;&#192;&#193;&#194;&#195;&#196;&#197;&#198;&#199;&#200;&#201;&#202;&#203;&#204;&#205;&#206;&#207;&#208;&#209;&#210;&#211;&#212;&#213;&#214;&#215;&#216;&#217;&#218;&#219;&#220;&#221;&#222;&#223;&#224;&#225;&#226;&#227;&#228;&#229;&#230;&#231;&#232;&#233;&#234;&#235;&#236;&#237;&#238;&#239;&#240;&#241;&#242;&#243;&#244;&#245;&#246;&#247;&#248;&#249;&#250;&#251;&#252;&#253;&#254;&#255;</xsl:variable>

<!-- Characters that usually don't need to be escaped -->
<xsl:variable name="safe">!()*-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz~</xsl:variable>
<xsl:variable name="hex" >0123456789ABCDEF</xsl:variable>
   
<xsl:template match="/">
<xsl:for-each select="us-patent-grant/us-bibliographic-data-grant">
<!-- docNumber variable -->
<xsl:variable name="docNumber">
  <xsl:call-template name="url-encode">
      <xsl:with-param name="str" select="publication-reference/document-id/doc-number"/>
  </xsl:call-template>
</xsl:variable>

<xsl:text disable-output-escaping="yes">&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:value-of select="$docNumber"/>
<xsl:text>&gt;    &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#type&gt;    &lt;http://us.patents.aksw.org/patent/Patent&gt;.
</xsl:text>

<!-- <http://us.patents.aksw.org/patent/D0673346>    <http://us.patents.aksw.org/schema/hasDocNo>  "D0673346"@en    . -->
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:value-of select="$docNumber"/>
<xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/docNo&gt;  "</xsl:text>
<xsl:value-of select="$docNumber"/><xsl:text>"@en    .
</xsl:text>

<!-- <http://us.patents.aksw.org/patent/D0673346>    <http://us.patents.aksw.org/schema/kind>  "S1"@en  .-->
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:value-of select="$docNumber"/>
<xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/kind&gt;  "</xsl:text>
<xsl:value-of select="publication-reference/document-id/kind"/>
<xsl:text>"@en  .
</xsl:text>

<!-- <http://us.patents.aksw.org/patent/D0673346>    <http://purl/org/dc/terms/date>  "2013-01-01"^^xsd:date  . -->	
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:value-of select="$docNumber"/>
<xsl:text>&gt;    &lt;http://purl/org/dc/terms/date&gt;  "</xsl:text>
<xsl:value-of select="substring(publication-reference/document-id/date,0,5)"/>
<xsl:text>-</xsl:text>
<xsl:value-of select="substring(publication-reference/document-id/date,5,2)"/>
<xsl:text>-</xsl:text>
<xsl:value-of select="substring(publication-reference/document-id/date,7,9)"/>
<xsl:text>"^^xsd:date  .
</xsl:text>

<!-- <http://us.patents.aksw.org/patent/D0673346>    <http://us.patents.aksw.org/hasInventionTitle>  "Belt end strap"@en  . -->
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:value-of select="$docNumber"/>
<xsl:text>&gt;    &lt;http://us.patents.aksw.org/inventionTitle&gt;  "</xsl:text>
<xsl:value-of select="invention-title"/>
<xsl:text>"@en  .
</xsl:text>

<!-- <http://us.patents.aksw.org/patent/D0673346>    <http://us.patents.aksw.org/schema/hasCountry>  <http://us.patents.aksw.org/patent/D0673346/US>  . -->
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:value-of select="$docNumber"/>
<xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/country&gt;  &lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:call-template name="url-encode">
    <xsl:with-param name="str" select="publication-reference/document-id/country"/>
</xsl:call-template>
<xsl:text>&gt;  .
</xsl:text>

<!-- <http://us.patents.aksw.org/patent/D0673346/US>    <http://www.w3.org/2000/01/rdf-schema#label>  "US"@en  . -->
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:call-template name="url-encode">
   <xsl:with-param name="str" select="publication-reference/document-id/country"/>
</xsl:call-template>
<xsl:text>&gt;    &lt;http://www.w3.org/2000/01/rdf-schema#label&gt;  "</xsl:text>
<xsl:value-of select="publication-reference/document-id/country"/>
<xsl:text>"@en  .
</xsl:text>

<!-- <http://us.patents.aksw.org/patent/D0696836>    <http://us.patents.aksw.org/schema/citedBy>    <http://us.patents.aksw.org/patent/D0696836>  . -->
<xsl:for-each select="us-references-cited/us-citation/patcit">
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:value-of select="$docNumber"/>
<xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/citedBy&gt;    &lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:call-template name="url-encode">
    <xsl:with-param name="str" select="document-id/doc-number"/>
</xsl:call-template>
<xsl:text>&gt;  .
</xsl:text>
</xsl:for-each>

<xsl:text>
</xsl:text>
<!-- -->
<xsl:for-each select="us-parties/us-applicants/us-applicant">
<!-- ApplicantLastNameApplicantLastName variable -->
<xsl:variable name="applicantLastName">
<xsl:call-template name="url-encode">
	<xsl:with-param name="str" select="addressbook/last-name"/>
</xsl:call-template>
</xsl:variable>

<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:value-of select="$docNumber"/>
<xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/applicant&gt;     &lt;http://us.patents.aksw.org/applicant/</xsl:text>
<xsl:value-of select="$docNumber"/>
<xsl:text>-</xsl:text>
<xsl:value-of select="$applicantLastName"/>
<xsl:text>&gt;  .
</xsl:text>
</xsl:for-each>
 
<xsl:text>
</xsl:text>
<xsl:for-each select="us-references-cited/us-citation/patcit">
<xsl:variable name="citedDocNumber">
<xsl:call-template name="url-encode">
	<xsl:with-param name="str" select="document-id/doc-number"/>
</xsl:call-template>
</xsl:variable>
<!-- <http://us.patents.aksw.org/patent/D0696836>   <http://us.patents.aksw.org/schema/hasCountry>  <http://us.patents.aksw.org/patent/>D0696836/US>  . -->
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:value-of select="$citedDocNumber"/>
<xsl:text>&gt;   &lt;http://us.patents.aksw.org/schema/country&gt;  &lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:call-template name="url-encode">
	<xsl:with-param name="str" select="document-id/country"/>
</xsl:call-template>
<xsl:text>&gt;  .
</xsl:text>

<!-- <http://us.patents.aksw.org/patent/D0696836/US>    <http://www.w3.org/2000/01/rdf-schema#label>  "US"@en  . -->
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:call-template name="url-encode">
	<xsl:with-param name="str" select="document-id/country"/>
</xsl:call-template>
<xsl:text>&gt;    &lt;http://www.w3.org/2000/01/rdf-schema#label&gt;  "</xsl:text>
<xsl:call-template name="url-encode">
	<xsl:with-param name="str" select="document-id/country"/>
</xsl:call-template>
<xsl:text>"@en  .
</xsl:text>


<!-- <http://us.patents.aksw.org/patent/D0696836>    <http://us.patents.aksw.org/schema/kind>  "S"@en  . -->
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:value-of select="$citedDocNumber"/>
<xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/kind&gt;  "</xsl:text>
<xsl:value-of select="document-id/kind"/>
<xsl:text>"@en  .
</xsl:text> 


<!-- <http://us.patents.aksw.org/patent/D0696836>    <http://purl/org/dc/terms/date>  "2000-07-01"^^xsd:date  . -->
<!-- handle different date formats -->
<xsl:if test="substring(document-id/date,7,9) != '00'">
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:value-of select="$citedDocNumber"/>
<xsl:text>&gt;    &lt;http://purl/org/dc/terms/date&gt;  "</xsl:text>
<xsl:value-of select="substring(document-id/date,0,5)"/>
<xsl:text>-</xsl:text>
<xsl:value-of select="substring(document-id/date,5,2)"/>
<xsl:text>-</xsl:text>
<xsl:value-of select="substring(document-id/date,7,9)"/>
<xsl:text>"^^xsd:date  .
</xsl:text>
</xsl:if>
<xsl:if test="substring(document-id/date,7,9) = '00'">
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:value-of select="$citedDocNumber"/>
<xsl:text>&gt;    &lt;http://purl/org/dc/terms/date&gt;  "</xsl:text>
<xsl:value-of select="substring(document-id/date,0,5)"/>
<xsl:text>-</xsl:text>
<xsl:value-of select="substring(document-id/date,5,2)"/>
<xsl:text>-01"^^xsd:date  .
</xsl:text>
</xsl:if>

<!-- <http://us.patents.aksw.org/patent/D0696836>    <http://us.patents.aksw.org/schema/hasCategory>  "cited by examiner"@en  . -->
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text>
<xsl:value-of select="$citedDocNumber"/>
<xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/category&gt;  "</xsl:text>
<xsl:value-of select="../category"/>"@en  .
<xsl:text>
</xsl:text>
</xsl:for-each>

<xsl:text>
</xsl:text>
<!-- Iterate applicants -->
<xsl:for-each select="us-parties/us-applicants/us-applicant">
<!-- ApplicantLastName variable -->
<xsl:variable name="applicantLastName">
<xsl:call-template name="url-encode">
	<xsl:with-param name="str" select="addressbook/last-name"/>
</xsl:call-template>
</xsl:variable>
<!-- Country variable -->
<xsl:variable name ="country">
<xsl:call-template name="url-encode">
	<xsl:with-param name="str" select="addressbook/address/country"/>
</xsl:call-template>
</xsl:variable>


<xsl:text>&lt;http://us.patents.aksw.org/applicant/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>-</xsl:text><xsl:value-of select="$applicantLastName"/><xsl:text>&gt;    &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#type&gt;    &lt;http://xmlns.com/foaf/0.1/Agent&gt;  .
</xsl:text>
<!-- <http://us.patents.aksw.org/applicant/D0696836-Chen>   <http://xmlns.com/foaf/0.1/lastname>  "Chen"@en  . -->
<xsl:text>&lt;http://us.patents.aksw.org/applicant/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>-</xsl:text><xsl:value-of select="$applicantLastName"/><xsl:text>&gt;   &lt;http://xmlns.com/foaf/0.1/lastName&gt;  "</xsl:text><xsl:value-of select="$applicantLastName"/><xsl:text>"@en  .
</xsl:text>
<!-- <http://us.patents.aksw.org/applicant/D0696836-Chen>   <http://xmlns.com/foaf/0.1/firstname>  "Zuxi"@en  . -->
<xsl:text>&lt;http://us.patents.aksw.org/applicant/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>-</xsl:text><xsl:value-of select="$applicantLastName"/><xsl:text>&gt;   &lt;http://xmlns.com/foaf/0.1/firstName&gt;  "</xsl:text><xsl:value-of select="addressbook/first-name"/><xsl:text>"@en  .
</xsl:text>
<!-- <http://us.patents.aksw.org/applicant/D0696836-Chen>   <http://us.patents.aksw.org/schema/hasNationality>  ""@en  . -->
<xsl:text>&lt;http://us.patents.aksw.org/applicant/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>-</xsl:text><xsl:value-of select="$applicantLastName"/><xsl:text>&gt;   &lt;http://us.patents.aksw.org/schema/nationality&gt;  "</xsl:text><xsl:value-of select="nationality/country"/><xsl:text>"@en  .
</xsl:text>
<!-- <http://us.patents.aksw.org/applicant/D0696836-Chen>   <http://us.patents.aksw.org/schema/hasResidence>  "CN"@en  . -->
<xsl:text>&lt;http://us.patents.aksw.org/applicant/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>-</xsl:text><xsl:value-of select="$applicantLastName"/><xsl:text>&gt;   &lt;http://us.patents.aksw.org/schema/residence&gt;     &lt;http://us.patents.aksw.org/</xsl:text><xsl:call-template name="url-encode">	<xsl:with-param name="str" select="residence/country"/></xsl:call-template><xsl:text>&gt; .
</xsl:text>
<!-- <http://us.patents.aksw.org/applicant/D0696836-Chen>   <http://us.patents.aksw.org/schema/city>  "Wenzhou"@en  . -->
<xsl:text>&lt;http://us.patents.aksw.org/applicant/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>-</xsl:text><xsl:value-of select="$applicantLastName"/><xsl:text>&gt;   &lt;http://us.patents.aksw.org/schema/city&gt;  "</xsl:text><xsl:value-of select="addressbook/address/city"/><xsl:text>"@en  .
</xsl:text>
<!-- <http://us.patents.aksw.org/applicant/D0696836-Chen>   <http://us.patents.aksw.org/schema/state>  ""@en  . -->
<xsl:text>&lt;http://us.patents.aksw.org/applicant/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>-</xsl:text><xsl:value-of select="$applicantLastName"/><xsl:text>&gt;   &lt;http://us.patents.aksw.org/schema/state&gt;  "</xsl:text><xsl:value-of select="addressbook/address/state"/><xsl:text>"@en  .
</xsl:text>
<!-- <http://us.patents.aksw.org/applicant/D0696836-Chen>   <http://us.patents.aksw.org/schema/hasCountry>  <http://us.patents.aksw.org/applicant/D0696836-Chen/CN>  . -->
<xsl:text>&lt;http://us.patents.aksw.org/applicant/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>-</xsl:text><xsl:value-of select="$applicantLastName"/><xsl:text>&gt;   &lt;http://us.patents.aksw.org/schema/country&gt;  &lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="$country"/><xsl:text>&gt;  .
</xsl:text>
<!-- <http://us.patents.aksw.org/applicant/D0696836-Chen/CN>    <http://www.w3.org/2000/01/rdf-schema#label>  "CN"@en  . -->
<xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="$country"/><xsl:text>&gt;    &lt;http://www.w3.org/2000/01/rdf-schema#label&gt;  "</xsl:text><xsl:value-of select="$country"/><xsl:text>"@en  .
</xsl:text>
<xsl:text>
</xsl:text>
</xsl:for-each>

    <!-- iterate assignees -->
    <xsl:for-each select="assignees/assignee">
        <xsl:variable name="assigneeeUri">
            <xsl:if test="addressbook/last-name">
            <xsl:call-template name="url-encode">
                <xsl:with-param name="str" select="addressbook/last-name"/>
            </xsl:call-template>
            </xsl:if>
            <xsl:if test="addressbook/orgname">
                <xsl:call-template name="url-encode">
                    <xsl:with-param name="str" select="addressbook/orgname"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:variable>
    <xsl:text>&lt;http://us.patents.aksw.org/patent/</xsl:text><xsl:value-of select="$docNumber"/><xsl:text>&gt;    &lt;http://us.patents.aksw.org/schema/assignee&gt;    &lt;http://us.patents.aksw.org/assignee/</xsl:text><xsl:value-of select="$assigneeeUri"/><xsl:text>&gt;  .
</xsl:text>
<xsl:text>&lt;http://us.patents.aksw.org/assignee/</xsl:text><xsl:value-of select="$assigneeeUri"/><xsl:text>&gt;    &lt;http://xmlns.com/foaf/0.1/name&gt;    "</xsl:text><xsl:if test="addressbook/last-name"><xsl:value-of select="addressbook/last-name"/></xsl:if><xsl:if test="addressbook/orgname"><xsl:value-of select="addressbook/orgname"/></xsl:if><xsl:text>"@en  .
</xsl:text>
<xsl:text>&lt;http://us.patents.aksw.org/assignee/</xsl:text><xsl:value-of select="$assigneeeUri"/><xsl:text>&gt;    &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#type&gt;    &lt;http://xmlns.com/foaf/0.1/</xsl:text><xsl:if test="addressbook/last-name"><xsl:text>Agent</xsl:text></xsl:if><xsl:if test="addressbook/orgname"><xsl:text>Organization</xsl:text></xsl:if><xsl:text>&gt;  .
</xsl:text>
</xsl:for-each>
</xsl:for-each>
<xsl:text>
</xsl:text>


</xsl:template>


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

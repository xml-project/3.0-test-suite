<?xml version="1.0" encoding="UTF-8"?>
<t:test expected="pass"
        features="xslt-2"
        xmlns:t="http://xproc.org/ns/testsuite/3.0">
   <t:info>
      <t:title>AB-xslt-136</t:title>
      <t:revision-history>
         <t:revision>
            <t:date>2023-01-04</t:date>
            <t:author>
               <t:name>Achim Berndzen</t:name>
            </t:author>
            <t:description xmlns="http://www.w3.org/1999/xhtml">
               <p>Initial commit</p>
            </t:description>
         </t:revision>
      </t:revision-history>
   </t:info>
   <t:description xmlns="http://www.w3.org/1999/xhtml">
      <p>Testing for node identity in p:xslt (2.0).</p>
   </t:description>
   <t:pipeline>
      <p:declare-step version="3.0"
                      xmlns:p="http://www.w3.org/ns/xproc">
         <p:output port="result"/>
         <p:identity name="producer">
            <p:with-input><doc /></p:with-input>
         </p:identity>
         <p:xslt version="2.0">
            <p:with-option name="global-context-item" select="." />
            <p:with-input port="stylesheet">
               <xsl:stylesheet version="2.0"
                               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                  <xsl:variable name="gci" select="." />
                  <xsl:template match="/">
                     <result>
                        <xsl:value-of select=". is $gci"/>
                     </result>
                  </xsl:template>
               </xsl:stylesheet>
            </p:with-input>
         </p:xslt>
      </p:declare-step>
   </t:pipeline>
   <t:schematron>
      <s:schema queryBinding="xslt2"
                xmlns:s="http://purl.oclc.org/dsdl/schematron"
                xmlns="http://www.w3.org/1999/xhtml">
         <s:pattern>
            <s:rule context="/">
               <s:assert test="/result">The document root is not 'result'.</s:assert>
               <s:assert test="/result/text()='true'">Test for required node identity fails.</s:assert>
            </s:rule>
         </s:pattern>
      </s:schema>
   </t:schematron>
</t:test>
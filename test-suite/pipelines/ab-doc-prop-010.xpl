<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
                name="main"
                version="3.0">
  <p:output port="result"/>
  
  <p:variable static="true" name="var" select="/doc/@att">
    <p:document href="../documents/ab-doc2.xml" />
  </p:variable>
  
  <p:input port="source">
    <p:inline document-properties="map { 'a': $var }">
      <doc/>
    </p:inline>
  </p:input>
  
  <p:identity>
    <p:with-input port="source" select="p:document-properties-document(.)/p:document-properties/a"/>
  </p:identity>

</p:declare-step>

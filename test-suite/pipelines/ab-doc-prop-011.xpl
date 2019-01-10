<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                name="main"
                version="3.0">
  <p:output port="result"/>
  
  <p:identity name="producer">
    <p:with-input>
      <doc a='1' />
    </p:with-input>
  </p:identity>
  
  <p:identity name="id">
    <p:with-input port="source">
      <p:document document-properties="map { 'a': /doc/@a }" href="../documents/ab-doc.xml"/>
      
    </p:with-input>
  </p:identity>
  
  <p:identity>
    <p:with-input port="source" select="p:document-properties-document(.)/c:document-properties/a"/>
  </p:identity>
  
</p:declare-step>

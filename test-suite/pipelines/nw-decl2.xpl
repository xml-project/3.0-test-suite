<p:library version="3.0" 
           xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:x="http://example.com/steps">
    
  <p:declare-step type="x:step2">
    <p:output port="result" />
    <p:identity>
      <p:with-input><step2/></p:with-input>        
    </p:identity>
  </p:declare-step>

</p:library>

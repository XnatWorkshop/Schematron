<?xml version="1.0" encoding="iso-8859-1"?>
<iso:schema    xmlns="http://purl.oclc.org/dsdl/schematron" 
	       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
	       xmlns:nrgxsl="http://nrg.wustl.edu/validate" 
	       queryBinding='xslt2'
	       schemaVersion="ISO19757-3">
<iso:ns uri="http://nrg.wustl.edu/xnat" prefix="xnat"/>
  <iso:title>Protocol Validator</iso:title>
<!-- It is expected that each rule file would have the following Patterns available viz. Start, ListScanIds -->
  <iso:pattern id="Start">
	   <iso:title>Validation report</iso:title>
	    <iso:rule context="/">
	     	<iso:assert test="xnat:MRSession">The root element must be an MRSession</iso:assert>
	    </iso:rule>
	    <iso:rule context="xnat:MRSession">
		<iso:report id="expt_id" test="true()"><iso:value-of select="@ID"/></iso:report>
		<iso:report id="expt_project" test="true()"><iso:value-of select="@project"/></iso:report>
		<iso:report id="expt_label" test="true()"><iso:value-of select="@label"/></iso:report>
	    </iso:rule>
 </iso:pattern>
 <iso:pattern id="Acquisition">
	    <iso:rule context="xnat:scans">
		<iso:assert test="count(xnat:scan[@type='AX FSPGR FS T1']) >= 1 and count(xnat:scan[@type='AX FRFSE-XL T2']) >= 1"> 
		<nrgxsl:acquisition>
		<nrgxsl:cause-id>MR Count</nrgxsl:cause-id>
		  MR Session must have at least 1 AX FSPGR FS T1 scan and at least 1 AX FRFSE-XL T2 scans. Found <iso:value-of select="count(xnat:scan[@type='AX FSPGR FS T1'])"/> AX FSPGR FS T1 scans and <iso:value-of select="count(xnat:scan[@type='AX FRFSE-XL T2'])"/> AX FRFSE-XL T2 scans. 
		</nrgxsl:acquisition> 
		</iso:assert>
            </iso:rule>
 </iso:pattern>
<iso:pattern id="ListScanIds">
	    <iso:rule context="//xnat:scan">
		<iso:report test="@ID">
		  <nrgxsl:scans>
		    <iso:value-of select="@ID"/>
		  </nrgxsl:scans> 	
		</iso:report>
            </iso:rule>
 </iso:pattern>
  <iso:pattern id="Scan">
		<iso:rule context="/xnat:MRSession/xnat:scans/xnat:scan[@type='AX FSPGR FS T1']">
			<iso:assert test="xnat:frames &gt;= 30 and xnat:frames &lt;= 40" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Frames</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>frames</nrgxsl:xmlpath>
			      <iso:value-of select="concat( 'Expected: Between 30 and 40  Found: ', ./xnat:frames)"/>
			   </nrgxsl:scan>
			</iso:assert>
                        <iso:assert test="xnat:fieldStrength = 3.0" >
                           <nrgxsl:scan>
                              <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
                              <nrgxsl:cause-id>FieldStrength</nrgxsl:cause-id>
                              <nrgxsl:xmlpath>fieldStrength</nrgxsl:xmlpath>
                              <iso:value-of select="concat( 'Expected: Field Strength 3.0  Found: ', ./xnat:fieldStrength)"/>
                           </nrgxsl:scan>
                        </iso:assert>
			<iso:assert test="xnat:parameters/xnat:tr &gt; 300 and xnat:parameters/xnat:tr &lt; 500" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TR</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.tr</nrgxsl:xmlpath>
			   <iso:value-of select="concat('Expected: Between 300 and 500  Found: ', ./xnat:parameters/xnat:tr)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:te &gt; 5.000 and xnat:parameters/xnat:te &lt; 7.500" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TE</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.te</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: Between 5.000 and 7.500  Found: ', ./xnat:parameters/xnat:te)"/>
			   </nrgxsl:scan>
			</iso:assert>
		</iso:rule>
 </iso:pattern>

</iso:schema>

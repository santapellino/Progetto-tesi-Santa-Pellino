<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" extension-element-prefixes="ixsl" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    >
    
    
    <xsl:template match="/">
        
        <xsl:result-document href="#title" method="ixsl:replace-content">
           Bellini Digital Correspondence

        </xsl:result-document>
        
    
        
        <xsl:result-document href="#text" method="ixsl:replace-content">
            
            <xsl:value-of select="//tei:biblStruct//tei:author"/>
            
        </xsl:result-document>
        
    
        
    </xsl:template>
    
  
 

</xsl:transform>
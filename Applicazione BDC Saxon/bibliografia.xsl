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

            <h2>Bibliografia</h2>

            
            <xsl:for-each select="//tei:biblStruct">
                <ul>
                    <li>
                        <xsl:copy-of select=".//tei:author//text()|.//tei:editor//text()"/>. (
                        <xsl:copy-of select=".//tei:date//text()"/>).
                        <xsl:copy-of select=".//tei:title//text()"/>.
                        <xsl:copy-of select=".//tei:publisher//text()"/>.
                    </li>
                </ul>
            </xsl:for-each>
        </xsl:result-document>
        
    
        
    </xsl:template>
    
  
 

</xsl:transform>
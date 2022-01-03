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
            
            <h2> <xsl:value-of select="//tei:idno[@type='inventory']"/> - <xsl:value-of select="//tei:titleStmt//tei:title"/>  </h2>
            
            <xsl:for-each select="//tei:body//tei:pb">
                
                <xsl:choose>
                    
                    <xsl:when test="@n='1'">
                        <div id="pagina1" class="pagina">
                        <div id="image1" class="text-left">
                            <xsl:variable name="link" select="concat('images/LL1-1_000',@n, '.jpg' )"/>
                            <xsl:element name="img">
                                <xsl:attribute name="src">
                                        <xsl:value-of select="$link"/>
                                    </xsl:attribute>
                            </xsl:element>
                        </div>
                            
                        <div id="text1" class="text-right" >
                            <b>Pagina 1</b>
                            <br/>
                            <xsl:copy-of select="//tei:body/tei:div[@xml:id='info_dest']"/>
                            <br />
                            <xsl:copy-of select="//tei:body/tei:div/tei:ab[@n='ab_02']" /> 
                        </div>
                        </div>
                    </xsl:when>
                        
                    <xsl:when test="@n='2'">
                        <div id="pagina2" class="pagina">
                        <div id="image2" class="text-left">
                            <xsl:variable name="link" select="concat('images/LL1-1_000',@n, '.jpg' )"/>
                            <xsl:element name="img">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="$link"/>
                                </xsl:attribute>
                            </xsl:element>
                        </div>
                        <div id="text2" class="text-right" >
                            <b>Pagina 2</b>
                            <br/> 
                            <xsl:copy-of select="//tei:body/tei:div/tei:ab[@n='ab_03']"/> 
                        </div>
                        </div>
                    </xsl:when>
                    
                    <xsl:when test="@n='3'">
                        <div id="pagina3" class="pagina">
                        <div id="image3" class="text-left">
                            <xsl:variable name="link" select="concat('images/LL1-1_000',@n, '.jpg' )"/>
                            <xsl:element name="img">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="$link"/>
                                </xsl:attribute>
                            </xsl:element>
                        </div>
                        <div id="text3" class="text-right" >
                            <b>Pagina 3</b>
                            <br/>  
                            <xsl:copy-of select="//tei:body/tei:div/tei:ab[@n='ab_04']"/> 
                            <xsl:copy-of select="//tei:body/tei:div/tei:salute[@n='ab_03']"/>
                            <br/> 
                            <xsl:copy-of select="//tei:signed[@hand='#h1']"/> 
                        </div>
                        </div>
                    </xsl:when>
                    
                    <xsl:when test="@n='4'">
                        <div id="pagina4" class="pagina">
                        <div id="image4" class="text-left">
                            <xsl:variable name="link" select="concat('images/LL1-1_000',@n, '.jpg' )"/>
                            <xsl:element name="img">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="$link"/>
                                </xsl:attribute>
                            </xsl:element>
                        </div>
                        <div id="text4" class="text-right" >
                            <b>Pagina 4</b>
                            <br/>
                            La pagina non presenta testo autografo di Bellini.
                        </div>
                        </div>
                    </xsl:when>
                       
                </xsl:choose>
                
            
            </xsl:for-each>
            
            
            <xsl:result-document href="#infosupporto" method="ixsl:replace-content">
                
                <h2>Informazioni sul supporto </h2>

                <br/><br/>
                <b>Materiale: </b><xsl:value-of select="//tei:material"/>
                <br/>
                <b>Filigrana: </b><xsl:value-of select="//tei:watermark"/>
                <br/>
                <b>Timbri: </b><xsl:value-of select="//tei:stamp"/>
                <br/>
                <b>Misura: </b><xsl:value-of select="//tei:measure"/>
                <br/>
                <b>Dimensione: </b><xsl:value-of select="//tei:dimensions/tei:height"/>x<xsl:value-of select="//tei:dimensions/tei:width"/> mm
                <br/>
                <b>Piegature: </b><xsl:value-of select="//tei:foliation"/>
                <br/>
                <b>Condizioni: </b><xsl:value-of select="//tei:condition"/>
                
            </xsl:result-document>
            
        </xsl:result-document>

    </xsl:template>

</xsl:transform>
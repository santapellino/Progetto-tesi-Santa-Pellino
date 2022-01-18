<?xml version="1.0" encoding="UTF-8" ?> 
<xsl:stylesheet version="2.0"
    xmlns:mei="https://music-encoding.org/schema/4.0.1/mei-all.rng"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="tei">
    
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template> 
 
    <xsl:template match="tei:teiHeader">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:facsimile">
        <xsl:variable name="idno" select="//tei:idno[@type='inventory']"/>
        <xsl:variable name="id" select="concat ($idno, '_facsimile')"/>
        <xsl:element  name="facsimile" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="xml:id">
                <xsl:copy-of select="$id"/>
            </xsl:attribute>   
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:surface">
        <xsl:variable name="idno" select="//tei:idno[@type='inventory']"/>
        <xsl:variable name="n" select="@n"/>
        <xsl:variable name="newN" select="concat ($idno, '.', $n)"/>
        <xsl:variable name="id" select="@xml:id"/>
        <xsl:variable name="pb" select="//tei:body//tei:pb"/>
        <xsl:element  name="surface" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n">
                <xsl:copy-of select=" $newN"/>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
               <xsl:copy-of select="$id"/>
           </xsl:attribute> 
            <xsl:attribute name="corresp">
               <xsl:for-each select="$pb">
                   <xsl:if test="@n=$n">
                       <xsl:variable name="facs" select="@xml:id"/>
                       <xsl:variable name="newfacs" select="concat('#', $facs)"/>   
                        <xsl:value-of select="$newfacs"/>
                   </xsl:if>
               </xsl:for-each>
           </xsl:attribute> 
            <xsl:apply-templates select="tei:graphic"/> 
            <xsl:variable name="width" select="tei:graphic/@width"/>
            <xsl:variable name="widthnew" select="substring-before($width, 'px')"/>
            <xsl:variable name="coeff" select="number(723)"/>
            <xsl:variable name="rapp" select="number($widthnew) div $coeff"/>          
            <xsl:for-each select="tei:zone ">
                <xsl:variable name="id" select="@xml:id"/>
                <xsl:variable name="corresp" select="concat ('#', $id, 'h')"/>
                <xsl:variable name="rendition" select="@rendition"/>
                <xsl:variable name="ulx" select="@ulx"/>
                <xsl:variable name="uly" select="@uly"/>
                <xsl:variable name="lrx" select="@lrx"/>
                <xsl:variable name="lry" select="@lry"/>
                <xsl:element  name="zone" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="ulx">      
                        <xsl:variable name="result" select="$ulx div $rapp"/>
                        <xsl:value-of select="format-number($result, '#.00')"/>
                    </xsl:attribute>
                    <xsl:attribute name="uly">
                        <xsl:variable name="result" select="$uly div $rapp"/>
                        <xsl:value-of select="format-number($result, '#.00')"/>
                    </xsl:attribute>                            
                    <xsl:attribute name="lrx">
                        <xsl:variable name="result" select="$lrx div $rapp"/>
                        <xsl:value-of select="format-number($result, '#.00')"/>
                    </xsl:attribute>                            
                    <xsl:attribute name="lry">
                        <xsl:variable name="result" select="$lry div $rapp"/>
                        <xsl:value-of select="format-number($result, '#.00')"/>
                    </xsl:attribute>                           
                    <xsl:attribute name="rendition">
                        <xsl:value-of select="$rendition"/>
                    </xsl:attribute>                            
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="$id"/>
                    </xsl:attribute>                
                    <xsl:if test="$rendition='HotSpot'">
                        <xsl:attribute name="corresp"> 
                            <xsl:value-of select="$corresp"/>
                        </xsl:attribute>                                
                        <xsl:attribute name="start"> 
                            <xsl:value-of select="$corresp"/>
                        </xsl:attribute>
                    </xsl:if>                
                </xsl:element>
            </xsl:for-each>
            <xsl:if test="exists(tei:zone/tei:zone)">                
                <xsl:for-each select="tei:zone/tei:zone">
                    <xsl:variable name="id" select="@xml:id"/>
                    <xsl:variable name="corresp" select="concat ('#', $id, 'h')"/>
                    <xsl:variable name="rendition" select="@rendition"/>
                    <xsl:variable name="ulx" select="@ulx"/>
                    <xsl:variable name="uly" select="@uly"/>
                    <xsl:variable name="lrx" select="@lrx"/>
                    <xsl:variable name="lry" select="@lry"/>
                    <xsl:element  name="zone" namespace="http://www.tei-c.org/ns/1.0">                        
                        <xsl:attribute name="ulx">      
                            <xsl:variable name="result" select="$ulx div $rapp"/>
                            <xsl:value-of select="format-number($result, '#.00')"/>
                        </xsl:attribute>
                        <xsl:attribute name="uly">
                            <xsl:variable name="result" select="$uly div $rapp"/>
                            <xsl:value-of select="format-number($result, '#.00')"/>
                        </xsl:attribute>                        
                        <xsl:attribute name="lrx">
                            <xsl:variable name="result" select="$lrx div $rapp"/>
                            <xsl:value-of select="format-number($result, '#.00')"/>
                        </xsl:attribute>                        
                        <xsl:attribute name="lry">
                            <xsl:variable name="result" select="$lry div $rapp"/>
                            <xsl:value-of select="format-number($result, '#.00')"/>
                        </xsl:attribute>                        
                        <xsl:attribute name="rendition">
                            <xsl:value-of select="$rendition"/>
                        </xsl:attribute>                        
                        <xsl:attribute name="xml:id">
                            <xsl:value-of select="$id"/>
                        </xsl:attribute>
                        <xsl:if test="$rendition='HotSpot'">
                            <xsl:attribute name="corresp"> 
                                <xsl:value-of select="$corresp"/>
                            </xsl:attribute>
                            <xsl:attribute name="start"> 
                                <xsl:value-of select="$corresp"/>
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:element>
                </xsl:for-each>
            </xsl:if>
        </xsl:element>
    </xsl:template> 

    <xsl:template match="tei:graphic">
        <xsl:variable name="url" select="@url"/>
        <xsl:variable name="urlN" select="substring-before($url, '.jpg')"/>
        <xsl:variable name="urlN2" select="translate($urlN, '.', '-')"/>
        <xsl:variable name="idno" select="//tei:idno[@type='inventory']" />
        <xsl:variable name="newUrl" select="concat('data/test-img/', $idno, '/',$urlN2,'.dzi')"/>
        <xsl:variable name="width" select="@width"/>
        <xsl:variable name="height" select="@height"/>        
        <xsl:element name="graphic" namespace="http://www.tei-c.org/ns/1.0">            
            <xsl:variable name="num" select="substring-after(//tei:idno[@type='inventory'], 'LL1.')"/>
            <xsl:variable name="numnew" select="substring-before($num, '.')"/>
            <xsl:attribute name="url">
                <xsl:value-of select="$newUrl"/>
            </xsl:attribute>       
            <xsl:attribute name="width">
                <xsl:value-of select="$width"/>
            </xsl:attribute>            
            <xsl:attribute name="height">
                <xsl:value-of select="$height"/>
            </xsl:attribute>
        </xsl:element>        
        <xsl:apply-templates />     
    </xsl:template>

    <xsl:template match="tei:msDesc"> 
        <xsl:copy> 
            <xsl:apply-templates select="tei:msIdentifier"/>
            <xsl:element name="msContents" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="msItem" namespace="http://www.tei-c.org/ns/1.0"> 
                    <xsl:attribute name="xml:id">
                        <xsl:text>msItem-</xsl:text>
                        <xsl:value-of select="//tei:idno[@type='inventory']"/>
                    </xsl:attribute>
                        <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type" >inventory</xsl:attribute> 
                            <xsl:value-of select="//tei:idno[@type='inventory']"/>
                        </xsl:element>
                        <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="//tei:titleStmt/tei:title"/>
                        </xsl:element>
                        <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:text>Bibliografia </xsl:text>
                            </xsl:element>
                            <xsl:text>Seminara, 2017, </xsl:text>
                            <xsl:element name="citedRange" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="source">#Seminara2017</xsl:attribute> 
                                <xsl:attribute name="resp">#GS</xsl:attribute> 
                                <xsl:attribute name="ana">
                                    <xsl:value-of select="//tei:sourceDesc//tei:bibl/@ana"/>
                                </xsl:attribute> 
                                <xsl:element name="locus" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="from">
                                        <xsl:value-of select="//tei:sourceDesc//tei:bibl/tei:citedRange/@from"/>
                                    </xsl:attribute> 
                                    <xsl:attribute name="to" >
                                        <xsl:value-of select="//tei:sourceDesc//tei:bibl/tei:citedRange/@to"/>
                                    </xsl:attribute>
                                    <xsl:text>n.</xsl:text>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="//tei:sourceDesc//tei:bibl/@ana"/>
                                    <xsl:text>,</xsl:text> 
                                    <xsl:text> </xsl:text> 
                                    <xsl:text>p.</xsl:text>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="//tei:sourceDesc//tei:bibl/tei:citedRange"/>
                                    <xsl:text>.</xsl:text> 
                                </xsl:element> 
                            </xsl:element> 
                        </xsl:element> 
                        <xsl:variable name="biblio" select="//tei:back//tei:div[@type='bibliography']//tei:listBibl//tei:bibl//tei:ref//tei:bibl" /> 
                        <xsl:variable name="bibl2" select="//tei:bibl//tei:ref//tei:bibl" /> 
                        <xsl:variable name="author" select="//tei:bibl//tei:ref//tei:bibl//tei:author" /> 
                        <xsl:variable name="date" select="//tei:bibl//tei:ref//tei:bibl//tei:date" /> 
                        <xsl:variable name="pag" select="//tei:bibl//tei:ref//tei:bibl//tei:citedRange" />                         
                        <xsl:if test="exists($author[1])">
                            <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$author[1]"/>
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="$date[1]"/>
                                <xsl:text>, p. </xsl:text>
                                <xsl:value-of select="$pag[1]"/>
                                <xsl:text>. </xsl:text>
                            </xsl:element>
                        </xsl:if>                        
                        <xsl:if test="exists($author[2])">
                            <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$author[2]"/>
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="$date[2]"/>
                                <xsl:text>, p. </xsl:text>
                                <xsl:value-of select="$pag[2]"/>
                                <xsl:text>. </xsl:text>
                            </xsl:element>
                        </xsl:if>                        
                        <xsl:if test="exists($author[3])">
                            <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$author[3]"/>
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="$date[3]"/>
                                <xsl:text>, p. </xsl:text>
                                <xsl:value-of select="$pag[3]"/>
                                <xsl:text>. </xsl:text>
                            </xsl:element>
                        </xsl:if>                    
                        <xsl:if test="exists($author[4])">
                            <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$author[4]"/>
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="$date[4]"/>
                                <xsl:text>, p. </xsl:text>
                                <xsl:value-of select="$pag[4]"/>
                                <xsl:text>. </xsl:text>
                            </xsl:element>
                        </xsl:if>
                        <xsl:element name="incipit" namespace="http://www.tei-c.org/ns/1.0" >
                            <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">   
                                <xsl:text>Incipit </xsl:text>
                            </xsl:element>
                            <xsl:variable name="s1" select="//tei:s[@n='s_01']"/>
                            <xsl:variable name="salute" select="//tei:div[@type='letter-body']//tei:salute"/>
                            <xsl:choose>
                                <xsl:when test="exists($s1)">
                                    <xsl:apply-templates select="$s1" mode="sciogliabbr"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when test="exists($salute)"> 
                                            <xsl:apply-templates select="$salute"  mode="sciogliabbr"/> <!--per riportare invece tutta la porzione di codice -->
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>Incipit non presente</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>                            
                        </xsl:element>
                        <xsl:element name="explicit" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">   
                                <xsl:text>Explicit </xsl:text>
                            </xsl:element>                              
                            <xsl:variable name="closer" select="//tei:div[@type='closer']"/>                            
                            <xsl:choose>
                                <xsl:when test="exists($closer)">
                                    <xsl:apply-templates select="$closer" mode="sciogliabbr" /><!-- per riportare invece tutta la porzione di codice mode pop up è er riportare anche i collegamenti alle entità  -->
                                </xsl:when>                                
                                <xsl:otherwise>
                                    <xsl:text>Esplicit non presente</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>                            
                        </xsl:element>
                </xsl:element>               
            </xsl:element>            
        </xsl:copy>        
    </xsl:template>
 
    <xsl:template match="tei:front">
        <xsl:element name="front" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">Title</xsl:attribute> 
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0"> 
                        Titolo della lettera
                    </xsl:element>
                    <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0"> 
                        <xsl:copy-of select="//tei:titleStmt//tei:title/node()"/>
                    </xsl:element>
            </xsl:element> 
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">Bibliography</xsl:attribute> 
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                        Bibliografia 
                    </xsl:element>
                    <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0"> 
                        <xsl:text>
                            Seminara 2017, n. 
                        </xsl:text>
                        <xsl:value-of select="//tei:sourceDesc//tei:bibl/@ana"/>
                        <xsl:text> </xsl:text> 
                        <xsl:text> p. </xsl:text>
                      <xsl:value-of select="//tei:sourceDesc//tei:bibl/tei:citedRange"/>
                    </xsl:element>
            </xsl:element>
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">language</xsl:attribute>
                <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                    Lingua  
                </xsl:element>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0"> 
                    <xsl:copy-of select="//tei:msItem/tei:textLang/node()"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">Collocation</xsl:attribute>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                        Collocazione 
                    </xsl:element>
                    <xsl:value-of select="//tei:msIdentifier/tei:settlement"/>
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="//tei:msIdentifier/tei:country"/>
                    <xsl:text>)</xsl:text>
                    <xsl:text> - </xsl:text>
                    <xsl:value-of select="//tei:msIdentifier/tei:repository/node()"/>
                </xsl:element>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:value-of select="//tei:msIdentifier//tei:idno[@type='collocation']"/>
                </xsl:element>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:text>Idno </xsl:text>
                    </xsl:element>
                    <xsl:value-of select="//tei:msIdentifier/tei:idno[@type='inventory']"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">desc</xsl:attribute>
                <xsl:element name="head" namespace="http://www.tei-c.org/ns/1.0">
                    Descrizione del supporto 
                </xsl:element>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">   
                        <xsl:text>
                            Carta
                        </xsl:text>
                    </xsl:element>
                    <xsl:value-of select="//tei:material" /> 
                </xsl:element>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">  
                        <xsl:text>
                            Numero di carte 
                        </xsl:text>
                    </xsl:element>
                    <xsl:value-of select="//tei:extent/tei:measure"/>
                </xsl:element>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">  
                        <xsl:text>Dimensioni </xsl:text>
                    </xsl:element>
                    <xsl:value-of select="//tei:height"/><xsl:text>x</xsl:text><xsl:value-of select="//tei:width"/>
                    <xsl:element name="unit" namespace="http://www.tei-c.org/ns/1.0">  
                        mm
                    </xsl:element>
                </xsl:element>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">  
                        <xsl:text>
                            Watermark
                        </xsl:text>
                    </xsl:element>
                    <xsl:variable name="watermark" select="//tei:watermark"/>
                    <xsl:if test="exists($watermark)">
                        <xsl:value-of select="$watermark" /> 
                    </xsl:if>
                    <xsl:if test="empty($watermark)">
                        Non presente
                    </xsl:if>
                </xsl:element>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">  
                        <xsl:text>
                            Timbri
                        </xsl:text>
                    </xsl:element>
                    <xsl:value-of select="//tei:support/tei:stamp" />  
                </xsl:element>                
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:value-of select="//tei:support/tei:p" />  
                </xsl:element>                
            </xsl:element>
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0"> 
                <xsl:attribute name="type">piegatura</xsl:attribute>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                    Descrizione della piegatura
                </xsl:element>
                <xsl:value-of select="//tei:collation"/>
                </xsl:element>
            </xsl:element>           
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">condFisica</xsl:attribute>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                    Condizioni fisiche 
                </xsl:element>
                <xsl:value-of select="//tei:condition"/>
                </xsl:element>
            </xsl:element>            
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">handnote</xsl:attribute>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                    Descrizione delle mani 
                </xsl:element>
                <xsl:value-of select="//tei:handNote"/>
                </xsl:element>
            </xsl:element>            
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">sigilli</xsl:attribute>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                    Descrizione dei sigilli
                </xsl:element>                    
                    <xsl:variable name="sigilli" select="normalize-space(//tei:sealDesc)"/>                    
                    <xsl:if test="exists($sigilli)">
                        <xsl:value-of select="$sigilli" /> 
                    </xsl:if>
                    <xsl:if test="empty($sigilli)">
                        Non presenti
                    </xsl:if>  
                </xsl:element>
            </xsl:element>           
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">infoAgg</xsl:attribute>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                    Informazioni aggiuntive 
                </xsl:element>
                <xsl:value-of select="normalize-space(//tei:additional)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">Corrispondence</xsl:attribute>
                <xsl:element name="head" namespace="http://www.tei-c.org/ns/1.0"> 
                Informazioni sulla Corrispondenza
                </xsl:element>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">  
                        <xsl:text>  
                            Mittente 
                        </xsl:text>
                    </xsl:element>
                    <xsl:value-of select="//tei:correspAction[@type='sent']/tei:persName"/>
                </xsl:element>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">  
                        <xsl:text> 
                            Luogo di spedizione 
                        </xsl:text>
                    </xsl:element>                    
                    <xsl:variable name="luogosped" select="//tei:correspAction[@type='sent']/tei:placeName"/>                    
                    <xsl:if test="exists($luogosped)">
                        <xsl:if test="$luogosped!='unknown'">
                            <xsl:value-of select="$luogosped"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="empty($luogosped)">
                        Non presente
                    </xsl:if>                    
                    <xsl:if test="$luogosped='unknown'">
                        Non presente
                    </xsl:if>                   
                    <xsl:if test="$luogosped='sconosciuta'">
                        Non presente
                    </xsl:if>                    
                    <xsl:if test="$luogosped='sconosciuto'">
                        Non presente
                    </xsl:if>
                </xsl:element>           
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">  
                        <xsl:text> 
                            Data di spedizione 
                        </xsl:text>
                    </xsl:element>                    
                    <xsl:variable name="datasped" select="//tei:correspAction[@type='sent']/tei:date"/>                    
                    <xsl:if test="exists($datasped)"> 
                        <xsl:if test="$datasped!='unknown'">
                            <xsl:value-of select="$datasped"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="empty($datasped)">
                        Non presente
                    </xsl:if>                   
                    <xsl:if test="$datasped='unknown'">
                        Non presente
                    </xsl:if>                    
                    <xsl:if test="$datasped='sconosciuta'">
                        Non presente
                    </xsl:if>
                    <xsl:if test="$datasped='sconosciuto'">
                        Non presente
                    </xsl:if> 
                </xsl:element>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">  
                        <xsl:text> 
                            Destinatario
                        </xsl:text>
                    </xsl:element>
                    <xsl:variable name="destinatario" select="//tei:correspAction[@type='receiver']/tei:persName"/>
                    <xsl:if test="exists($destinatario)"> 
                        <xsl:if test="$destinatario!='unknown'">
                            <xsl:value-of select="$destinatario"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="empty($destinatario)">
                        Non presente
                    </xsl:if>
                    <xsl:if test="$destinatario='unknown'">
                        Non presente
                    </xsl:if>
                    <xsl:if test="$destinatario='sconosciuta'">
                        Non presente
                    </xsl:if>
                    <xsl:if test="$destinatario='sconosciuto'">
                        Non presente
                    </xsl:if>
                </xsl:element>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">  
                        <xsl:text> 
                            Luogo di destinazione 
                        </xsl:text>
                    </xsl:element>
                    <xsl:variable name="luogodest" select="//tei:correspAction[@type='receiver']/tei:placeName"/>
                    <xsl:if test="exists($luogodest)"> 
                        <xsl:if test="$luogodest!='unknown'">
                            <xsl:value-of select="$luogodest"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="empty($luogodest)">
                        Non presente
                    </xsl:if>
                    <xsl:if test="$luogodest='unknown'">
                        Non presente
                    </xsl:if>
                    <xsl:if test="$luogodest='sconosciuta'">
                        Non presente
                    </xsl:if>
                    <xsl:if test="$luogodest='sconosciuto'">
                        Non presente
                    </xsl:if> 
                </xsl:element>
                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">  
                        <xsl:text> 
                            Data di destinazione
                        </xsl:text>
                    </xsl:element>
                    <xsl:variable name="datasped" select="//tei:correspAction[@type='receiver']/tei:date"/>
                    <xsl:if test="exists($datasped)"> 
                        <xsl:if test="$datasped!='unknown'">
                            <xsl:value-of select="$datasped"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="empty($datasped)">
                        Non presente
                    </xsl:if>
                    <xsl:if test="$datasped='unknown'">
                        Non presente
                    </xsl:if>
                    <xsl:if test="$datasped='sconosciuta'">
                        Non presente
                    </xsl:if>
                    <xsl:if test="$datasped='sconosciuto'">
                        Non presente
                    </xsl:if> 
                </xsl:element>
            </xsl:element>
        </xsl:element>  
    </xsl:template>
    
    <xsl:template match="tei:text">
        <xsl:variable name="type" select="@type"/>
        <xsl:variable name="n" select="@n"/>
        <xsl:variable name="id" select="@xml:id"/>
        <xsl:variable name="id2" select="substring-after($id, 'LL')"/>
        <xsl:variable name="newN" select="$id2"/>
        <xsl:element  name="text" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">
                <xsl:copy-of select="$type"/>
            </xsl:attribute> 
            <xsl:attribute name="n">
                <xsl:copy-of select="$newN"/>
            </xsl:attribute> 
            <xsl:attribute name="xml:id">
                <xsl:copy-of select="$id"/>
            </xsl:attribute> 
            <xsl:apply-templates/> 
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:pb">
        <xsl:variable name="idno" select="//tei:idno[@type='inventory']"/>
        <xsl:variable name="id" select="@xml:id"/>
        <xsl:variable name="n" select="@n"/>
        <xsl:variable name="facs" select="@facs"/>
        <xsl:variable name="newN" select="concat ($idno, '.', $n)"/>
        <xsl:variable name="newidno" select="translate ($idno, '.', '-' )"/>
        <xsl:variable name="newfacs" select="concat ('data/test-img/', $idno, '/', $newidno, '_000', $n, '.dzi')"/>
        <xsl:element name="pb" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n">
                <xsl:copy-of select="$newN"/>
            </xsl:attribute>            
            <xsl:attribute name="xml:id">
                <xsl:copy-of select="$id"/>
            </xsl:attribute>
            <xsl:attribute name="facs">
                <xsl:copy-of select="$newfacs"/>
            </xsl:attribute>           
        </xsl:element>
        <xsl:for-each select="//tei:surface[@xml:id=substring-after($facs,'#')]">
            <xsl:choose>
                <xsl:when test="//tei:idno[@type='inventory']='LL1.34.I' or //tei:idno[@type='inventory']='LL1.14' or //tei:idno[@type='inventory']='LL1.13.II'">
                    <xsl:choose>
                        <xsl:when test="exists(./tei:zone/tei:zone[@rendition='Line'])"></xsl:when>
                        <xsl:when test="exists(./tei:zone[@rendition='Line'])"></xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">extratext</xsl:attribute>
                                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                                    La facciata non presenta testo autografo di Bellini relativo a questa lettera
                                </xsl:element>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="exists(./tei:zone[@rendition='Line'])"></xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">extratext</xsl:attribute>
                                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                                    La facciata non presenta testo autografo di Bellini relativo a questa lettera
                                </xsl:element>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template> 


    <xsl:template match="tei:text//tei:term">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
        <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">comment</xsl:attribute>
            <xsl:attribute name="n">T</xsl:attribute>
            <xsl:variable name="ref" select="@ref"/>
            <xsl:variable name="new" select="substring-after($ref, 'TEI-ListTerm.xml')"/>
            <xsl:variable name="listTerm" select="doc('lists/TEI-ListTerm.xml')//tei:item//tei:gloss/@target"/>
            <xsl:if test="$listTerm">
                <xsl:apply-templates select="doc('lists/TEI-ListTerm.xml')//tei:item//tei:gloss[@xml:lang='it'][@target=$new]"/>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:rs">
        <xsl:variable name="ref" select="@ref"/>
        <xsl:variable name="type" select="@type"/>
        <xsl:variable name="role" select="@role"/>
        <xsl:choose>
            <xsl:when test="$type='person'">
                <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:if test="exists($ref)">
                    <xsl:attribute name="ref">
                        <xsl:value-of select="substring-after($ref, 'TEI-ListPerson.xml')"/>
                    </xsl:attribute> 
                </xsl:if>
                <xsl:if test="exists($type)">
                    <xsl:attribute name="type">
                        <xsl:value-of select="$type"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="exists($role)">
                    <xsl:attribute name="role">
                        <xsl:value-of select="$role"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:if test="exists($ref)">
                        <xsl:attribute name="ref">
                            <xsl:value-of select="substring-after($ref, 'TEI-ListPerson.xml')"/>
                        </xsl:attribute> 
                    </xsl:if>
                    <xsl:if test="exists($type)">
                        <xsl:attribute name="type">
                            <xsl:value-of select="$type"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="exists($role)">
                        <xsl:attribute name="role">
                            <xsl:value-of select="$role"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:text//tei:rs[@type='work']">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
        <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">comment</xsl:attribute>
            <xsl:attribute name="n">O</xsl:attribute>
            <xsl:variable name="ref" select="@ref"/>
            <xsl:variable name="new" select="substring-after($ref, 'TEI-ListWork.xml#')"/>
            <xsl:variable name="listWork" select="doc('lists/TEI-ListWork.xml')//div//bibl/@xml:id"/>
            <xsl:if test="$listWork">
                <xsl:element name="hi" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="rend">bold</xsl:attribute>
                    <xsl:text >Titolo: </xsl:text>
                </xsl:element>
                <xsl:value-of select="doc('lists/TEI-ListWork.xml')//div//bibl[@xml:id=$new]/title"/> 
                <xsl:element name="hi" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="rend">bold</xsl:attribute>
                    <xsl:text >Compositore: </xsl:text>
                </xsl:element>
                <xsl:value-of select="doc('lists/TEI-ListWork.xml')//div//bibl[@xml:id=$new]//mei:composer"/> 
                <xsl:element name="hi" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="rend">bold</xsl:attribute>
                    <xsl:text >Librettista: </xsl:text>
                </xsl:element>
                <xsl:value-of select="doc('lists/TEI-ListWork.xml')//div//bibl[@xml:id=$new]/mei:librettist"/> 
                <xsl:element name="hi" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="rend">bold</xsl:attribute>
                    <xsl:text >Prima rappresentazione: </xsl:text>
                </xsl:element>
                <xsl:value-of select="doc('lists/TEI-ListWork.xml')//div//bibl[@xml:id=$new]/orgName"/> 
                <xsl:text >, </xsl:text>
                <xsl:value-of select="doc('lists/TEI-ListWork.xml')//div//bibl[@xml:id=$new]/placeName"/>
                <xsl:text >, </xsl:text>
                <xsl:value-of select="doc('lists/TEI-ListWork.xml')//div//bibl[@xml:id=$new]/date"/>
                <xsl:element name="hi" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="rend">bold</xsl:attribute>
                    <xsl:text >Note: </xsl:text>
                </xsl:element>
                <xsl:value-of select="doc('lists/TEI-ListWork.xml')//div//bibl[@xml:id=$new]/note"/> 
            </xsl:if> 
        </xsl:element>
    </xsl:template>  
    
    <xsl:template match="tei:ptr">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
        <xsl:variable name="target" select="@target"/>
        <xsl:variable name="new" select="translate($target, '#', '')"/>
        <xsl:apply-templates select="//tei:note[@xml:id=$new]"/>
    </xsl:template>
    
    <xsl:template match="tei:persName">
        <xsl:copy>
            <xsl:variable name="ref" select="@ref"/>
            <xsl:if test="exists($ref)">
                <xsl:attribute name="ref">
                    <xsl:value-of select="substring-after($ref, 'TEI-ListPerson.xml')"/>
                </xsl:attribute> 
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:placeName">
        <xsl:copy>
            <xsl:variable name="ref" select="@ref"/>
            <xsl:if test="exists($ref)">
                <xsl:attribute name="ref">
                    <xsl:value-of select="substring-after($ref, 'TEI-ListPlace.xml')"/>
                </xsl:attribute> 
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:orgName">
        <xsl:copy>
            <xsl:variable name="ref" select="@ref"/>
            <xsl:if test="exists($ref)">
                <xsl:attribute name="ref">
                    <xsl:value-of select="substring-after($ref, 'TEI-ListOrganization.xml')"/>
                </xsl:attribute>  
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:back">
        <xsl:element name="back" namespace="http://www.tei-c.org/ns/1.0"> 
            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0"> 
                <xsl:attribute name="type">hotspot</xsl:attribute>
                <xsl:variable name="facs" select="//tei:teiHeader//*[@facs]"/>
                <xsl:variable name="zone" select="//tei:zone[@rendition='HotSpot']"/>
               <xsl:for-each select="$zone">
                   <xsl:variable name="zone2" select="@xml:id"/>
                   <xsl:variable name="newid" select="concat ($zone2, 'h')"/> <!-- a cui aggiungo la lettera h -->
                   <xsl:variable name="newfacs" select="concat('#', $zone2)"/> 
                   <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                       <xsl:attribute name="xml:id">
                           <xsl:value-of select="$newid"/>
                       </xsl:attribute>
                       <xsl:attribute name="facs">
                           <xsl:value-of select="$newfacs"/>
                       </xsl:attribute>
                       <xsl:for-each select="$facs">
                           <xsl:variable name="facs3" select="@facs"/>
                           <xsl:variable name="facs4" select="translate($facs3, '#', '')"/>
                           <xsl:if test="$facs4=$zone2">
                               <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">  
                                   <xsl:value-of>
                                       <xsl:apply-templates mode="hotspot"/>
                                   </xsl:value-of>
                               </xsl:element>
                           </xsl:if>
                       </xsl:for-each>
                   </xsl:element>
               </xsl:for-each>
            </xsl:element>
            <xsl:if test="//tei:idno[@type='inventory']='LL1.35'">
                <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="type">biblCompleta</xsl:attribute>
                    <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:variable name="listbibl" select="doc('lists/TEI-ListBibl.xml')//tei:back//tei:div//tei:listBibl"/>
                        <xsl:copy-of select="$listbibl"/>
                    </xsl:element>
                </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:choice" mode="sciogliabbr"> 
        <xsl:variable name="spazi" select="concat(' ',tei:expan, ' ' )"/>
        <xsl:value-of select="$spazi"/> 
    </xsl:template>
    

    <xsl:template match="tei:persName" mode="hotspot"> 
        <xsl:copy>
            <xsl:variable name="ref" select="@ref"/>
            <xsl:if test="exists($ref)">
                <xsl:attribute name="ref">
                    <xsl:value-of select="substring-after($ref, 'TEI-ListPerson.xml')"/>
                </xsl:attribute> 
            </xsl:if>
            <xsl:apply-templates mode ="hotspot"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:placeName"  mode ="hotspot" >
        <xsl:copy>
            <xsl:variable name="ref" select="@ref"/>
            <xsl:if test="exists($ref)">
                <xsl:attribute name="ref">
                    <xsl:value-of select="substring-after($ref, 'TEI-ListPlace.xml')"/>
                </xsl:attribute> 
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:orgName" mode ="hotspot">
        <xsl:copy>
            <xsl:variable name="ref" select="@ref"/>
            <xsl:if test="exists($ref)">
                <xsl:attribute name="ref">
                    <xsl:value-of select="substring-after($ref, 'TEI-ListOrganization.xml')"/>
                </xsl:attribute>  
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
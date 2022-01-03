

xquery version "3.1";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:media-type "text/html";


declare variable $page-title := "Bellini Digital Correspondence";

<html>
    <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="description" content="Bellini Digital Correspondence"/>
    <meta name="keywords" content="Vincenzo Bellini, Bellini Digital Correspondence, edizione digitale, lettere, corrispondenza"/>
    <meta name="author" content="Santa Pellino"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    
    <link rel="stylesheet" href="style.css"/>
    
    <body>

        <header>
             <h1>  {$page-title}</h1>   
        </header>
        
        <nav>
            <ul>
                <li><a href="lettera.html">
                {
                    for $title in doc("letter/LL1_1.xml")//tei:titleStmt/tei:title
                    return $title/text()
                }
                </a></li>
                
                <li><a href="bibliografia.html">Bibliografia</a></li>
                <li><a href="listapersone.html">Persone citate</a></li>
                <li><a href="listaposti.html">Posti citati</a></li>
                <li><a href="listaorg.html">Organizazioni citate</a></li>
            </ul>
        </nav>

        <div id="corpopagina" class="corpo">

            {
            for $title in doc("letter/LL1_1.xml")//tei:titleStmt/tei:title
            return 
                <h2>
                    {$title/text()}
                </h2>
            }

             <div id="pagina1" class="pagina">


                <div id="image1" class="text-left">
                    
                        <img src="images/LL1-1_0001.jpg" width="300px" />
        
                </div>
                <br/>



                <div id="text1" class="text-right" >

                <b> Pagina 1 </b>
                <br/>

                <p>
                {
                    for $testo in doc("letter/LL1_1.xml")//tei:text//tei:body
                    return $testo//tei:ab[@n='ab_01']//text()
                }
                </p>

           

                 <p>
                {
                    for $testo in doc("letter/LL1_1.xml")//tei:text//tei:body
                    return $testo//tei:ab[@n='ab_02']//text()
                }
                </p>
        
                </div>

            </div>

            <div id="pagina2" class="pagina">


                <div id="image2" class="text-left">
                    <img src="images/LL1-1_0002.jpg" width="300px" />
                </div>
                <br/>

                <div id="text2" class="text-right" >

                <b>Pagina 2</b>
                <br/>

                <p>
                {
                    for $testo in doc("letter/LL1_1.xml")//tei:text//tei:body
                    return $testo//tei:ab[@n='ab_03']//text()
                }
                </p>
                </div>
            </div>

            <div id="pagina3" class="pagina">

                

                <div id="image3" class="text-left">
                    <img src="images/LL1-1_0003.jpg" width="300px" />
                </div>

                <br/>

                <div id="text3" class="text-right" >

                <b>Pagina 3 </b>
                <br/>

                <p>
                {
                    for $testo in doc("letter/LL1_1.xml")//tei:text//tei:body
                    return $testo//tei:ab[@n='ab_04']//text()
                }
                </p>

                </div>
            </div>

            <div id="pagina4" class="pagina">

                
                <div id="image4" class="text-left">
                    <img src="images/LL1-1_0004.jpg" width="300px" />
                </div>

                <div id="text3" class="text-right" >

                    <b>Pagina 4</b>
                    <br/>
                </div>
            </div>

            <div id="infosupporto" class="pagina">

                
                

                <div id="info" class="text-info" >
                    <p>
                    <b>Informazioni sul supporto</b>
                    <br/><br/>

                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:support/tei:p//text() 
                        }
                    
                    </p>
                    <p>
                    <b>Materiale: </b>
                    <br/>
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:material//text() 
                        }
                    
                    </p>
                    <p>
                    <b>Filigrana: </b>
                    <br/>
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:watermark//text() 
                        }
                    
                    </p>
                    <p>
                    <b>Timbri: </b>
                    <br/>
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:stamp//text() 
                        }
                    
                    </p>
                    <p>
                    <b>Dimensioni: </b>
                    <br/>
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:height//text() 
                        }
                        x
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:width//text() 
                        }
                       mm
                       <br/>
                    </p>

                    <p>
                    <b>Piegature: </b>
                    <br/>
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:foliation//text() 
                        }
                    
                    </p>

                    <p>
                    <b>Condizioni fisiche: </b>
                    <br/>
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:condition//text() 
                        }
                    
                    </p>
                </div>
            </div>

            <div id="infomani" class="pagina">


                <div id="info-mani" class="text-info" >
                    <p>
                    <b>Altre mani</b>
                    <br/><br/>
                     
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:handDesc//tei:handNote
                            return 
                            <ul>
                            <li>
                            {
                                $testo//text() 
                            }
                            </li>
                            </ul>
                        }
                
                    </p>
                </div>

            </div>

            
            
        </div>

        <footer>
            <div> Progetto a cura di Santa Pellino - Università di Pisa - Informatica umanistica -  </div> 
 
         </footer>

        
        
    </body>
</html>
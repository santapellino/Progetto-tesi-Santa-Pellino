

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
                <b>Immagini delle facciate della lettera:</b>
                <div>
                    <img src="images/LL1-1_0001.jpg" width="300px" />
                    <img src="images/LL1-1_0002.jpg" width="300px" />
                     <img src="images/LL1-1_0003.jpg" width="300px" />
                    <img src="images/LL1-1_0004.jpg" width="300px" />
                </div>
                <div id="text1" class="text-left" >
                    <b>Testo della lettera:</b>
                    <p>
                        {
                        for $testo in doc("letter/LL1_1.xml")//tei:text//tei:body
                        return $testo//tei:div[@type='letter-body']//text()
                        }
                    </p>
                </div>
                <div id="info" class="text-left" >
                    <b>Informazioni sul supporto</b>
                    <p>
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:support/tei:p//text() 
                        }      
                  
                    <b>Materiale: </b>
                    <br/>
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:material//text() 
                        }
                    <br/>
                    <b>Filigrana: </b>
                    <br/>
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:watermark//text() 
                        }
                    <br/>
                    <b>Timbri: </b>
                    <br/>
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:stamp//text() 
                        }
                    <br/>
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
                    
                    <b>Piegature: </b>
                    <br/>
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:collation//text() 
                        }
                    <br/>
                    <b>Condizioni fisiche: </b>
                    <br/>
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:supportDesc
                            return $testo//tei:condition//text() 
                        }
                    </p>
                </div>
                <div id="info-mani" class="text-left-mani" >
                    <b>Altre mani</b>
                    <ul>
                        {
                           for $testo in doc("letter/LL1_1.xml")//tei:handDesc//tei:handNote
                            return 
                            <li>
                            {
                                $testo//text() 
                            }
                            </li>
                        }
                    </ul>
                </div>
             </div>
         </div>
        <footer>
            <div> Progetto a cura di Santa Pellino - Università di Pisa - Informatica umanistica -  </div> 
         </footer>
    </body>
</html>
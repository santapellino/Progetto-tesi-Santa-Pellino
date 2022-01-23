xquery version "3.1";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:media-type "text/html";
declare variable $page-title := "Bellini Digital Correspondence";
<html>
    <head>
        <title>Bellini Digital Correspondence"</title>
        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="description" content="Bellini Digital Correspondence"/>
        <meta name="keywords" content="Vincenzo Bellini, Bellini Digital Correspondence, edizione digitale, lettere, corrispondenza"/>
        <meta name="author" content="Santa Pellino"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>  
        <link rel="stylesheet" href="style.css"/>
    </head>
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
                <li><a href="listaorg.html">Organizzazioni citate</a></li>
            </ul>
        </nav>
        <div id="corpopagina" class="bibl">
            <h2>
                Biblibliografia
            </h2>
             <div class="biblio">
                <ul>
                    {
                    for $biblio in doc("lists/TEI-ListBibl.xml")//tei:biblStruct
                    return 
                        <li>
                            {$biblio//tei:author//text()|$biblio//tei:editor//text()}. (
                            {$biblio//tei:date//text()}).
                            {$biblio//tei:title//text()}. 
                            {$biblio//tei:publisher//text()}.
                        </li>     
                    }
                </ul>
                </div>
            </div>
            <footer>
                <div> Progetto a cura di Santa Pellino - Università di Pisa - Informatica umanistica -  </div> 
            </footer>
    </body>
</html>

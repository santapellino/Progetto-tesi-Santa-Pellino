xquery version "3.1";

(:~ This is the default application library module of the BDC app.
 : @author Santa Pellino
 : @version 1.0.0
 : @see http://exist-db.org
 :)

(: Module for app-specific template functions :)
module namespace app="http://exist-db.org/yes/BDC/templates";
import module namespace templates="http://exist-db.org/xquery/html-templating";
import module namespace lib="http://exist-db.org/xquery/html-templating/lib";
import module namespace config="http://exist-db.org/yes/BDC/config" at "config.xqm";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace mei="https://music-encoding.org/schema/4.0.1/mei-all.rng";

declare
    %templates:wrap
function app:foo($node as node(), $model as map(*)) {
    <p>Dummy templating function.</p>
};
 
declare function app:test($node as node(), $model as map(*)) {
    <p>Dummy template output generated by function app:test at {current-dateTime()}. The templating
        function was triggered by the class attribute <code>class="app:test"</code>.</p>
};

(:~  Funzione biblio richiamata dal data-template="app:biblio" o dalla classe class="app:biblio" :)
 
declare function app:biblio($node as node(), $model as map(*)) {
    for $biblio in doc("/db/apps/BDC/Lists/TEI-ListBibl.xml")//tei:biblStruct
                return 
                    <ul>
                        <li>Autore:
                            {$biblio//tei:author//text()|$biblio//tei:editor//text()}. (
                            {$biblio//tei:date//text()}).
                            {$biblio//tei:title//text()}. 
                            {$biblio//tei:publisher//text()}.
                        </li>
                    </ul>
};

(: Funzione biblio richiamata dal data-template="app:place" o dalla classe class="app:place":)

declare function app:place($node as node(), $model as map(*)) {
    for $place in doc("/db/apps/BDC/Lists/TEI-ListPlace.xml")//tei:place
                return 
                    <ul>
                        <li>
                            <a href="
                                {$place//tei:placeName/@ref}
                            ">
                            {$place//tei:placeName//text()|$place//tei:geogName//text()}
                            (
                            {$place//tei:country//text()}
                            )
                            </a>
                        </li>
                    </ul>
};

(: Funzione biblio richiamata dal data-template="app:people" o dalla classe class="app:people":)

declare function app:people($node as node(), $model as map(*)) {
    for $people in doc("/db/apps/BDC/Lists/TEI-ListPerson.xml")//tei:person
                return 
                    <ul>
                        <li>
                            {$people//tei:surname//text()}
                            (
                            {$people//tei:forename//text()}
                            )
                        </li>
                    </ul>
};

(: Funzione biblio richiamata dal data-template="app:opere" o dalla classe class="app:opere":)

declare function app:opere($node as node(), $model as map(*)) {
    for $opere in doc("/db/apps/BDC/Lists/TEI-ListWork.xml")//listBibl/bibl
                return 
                    <ul>
                        <li>
                            {$opere/title//text()}
                            .
                            Compositore: 
                            {$opere/mei:composer//text()}
                            . Librettista: 
                            {$opere/mei:librettist//text()}
                            . Luogo:
                            {$opere/orgName//text()}
                            di 
                            {$opere/placeName//text()}
                            .Data:
                            {$opere/date//text()}
                            .
                        </li>
                    </ul>
};

(: Funzione lettere richiamata dal data-template="app:lettere" o dalla classe class="app:lettere":)

declare function app:lettere($node as node(), $model as map(*)) {
    for $lettere in collection("/db/apps/BDC/Lettere/")
                return 
                    <ul>
                        <li>
                            <a>
                            {$lettere//tei:idno[@type='inventory']} 
                            -
                            {$lettere//tei:titleStmt/tei:title/text()}
                            </a>    
                        </li>
                    </ul>
};
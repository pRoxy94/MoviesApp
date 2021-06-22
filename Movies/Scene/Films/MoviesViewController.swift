//
//  ViewController.swift
//  Movies
//
//  Created by Rossana Laricchia on 17/05/21.
//

import UIKit

/*
 I protocolli che si utilizzano per far gestire una TableView da un view controller classico sono due:
 1. UITableViewDataSource: definisce i metodi per riempire la tabella -> creazione sezioni, righe e celle
 2. UITableViewDelegate: gestione eventi della tableview (es. tap su riga tabella), non contiene metodi required quindi bisogna implementarlo a mano
 */
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var films: [Movie] = []
    
    /*
     La tableView non sa chi gestirà i suoi dati anche se abbiamo messo il rif all'UITableViewDataSource. Dobbiamo assegnare il riferimento dell'oggetto gestore dei dati della tabella ad una proprietà della tableView ovvero dataSource
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // con questa istruzione assegno a dataSource l'oggetto moviesViewController. La tableView andrà ad invocare i metodi all'interno del moviesViewController
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.films = [
            Movie.init(title: "Captain America",
                      description: "Captain America è un film del 2011 diretto da Joe Johnston. Basato sul personaggio dei fumetti Marvel Comics Capitan America, è stato scritto da Christopher Markus e Stephen McFeely. Prodotto dai Marvel Studios e distribuito dalla Paramount Pictures, è il quinto film del Marvel Cinematic Universe. Ambientato prevalentemente durante la seconda guerra mondiale, il film racconta la storia di Steve Rogers, un magrolino ragazzo di Brooklyn che viene trasformato nel super soldato Capitan America per aiutare i soldati in guerra. Rogers deve affrontare lo spietato Teschio Rosso, un ufficiale di Adolf Hitler che vuole impadronirsi del misterioso Tesseract e usarlo come arma per annientare il mondo.", image: #imageLiteral(resourceName: "captain-america")),
            Movie.init(title: "Guardiani della Galassia",
                      description: "Nel 1988, subito dopo la morte della madre, il piccolo Peter Quill viene rapito da un gruppo di pirati spaziali chiamati Ravagers, guidati da Yondu Udonta. Ventisei anni dopo, sul pianeta Morag, Quill ruba una sfera, l'Orb, ma viene ostacolato da Korath, un alleato dell'estremista Kree Ronan l'accusatore. Quill riesce a seminare Korath e a fuggire da Morag con la sfera, ma Yondu, venuto a sapere del furto e interessato all'Orb, mette una taglia sulla sua testa, mentre Ronan manda la letale assassina Gamora a recuperare la sfera. I Guardiani della Galassia in una scena del trailer. Quill si reca su Xandar, capitale dell'impero Nova, per vendere la sfera al Broker, ma egli, venuto a sapere dell'interesse di Ronan per l'artefatto, decide di sospendere le trattative. ", image: #imageLiteral(resourceName: "guardiani-della-galassia")),
            Movie.init(title: "Iron Man",
                      description: "Iron Man è un film del 2008 diretto da Jon Favreau. Basato sull'omonimo personaggio dei fumetti della Marvel Comics Iron Man, interpretato da Robert Downey Jr. Prodotto dai Marvel Studios e distribuito dalla Paramount Pictures, è il primo film del Marvel Cinematic Universe. È stato scritto da Mark Fergus, Hawk Ostby, Art Marcum e Matt Holloway. Nel film lo scienziato e miliardario Tony Stark costruisce un'armatura tecnologicamente avanzata e diventa il supereroe Iron Man. Tony Stark è a capo delle Stark Industries, nota azienda produttrice di armi. Presso una base militare statunitense in Afghanistan, Tony presenta il suo nuovo missile, il Jericho. Terminata l'esposizione, Stark si mette in viaggio verso l'aeroporto, ma durante il tragitto il convoglio che lo scorta viene attaccato da alcuni terroristi e Tony viene rapito. Numerose schegge si conficcano nel petto dell'inventore a seguito dell'esplosione di una bomba e, per evitare che esse raggiungano il cuore, Yinsen, un fisico compagno di prigionia di Tony, gli impianta nel petto un elettromagnete.", image: #imageLiteral(resourceName: "iron-man")),
            Movie.init(title: "Ritorno al futuro",
                      description: "Ritorno al futuro (Back to the Future) è un film del 1985 diretto da Robert Zemeckis e interpretato da Michael J. Fox e Christopher Lloyd. Primo episodio della trilogia omonima, è considerato un'icona del cinema degli anni ottanta e ha riscosso un enorme successo a livello internazionale. La pellicola ha ricevuto il premio Oscar al miglior montaggio sonoro. Hill Valley, California, 25 ottobre 1985. Marty McFly è un diciassettenne studente di liceo, pigro e spesso ritardatario ma coraggioso, gentile e di buon cuore, fidanzato con Jennifer Parker, sua coetanea e compagna di scuola. Marty sogna di diventare una rockstar e suona la chitarra in un gruppo rock amatoriale, pur senza molta fortuna: il gruppo viene infatti bocciato al provino per suonare al ballo della scuola, perché i docenti ritengono Marty e i suoi compagni troppo rumorosi.", image: #imageLiteral(resourceName: "ritorno-al-futuro")),
        ]
    }

    /*
     TABLEVIEW: composta da tre elementi fondamentali
     1. section -> pagina della tableview che permette di raggruppare dei dati secondo una logica decisa da noi. Esempio: rubrica di sistema, ci sono tante sezioni quante sono le lettere dell'alfabeto. Di solito una tableview ha almeno una sezione
     
     2. righe -> in una sezione si creano tante row quanti sono gli elementi da visualizzare. Esempio: tre film preferiti -> tre row
     
     3. celle -> all'interno di una row andrà una cella.
     
     Poichè solitamente gli elementi in una tabella si assomigliano in aspetto ma non in contenuto, si crea una cella chiamata prototipo che viene clonata tante volte quante sono il numero di righe. Poi ad ogni cella viene passato il contenuto.
     
     Una sezione divisa in righe, all'interno di ogni riga avremo una TableViewCell. Queste celle saranno una clonazione dell'unica cella (prototipo) che abbiamo creato.
     
     Sezioni e righe viene creato lato codice, invece il prototipo delle celle può essere creto lato interface builder
     */
    
    /*
     Metodo delegato alla creazione del numero di righe per ogni sezione
     Due parametri:
     1) tableView
     2) numero di sezioni
     Restituisce un intero ovvero il numero di righe della sezione specifica
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // significa che le sezioni saranno composte da 10 righe. Se voglio differenziare il numero di row in base alla section mi basta fare un if o switch sul valore del parametro section
        return self.films.count
    }
    
    /*
     Metodo per il recupero dell'istanza di una cella riutilizzabile dalla tableView per inserirla all'interno di una riga. Invocato ad ogni riga
     Due parametri:
     1) tableView
     2) indexPath: oggetto che contiene il rif alla riga per cui vogliamo creare la cella. Contiene due valori principali: section e row
     Restituisce un'istanza dell'oggetto UITableViewCell, significa che per ogni riga creeremo una UITableViewCell
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // contiene il rif alla sezione per cui vogliamo creare le celle
        // indexPath.section
        // rif all'indice della riga per cui è stato invocato il metodo cellForRowAt
        // indexPath.row
        
        // recupero dall'array l'elemento in posizione indexPath.row (0,1,2,3)
        let film = self.films[indexPath.row]
        
        // CREA UNA CELLA: partendo dall'identifier, nel nostro caso quello della prototype Cells -> movieCell. Stiamo creando una cella da mettere all'indexPath ovvero alla riga per cui è stato invocato il metodo cellForRowAt. Questo metodo ha la stessa funzione della recycler -> riutilizza le stesse celle
        // Sappiamo per certo che un oggetto di movieCell è gestito dalla classe MovieTableViewCell -> possiamo effettuare il cast
        let cell: MovieTableViewCell =  tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        cell.movieTitleLabel.text = film.title
        cell.movieImageView.image = film.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieSelected = self.films[indexPath.row]
        self.performSegue(withIdentifier: "segueToDetail", sender: movieSelected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailViewController {
            let vc = segue.destination as! DetailViewController
            vc.receivedMovie = sender as? Movie
        }
    }
}


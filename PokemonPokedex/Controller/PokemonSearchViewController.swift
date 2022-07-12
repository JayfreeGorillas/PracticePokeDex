
import UIKit

protocol AddPokemonDelegate {
    func addPokemon(pokemon: PokemonModel)
}

class PokemonSearchViewController: UIViewController {
    
    
    var delegate: AddPokemonDelegate?
    var pokemonName = ""
    var pokemonType = ""
    var pokemonAbilities = ""
    var image: UIImage?
    var pokemonID = ""
    var imageURL: URL?
    
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var pokemonTypeLabel: UILabel!
    @IBOutlet var pokemonAbilitiesLabel: UILabel!
    @IBOutlet var pokemonIDLabel: UILabel!
    @IBOutlet var pokemonImage: UIImageView!
    @IBAction func searchPressed(_ sender: UIButton) {
        print("Search pressed")
        if let pokemon = searchTextField.text {
            pokemonManager.fetchPokemon(pokemonName: pokemon)
            
        }
    
        
        
    }
    
    
    //MARK: - figure out how to persist all pokemon array from searchViewController -> viewController to use for tableview
    @IBAction func savePokemon(_ sender: UIButton) {
        print("save button pressed")
        
        

        let id = Int(pokemonIDLabel.text!) ?? 0
        // update to new pokemonModel
        
        guard let imageURL = imageURL else {
            return
        }
        guard let image = image else {
            return
        }

       



        let pokemon = PokemonModel(pokemonName: pokemonNameLabel.text!, pokemonID: id, pokemonType: pokemonTypeLabel.text!, pokemonAbilities: pokemonAbilitiesLabel.text!, imageURL: imageURL, image: image)
        print(pokemon.imageURL)
        print(pokemon.pokemonAbilities)
        print(pokemon.pokemonName)
        print(pokemon.pokemonType)
        print(pokemon.pokemonID)
        print(pokemon.image)
//        var pokemon = PokemonModel(pokemonName: pokemonNameLabel.text!, pokemonID: id, pokemonType: pokemonTypeLabel.text!, pokemonAbilities: pokemonAbilitiesLabel.text!, pokemonImage: image! )
        self.delegate?.addPokemon(pokemon: pokemon)
        // this will fix once i fix pokemon var
        
        

        
    }
    

    var pokemonManager = PokemonManager()
    var pokemonList = PokemonFavoritesViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonManager.delegate = self
        searchTextField.delegate = self
        

    }
    
    
    
    


}




extension PokemonSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let pokemon = searchTextField.text {
            pokemonManager.fetchPokemon(pokemonName: pokemon)
            
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "search pokemon"
            return false
        }
        
    }
    
    // MARK- Help understanding this and how it works
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print("Download Finished")
            // always update the UI from the main thread
            let image = UIImage(data: data)
            DispatchQueue.main.async() { [weak self] in
                self?.pokemonImage.image = image
                self?.image = image
                                
                
                // set pokemons image here
            }
        }
    }
}



extension PokemonSearchViewController: PokemonManagerDelegate {
    
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel) {
        
        //pokemonManager.downloadImage(from: pokemon.pokemonImage)
        
        DispatchQueue.main.async {
            self.pokemonNameLabel.text = "\(pokemon.pokemonName)"
            self.pokemonAbilitiesLabel.text = "Abilities: \(pokemon.pokemonAbilities)"
            self.pokemonIDLabel.text = "ID: \(pokemon.pokemonID)"
            self.pokemonTypeLabel.text = "Type: \(pokemon.pokemonType)"
            self.downloadImage(from: pokemon.imageURL)
            //self.pokemonImage.image = UIImage(data: pokemon.pokemonImage)
            self.pokemonType = pokemon.pokemonType
            self.pokemonAbilities = pokemon.pokemonAbilities
            self.pokemonName = pokemon.pokemonName
            self.imageURL = pokemon.imageURL
//            self.image = pokemon.image
            
            
//            print("this is pokemon image variable \(self.image?.description)")
//            print("this is pokemon type var \(self.pokemonType)")
//            print("this is pokemon name var \(self.pokemonName)")
//            print("this is pokemon abilities var \(self.pokemonAbilities)")
            
            

        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

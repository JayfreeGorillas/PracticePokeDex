
import UIKit

class PokemonFavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddPokemonDelegate {
    
    func addPokemon(pokemon: PokemonModel) {
        print(pokemon.pokemonName)
        pokemonManager.addPokemonToArray(pokemon: pokemon)
        print(pokemonManager.favoritePokemon)
        //use pokemonManger save pokemon method in here
    }
    
    @IBOutlet var favoritePokemonTV: UITableView!
    
    var pokemonManager = PokemonManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pokemonSearchVC = segue.destination as? PokemonSearchViewController else {return}
        
        pokemonSearchVC.delegate = self
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // replace this for pokemon favorites
        return pokemonManager.favoritePokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "favoritePokemon")
        
        cell.textLabel?.text = "\(pokemonManager.favoritePokemon[indexPath.row].pokemonName)"
        
        
        
        return cell
    }
     //MARK: - learn how to segue from cell into a new view conrtroller...
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         print(pokemonManager.favoritePokemon[indexPath.row].pokemonName)
//         print(pokemonManager.favoritePokemon[indexPath.row].pokemonAbilities)
//         print(pokemonManager.favoritePokemon[indexPath.row].pokemonID)
//         print(pokemonManager.favoritePokemon[indexPath.row].pokemonType)
//         print(pokemonManager.favoritePokemon[indexPath.row].pokemonImage)
         
         if let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailVC {
             detailVC.name = pokemonManager.favoritePokemon[indexPath.row].pokemonName
             detailVC.types = pokemonManager.favoritePokemon[indexPath.row].pokemonType
             detailVC.abilities = pokemonManager.favoritePokemon[indexPath.row].pokemonAbilities
             detailVC.id = "\(pokemonManager.favoritePokemon[indexPath.row].pokemonID)"
             detailVC.image = pokemonManager.favoritePokemon[indexPath.row].image
             // update to assign imageurl to image to be able to pass over
             self.navigationController?.pushViewController(detailVC, animated: true)
         }
         
         tableView.deselectRow(at: indexPath, animated: true)

         
        
         
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("Inside view will appear")
        print(pokemonManager.favoritePokemon.count)
        favoritePokemonTV.reloadData()
    }

}


    


    
    




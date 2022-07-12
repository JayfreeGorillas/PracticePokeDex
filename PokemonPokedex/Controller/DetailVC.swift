

import UIKit

class DetailVC: UIViewController {

    @IBOutlet var pokemonName: UILabel!
    
    @IBOutlet var pokemonImage: UIImageView!
    
    
    @IBOutlet var idLabel: UILabel!
    
    @IBOutlet var pokemonAbilitiesLabel: UILabel!
    
    @IBOutlet var pokemonTypes: UILabel!
    
    
    var pokemon: PokemonModel!
    var name = ""
    var id = ""
    var abilities = ""
    var types = ""
    var image = UIImage()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonName.text = name
        idLabel.text = id
        pokemonAbilitiesLabel.text = abilities
        pokemonTypes.text = types
        pokemonImage.image = image
        view.backgroundColor = .systemPink
        
        
        
       // self.downloadImage(from: pokemon.pokemonImage)
        
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        guard let image = image else {
//            return
//        }
//
//        downloadImage(from: image)
 
    }
    
//    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
//
//    func downloadImage(from url: URL) {
//        print("Download Started")
//        getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print("Download Finished")
//            // always update the UI from the main thread
//            DispatchQueue.main.async() { [weak self] in
//                self?.pokemonImage.image = UIImage(data: data)
//            }
//        }
//    }


}

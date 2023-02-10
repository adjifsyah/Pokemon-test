//
//  MyPokemonViewController.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 10/02/23.
//

import UIKit
import CoreData

class MyPokemonViewController: UIViewController {
    @IBOutlet weak var pokemonTableView: UITableView!
    
    var managedObjectContext: NSManagedObjectContext!
    var presenter: MyPokemonPresenterProtocol?
    
    @IBOutlet weak var msgEmptyData: UIStackView!
    
    var myPokemonData: [PokemonModel] = []
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getListMyPokemon(navigationController: navigationController!)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        title = "Pokemon"
        setupTableView()
    }
    
    private func setupTableView() {
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        let nibCell = UINib(nibName: "ListPokemonCell", bundle: nil)
        pokemonTableView.register(nibCell, forCellReuseIdentifier: "myListCell")
    }
}

extension MyPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        msgEmptyData.isHidden = myPokemonData.isEmpty ? false : true
        return myPokemonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myListCell", for: indexPath) as? ListPokemonCell else { return UITableViewCell() }
        let pokemonList = myPokemonData[indexPath.row]
        cell.getPokemon(imageStr: pokemonList.imageStr, name: pokemonList.name)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailPokemonRouter.createDetailModul()
        let dataPokemon = myPokemonData[indexPath.row]
        detail.getId = dataPokemon.pokemonId
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(detail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            let removePokemon = myPokemonData[indexPath.row]
            
            myPokemonData.remove(at: indexPath.row)
            self.pokemonTableView.deleteRows(at: [indexPath], with: .automatic)
            presenter?.removeMyPokemon(name: removePokemon.name, navigationControlle: navigationController!)
          }
    }
}

extension MyPokemonViewController: MyPokemonViewProtocol {
    func showListMyPokemon(data: [PokemonModel]) {
        DispatchQueue.main.async {
            self.myPokemonData = data.filter { $0.name != "" }
            self.pokemonTableView.reloadData()
        }
    }
    
    func showSuccessRemove() {
        pokemonTableView.reloadData()
    }
}

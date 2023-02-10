//
//  ListPokemonViewViewController.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import UIKit

class ListPokemonViewController: UIViewController {
    @IBOutlet weak var pokemonTableView: UITableView!
    @IBOutlet weak var messageStackView: UIStackView!
    var presenter: ListPokemonPresenterProtocol?
    
    var pokemonDatasource: [PokemonModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchListPokemon(navController: navigationController ?? UINavigationController())
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
        pokemonTableView.register(nibCell, forCellReuseIdentifier: "listCell")
    }
    
}

extension ListPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messageStackView.isHidden = pokemonDatasource.isEmpty ? false : true
        return pokemonDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListPokemonCell else { return UITableViewCell() }
        let pokemonList = pokemonDatasource[indexPath.row]
        cell.getPokemon(imageStr: pokemonList.imageStr, name: pokemonList.name)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailPokemonRouter.createDetailModul()
        let dataPokemon = pokemonDatasource[indexPath.row]
        detail.getId = dataPokemon.name
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension ListPokemonViewController: ListPokemonViewProtocol {
    func showPokemonList(data: [PokemonModel]) {
        DispatchQueue.main.async {
            self.pokemonDatasource = data
            self.pokemonTableView.reloadData()
        }
    }
}

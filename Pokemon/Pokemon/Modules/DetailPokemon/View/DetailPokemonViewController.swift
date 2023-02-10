//
//  DetailPokemonViewController.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 09/02/23.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tblStats: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnCatchPokemon: UIButton!
    
    @IBOutlet weak var weightPokemon: UILabel!
    @IBOutlet weak var heightPokemon: UILabel!
    @IBOutlet weak var experiencePokemon: UILabel!
    
    var presenter: DetailPokemonPresenterProtocol?
    var dataDetail: DetailPokemonResponse?
    let catchPokemonVC = CatchPokemonVC()
    
    var getId: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupView() {
        presenter?.fetchDetailPokemon(byId: getId, navigationController: navigationController!)
        setupTableView()
        setupBtn()
        setupContainerData()
    }
    
    private func setDetailValue(data: DetailPokemonResponse) {
        weightPokemon.text = "\(data.pokemonWeight)"
        heightPokemon.text = "\(data.pokemonHeight)"
        experiencePokemon.text = "\(data.pokemonExperience)"
        
        lblTitle.text = data.pokemonName.capitalized
        imgPokemon.downloaded(from: data.pokemonImage)
    }
    
    private func setupTableView() {
        tblStats.delegate = self
        tblStats.dataSource = self

        tblStats.rowHeight = 28
        tblStats.estimatedRowHeight = UITableView.automaticDimension
        
        let nibStats = UINib(nibName: "BaseStatsCell", bundle: nil)
        tblStats.register(nibStats, forCellReuseIdentifier: "progressCell")
    }
    
    private func setupBtn() {
        btnCatchPokemon.addTarget(self, action: #selector(catchPokemon), for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(goBack(sender:)), for: .touchUpInside)
    }
    
    private func setupContainerData() {
        containerView.layer.cornerRadius = 10
    }
    
    @objc
    private func catchPokemon() {
        catchPokemonVC.modalPresentationStyle = .custom
        catchPokemonVC.pokeName = dataDetail?.pokemonName ?? ""
        catchPokemonVC.getImageUrl = dataDetail?.pokemonImage ?? ""
        
        self.present(catchPokemonVC, animated: false)
        catchPokemonVC.btnSaveNameAlias.addTarget(self, action: #selector(onTapSaveNameAlias), for: .touchUpInside)
    }
    
    @objc
    private func onTapSaveNameAlias() {
        presenter?.saveMyPokemon(name: catchPokemonVC.getNameAlias, imageUrl: catchPokemonVC.getImageUrl, navigationController: navigationController!)
    }
    
    @objc
    private func goBack(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataDetail?.pokemonStatistics.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as? BaseStatsCell,
              let dataStatistic = dataDetail?.pokemonStatistics[indexPath.row]
        else { return UITableViewCell() }
        
        cell.setProgress(title: dataStatistic.titleType, value: dataStatistic.valueType)
        
        return cell
    }
}

extension DetailPokemonViewController: DetailPokemonViewProtocol {
    func showPokemonList(data: DetailPokemonResponse) {
        DispatchQueue.main.async {
            self.dataDetail = data
            if let datas = self.dataDetail {
                self.setDetailValue(data: datas)
                self.tblStats.reloadData()
            }
        }
    }
}

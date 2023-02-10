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
    
    @IBOutlet weak var vwTypePokemon1: UIView!
    @IBOutlet weak var vwTypePokemon2: UIView!
//    @IBOutlet weak var vwTypePokemon3: UIView!
    
    @IBOutlet weak var lblTypePokemon1: UILabel!
    @IBOutlet weak var lblTypePokemon2: UILabel!
    
    @IBOutlet weak var weightPokemon: UILabel!
    @IBOutlet weak var heightPokemon: UILabel!
    @IBOutlet weak var experiencePokemon: UILabel!
    
    @IBOutlet weak var widthVwType1: NSLayoutConstraint!
    @IBOutlet weak var widthVwType2: NSLayoutConstraint!
    
    var presenter: DetailPokemonPresenterProtocol?
    var dataDetail: DetailPokemonResponse?
    let catchPokemonVC = CatchPokemonVC()
    
    var getId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupView() {
        presenter?.fetchDetailPokemon(byId: getId ?? 0, navigationController: navigationController!)
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
        
        setType(data: data.pokemonTypes)
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
    
    private func setType(data: [PokemonType]) {
        print(data.count)
        if data.count > 1 {
            widthVwType1.constant = 200
            widthVwType2.constant = 200
            lblTypePokemon1.text = data[0].pokemonType
            lblTypePokemon2.text = data[1].pokemonType
            vwTypePokemon2.isHidden = false
        } else if data.count > 0 {
            lblTypePokemon1.text = data[0].pokemonType
            vwTypePokemon2.isHidden = true
            widthVwType1.constant = 200
            widthVwType2.constant = 0
        }
    }
    
    private func setupContainerData() {
        containerView.layer.cornerRadius = 10
        vwTypePokemon1.layer.cornerRadius = 6
        vwTypePokemon2.layer.cornerRadius = 6
//        vwTypePokemon3.layer.cornerRadius = 8
    }
    
    @objc
    private func catchPokemon() {
        catchPokemonVC.modalPresentationStyle = .custom
        catchPokemonVC.pokeName = dataDetail?.pokemonName ?? ""
        catchPokemonVC.getImageUrl = dataDetail?.pokemonImage ?? ""
        catchPokemonVC.getId = getId ?? 0
        
        self.present(catchPokemonVC, animated: false)
        catchPokemonVC.btnSaveNameAlias.addTarget(self, action: #selector(onTapSaveNameAlias), for: .touchUpInside)
    }
    
    @objc
    private func onTapSaveNameAlias() {
        presenter?.saveMyPokemon(name: catchPokemonVC.getNameAlias, imageUrl: catchPokemonVC.getImageUrl, pokeId: getId ?? 0, navigationController: navigationController!)
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

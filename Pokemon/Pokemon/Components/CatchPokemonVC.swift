//
//  CatchPokemonVC.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 09/02/23.
//

import UIKit

class CatchPokemonVC: UIViewController {
    @IBOutlet weak var dimmedView: UIView!
    @IBOutlet weak var vwRandomPick: UIView!
    @IBOutlet weak var lblResultIndicator: UILabel!
    @IBOutlet weak var lblRandomPick: UILabel!
    @IBOutlet weak var lblMessagePick: UILabel!
    @IBOutlet weak var containerNameAlias: UIView!

    @IBOutlet weak var btnTryCatchPokemon: UIButton!
    @IBOutlet weak var btnClosePopup: UIButton!
    @IBOutlet weak var btnSaveNameAlias: UIButton!
    @IBOutlet weak var btnCancelSaveAlias: UIButton!
    
    @IBOutlet weak var nameAliasTextField: UITextField!
    @IBOutlet weak var heightResultPopup: NSLayoutConstraint!
    @IBOutlet weak var heightMessageResultPopup: NSLayoutConstraint!
    @IBOutlet weak var heightButtonStackView: NSLayoutConstraint!
    @IBOutlet weak var bottomNameAliasConstraint: NSLayoutConstraint!
    var timer: Timer?
    var isPopup: Bool = false
    var heightBGNameAlias: CGFloat = 0
    var rolling = Int.random(in: 1...6)
    var pokeName: String = ""
    
    var getNameAlias: String = ""
    var getImageUrl: String = ""
    var getId: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        resetPopup()
        resetBS()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animatePresentPopup()
        onTapTryAgain()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        vwRandomPick.layer.cornerRadius = 10
        setupBtn()
        setupTextField()
    }
}

extension CatchPokemonVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        getNameAlias = textField.text!
    }
}

extension CatchPokemonVC {
    private func setupTextField() {
        nameAliasTextField.delegate = self
    }
    
    private func setupBtn() {
        btnTryCatchPokemon.addTarget(self, action: #selector(onTapTryAgain), for: .touchUpInside)
        btnClosePopup.addTarget(self, action: #selector(onTapClosePopup), for: .touchUpInside)
        btnCancelSaveAlias.addTarget(self, action: #selector(onTapClosePopup), for: .touchUpInside)
        btnSaveNameAlias.addTarget(self, action: #selector(onTapSaveNameAlias), for: .touchUpInside)
        
    }
    
    // MARK: - SETUP CONDITION
    private func getResultConditiion(isSuccess: Bool) {
        let successMessage = "successful catch \(pokeName.capitalized)"
        let failMessage = "failed to catch \(pokeName.capitalized)"
        let success = successMessage.components(separatedBy: " ").first?.capitalized
        let fail = failMessage.components(separatedBy: " ").first?.capitalized
        
        lblResultIndicator.text = isSuccess ? success : fail
        lblResultIndicator.backgroundColor = isSuccess ? .green : .red
        lblMessagePick.text = isSuccess ? successMessage : failMessage
        
    }
    
    private func setupCatch(result: Int) {
        let isSuccessCatch = result > 50
        isSuccessCatch ? catchSuccess(isSuccess: isSuccessCatch) : catchFail(isSuccess: isSuccessCatch)
    }
    
    private func catchSuccess(isSuccess: Bool) {
        getResultConditiion(isSuccess: isSuccess)
        heightButtonStackView.constant = 0
        heightResultPopup.constant = 40
        heightMessageResultPopup.constant = 32
        
        btnClosePopup.isHidden = true
        btnTryCatchPokemon.isHidden = true
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { tim in
            self.animatedHidePopup()
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                self.animatePresentBS()
            }
        }
    }
    
    private func catchFail(isSuccess: Bool) {
        getResultConditiion(isSuccess: isSuccess)
        heightButtonStackView.constant = 32
        heightResultPopup.constant = 40
        heightMessageResultPopup.constant = 32
        
        btnClosePopup.isHidden = false
        btnTryCatchPokemon.isHidden = false
    }
}

extension CatchPokemonVC {
    // MARK: - OBJC
    @objc
    private func onTapTryAgain() {
        var rolling = Int.random(in: 1...100)
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1) {
                rolling = Int.random(in: 1...100)
                self.setupCatch(result: rolling)
                self.lblRandomPick.text = "\(rolling)"
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    private func onTapSaveNameAlias() {
        animatedDismissPopup()
    }
    
    @objc
    private func onTapClosePopup() {
        animatedDismissPopup()
    }
    
    @objc
    private func onTapBackground() {
        animatedDismissPopup()
    }
}

extension CatchPokemonVC {
    // MARK: - Setup show
    private func resetPopup() {
        heightResultPopup.constant = 0
        heightMessageResultPopup.constant = 0
        vwRandomPick.alpha = 0
        heightButtonStackView.constant = 0
        btnTryCatchPokemon.isHidden = true
        btnClosePopup.isHidden = true
    }
    
    private func resetBS() {
        heightBGNameAlias = -containerNameAlias.frame.size.height
        bottomNameAliasConstraint.constant = heightBGNameAlias
    }
    
    private func animatePresentPopup() {
        isPopup = true
        animateShowDimmedView()
        UIView.animate(withDuration: 0.2) {
            self.vwRandomPick.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func animatePresentBS() {
        animateShowDimmedView()
        UIView.animate(withDuration: 0.2) {
            self.bottomNameAliasConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = 0.6
        }
    }
    
    private func animateHideDimmedView() {
        dimmedView.alpha = 0.6
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = 0
        }
    }
    
    private func animatedHidePopup() {
        UIView.animate(withDuration: 0.2) {
            self.resetPopup()
            self.view.layoutIfNeeded()
        }
    }
    
    private func animatedDismissPopup() {
        animateHideDimmedView()
        UIView.animate(withDuration: 0.2) {
            self.resetPopup()
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    private func animatedDismissBS() {
        animateHideDimmedView()
        UIView.animate(withDuration: 0.3) {
            self.bottomNameAliasConstraint.constant = self.heightBGNameAlias
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}

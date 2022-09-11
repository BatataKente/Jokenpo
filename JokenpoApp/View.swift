//
//  ViewController.swift
//  JokenpoApp
//
//  Created by Josicleison on 09/09/22.
//

import UIKit

class View: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        
        let titleLabel = viewModel.createLabel("Jokenpo")
        
        return titleLabel
    }()
    
    private var images = [App.stone, App.paper, App.scissors, App.lizard, App.spok]
    
    private lazy var dificultyStackView: UIStackView = {
        
        let eazyButton = viewModel.createButton("Eazy")
        let hardButton = viewModel.createButton("Hard")
        hardButton.isSelected = true
        
        let buttonsAction = {
            
            self.playerChooseCollectionView.reloadData()
            
            eazyButton.isSelected = !eazyButton.isSelected
            hardButton.isSelected = !hardButton.isSelected
            
            self.cpuChooseImageView.image = nil
        }
        
        let eazyHandler = {(action: UIAction) in
            
            self.images = [App.stone, App.paper, App.scissors]
            buttonsAction()
        }
        
        eazyButton.addAction(UIAction(handler: eazyHandler), for: .touchUpInside)
        
        let hardHandler = {(action: UIAction) in
            
            self.images = [App.stone, App.paper, App.scissors, App.lizard, App.spok]
            buttonsAction()
        }
        
        hardButton.addAction(UIAction(handler: hardHandler), for: .touchUpInside)
        
        let dificultyStackView = UIStackView(arrangedSubviews: [eazyButton, hardButton])
        dificultyStackView.axis = .vertical
        
        return dificultyStackView
    }()
    
    private let cellIdentifier = "Cell"
    
    private lazy var playerChooseCollectionView: UICollectionView = {
        
        let itemSize = 128
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.scrollDirection = .horizontal
        
        let playerChooseCollectionView = UICollectionView(frame: view.frame,
                                                          collectionViewLayout: layout)
        playerChooseCollectionView.delegate = self
        playerChooseCollectionView.dataSource = self
        playerChooseCollectionView.backgroundColor = App.color
        
        playerChooseCollectionView.register(Cell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        return playerChooseCollectionView
    }()
    
    private let versusImageView: UIImageView = {
        
        let versusImageView = UIImageView()
        versusImageView.image = App.versus
        
        return versusImageView
    }()
    
    private let cpuChooseImageView: UIImageView = {
        
        let cpuChooseImageView = UIImageView()
        cpuChooseImageView.contentMode = .scaleAspectFit
        
        return cpuChooseImageView
    }()
    
    private lazy var resultLabel: UILabel = {
        
        let resultLabel = viewModel.createLabel()
        
        return resultLabel
    }()
    
    private lazy var scoreLabels: [UILabel] = {
        
        let winLabel = viewModel.createLabel("Wins: 0", font: App.smallFont)
        let drawLabel = viewModel.createLabel("Draw: 0", font: App.smallFont)
        let LoseLabel = viewModel.createLabel("Lose: 0", font: App.smallFont)
        
        return [winLabel, drawLabel, LoseLabel]
    }()
    
    private lazy var scoreStackView: UIStackView = {
        
        let scoreStackView = UIStackView(arrangedSubviews: scoreLabels)
        scoreStackView.distribution = .equalSpacing
        
        return scoreStackView
    }()
    
    private lazy var viewModel: ViewModel = {
        
        let viewModel = ViewModel()
        viewModel.delegate = self
        
        return viewModel
    }()

    override func viewDidLoad() {
        
        view.addSubviews([titleLabel, playerChooseCollectionView, versusImageView, cpuChooseImageView, resultLabel, scoreStackView, dificultyStackView])
        
        super.viewDidLoad()
        
        view.backgroundColor = App.color
        
        titleLabel.constraint(to: view.safeAreaLayoutGuide, by: [.top:.top])
        titleLabel.align(to: view.safeAreaLayoutGuide)
        
        dificultyStackView.constraint(to: titleLabel, by: [.top:.top, .trailing:.trailing, .bottom:.bottom])
        
        playerChooseCollectionView.constraint(to: titleLabel, by: [.top: .bottom])
        playerChooseCollectionView.align(to: titleLabel)
        playerChooseCollectionView.height(by: 128)
        
        versusImageView.constraint(to: playerChooseCollectionView, by: [.top:.bottom])
        versusImageView.align(to: playerChooseCollectionView)
        versusImageView.height(by: 128)
        
        cpuChooseImageView.constraint(to: versusImageView, by: [.top:.bottom])
        cpuChooseImageView.align(to: versusImageView)
        cpuChooseImageView.height(by: 128)
        
        resultLabel.constraint(to: cpuChooseImageView, by: [.top:.bottom], constant: view.frame.size.height/16)
        resultLabel.align(to: cpuChooseImageView)
        
        scoreStackView.align(to: resultLabel, 20)
        scoreStackView.constraint(to: view.safeAreaLayoutGuide, by: [.bottom:.bottom])
    }
}

extension View: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.play(indexPath.row, 0...images.count-1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                      for: indexPath) as? Cell
        cell?.cellImageView.image = images[indexPath.row]
        
        return cell ?? UICollectionViewCell()
    }
}

extension View: ViewModelDelegate {
    
    func updateCpuChoose(_ cpuChoose: Int) {
        
        cpuChooseImageView.image = UIImage(named: "\(cpuChoose)")
    }
    
    func makeWinScreen(_ wins: Int) {
        
        resultLabel.text = "You Win!!"
        scoreLabels[0].text = "Wins: \(wins)"
    }
    
    func makeDrawScreen(_ draws: Int) {
        
        resultLabel.text = "Draw!"
        scoreLabels[1].text = "Draw: \(draws)"
    }
    
    func makeLoseScreen(_ loses: Int) {
        
        resultLabel.text = "You Lose.."
        scoreLabels[2].text = "Lose: \(loses)"
    }
}

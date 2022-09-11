//
//  ViewModel.swift
//  JokenpoApp
//
//  Created by Josicleison on 09/09/22.
//

import UIKit

protocol ViewModelDelegate {
    
    func updateCpuChoose(_ cpuChoose: Int)
    func makeWinScreen(_ wins: Int)
    func makeDrawScreen(_ draws: Int)
    func makeLoseScreen(_ loses: Int)
}

class ViewModel {
    
    private var wins = 0
    private var draws = 0
    private var loses = 0
    
    var delegate: ViewModelDelegate?
    
    func createButton(_ title: String) -> UIButton {
        
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.cyan, for: .selected)
        button.titleLabel?.font = App.tinyFont
        button.backgroundColor = App.color
        
        return button
    }
    
    func createLabel(_ text: String? = nil,
                     font: UIFont? = App.largeFont,
                     textColor: UIColor? = .white,
                     textAlignment: NSTextAlignment = .center) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        
        return label
    }
    
    func play(_ playerChose: Int,_ cpuChoseRange: ClosedRange<Int>) {
        
        let cpuChoose = Int.random(in: cpuChoseRange)
        
        delegate?.updateCpuChoose(cpuChoose)
        
        if playerChose == 0 && cpuChoose == 2 || playerChose == 0 && cpuChoose == 3 ||
           playerChose == 1 && cpuChoose == 0 || playerChose == 1 && cpuChoose == 4 ||
           playerChose == 2 && cpuChoose == 1 || playerChose == 2 && cpuChoose == 3 ||
           playerChose == 3 && cpuChoose == 1 || playerChose == 3 && cpuChoose == 4 ||
           playerChose == 4 && cpuChoose == 0 || playerChose == 4 && cpuChoose == 2 {
            
            wins += 1
            delegate?.makeWinScreen(wins)
        }
        else if playerChose == cpuChoose {
            
            draws += 1
            delegate?.makeDrawScreen(draws)
        }
        else {
            
            loses += 1
            delegate?.makeLoseScreen(loses)
        }
    }
}

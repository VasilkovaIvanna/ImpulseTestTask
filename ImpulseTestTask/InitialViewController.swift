//
//  ViewController.swift
//  ImpulseTestTask
//
//  Created by IvannaVasilkova on 19.08.2022.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        setStartButton()
    }

    func setStartButton(){
        let startButton = UIButton()
        startButton.layer.cornerRadius = 10
        startButton.setTitle("Start", for: .normal)
        startButton.backgroundColor = .accentColor
        startButton.titleLabel?.font = .interFontBold?.withSize(16)
        startButton.addTarget(self, action: #selector(tappedStartButton), for: .touchUpInside)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            self.view.centerXAnchor.constraint(equalTo: startButton.centerXAnchor),
            self.view.centerYAnchor.constraint(equalTo: startButton.centerYAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 244),
            startButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        
    }
    
    @objc func tappedStartButton(sender: UIButton!) {
        let nextController = PagesViewController()
        nextController.modalPresentationStyle = .fullScreen
        present(nextController, animated: true)
    }

}



//
//  PageViewController.swift
//  ImpulseTestTask
//
//  Created by IvannaVasilkova on 19.08.2022.
//

import UIKit

class SinglePageViewController: UIViewController { // As the screens 1,2,3 have the same logic, it was decided to create a ViewController with common methods and UI realisation for that screens to avoid the repeated code. However, if the logic/UI changes not globally, we can use this controller as a parent and inherit logic.
    
    
    private var contentView = UIView()
    private var imageView = UIImageView()
    
    private var headerLabel = UILabel()
    private var bodyLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        setContentView()
        setImageView()
        setDescription()
    }
    
    public func setImage(image: UIImage?) { // "public" in case of using modules in future
        imageView.image = image
    }
    
    public func setTexts(header: String, body: String) {
        headerLabel.text = header
        bodyLabel.text = body
    }
    
    private func setContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 103),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
        ])
    }
    
    private func setImageView() {
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setDescription() {
        headerLabel.numberOfLines = 0
        headerLabel.textColor = .white
        headerLabel.textAlignment = .center
        headerLabel.font = .interFontSemiBold?.withSize(20)
            
                
        bodyLabel.numberOfLines = 0
        bodyLabel.textColor = .white
        bodyLabel.textAlignment = .center
        bodyLabel.font = .interFontRegular?.withSize(16)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headerLabel)
        contentView.addSubview(bodyLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            bodyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 12),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

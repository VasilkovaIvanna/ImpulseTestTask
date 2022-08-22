//
//  PagesViewController.swift
//  ImpulseTestTask
//
//  Created by IvannaVasilkova on 21.08.2022.
//

import UIKit

class PagesViewController : UIViewController {
    
    struct PageContent {
        let image: UIImage?
        let header: String
        let body: String
    }

    private var nextButton = UIButton()
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()
    private let timerViewController = TimerViewController()
    
    private var pagesControllers : [UIViewController] = []
    
    private let data: [PageContent] = [
        .init(image: UIImage(named: "RocketGirl"), header: "Boost Productivity", body: "Take your productivity to the next level"),
        .init(image: UIImage(named: "LaptopBoy"), header: "Work Seamlessly", body: "Get your work done seamlessly without interruption"),
        .init(image: UIImage(named: "PhoneGirl"), header: "Achieve Your Goals", body: "Boosted productivity will help you achieve the desired goals")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        setScrollView()
        setStackView()
        setButton()
        setContent()
        setControl()
    }
    
    private func setContent() {
        for content in data {
            let page = SinglePageViewController()
            page.setImage(image: content.image)
            page.setTexts(header: content.header, body: content.body)
            
            pagesControllers.append(page)
            addChild(page)
            
            stackView.addArrangedSubview(page.view)
            page.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                page.view.topAnchor.constraint(equalTo: stackView.topAnchor),
                page.view.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
                page.view.widthAnchor.constraint(equalTo: view.widthAnchor)])
        }
    }
    
    private func setStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    private func setScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120)
        ])
    }
   
    private func setControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = pagesControllers.count
        pageControl.addTarget(self, action: #selector(onPageControl), for: .valueChanged)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.leftAnchor.constraint(equalTo: view.leftAnchor),
            pageControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -28),
            pageControl.heightAnchor.constraint(equalToConstant: 8)
        ])
    }
    
    private func setButton(){
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = .accentColor
        nextButton.titleLabel?.font = .interFontBold?.withSize(16)
        nextButton.layer.cornerRadius = 10
        nextButton.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    private func isLastPage() -> Bool {
        return pageControl.currentPage == pageControl.numberOfPages - 1
    }
    
    @objc func onPageControl(_ sender: UIPageControl) {
        scrollView.scrollRectToVisible(pagesControllers[pageControl.currentPage].view.frame, animated: true)
    }
    
    @objc func tappedNextButton(sender: UIButton!) {
        guard isLastPage() else {
            pageControl.currentPage += 1
            onPageControl(pageControl)
            return
        }
        
        // Having "didPresentScreen == true" in our db means, that our timer was already shown.
        if TimerScreenStateCoreDataProvider.shared.fetch()?.didPresentScreen == true {
            let alert = UIAlertController(title: "Thank you for your interest",
                                          message: "The functionality is under development",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default))
            alert.overrideUserInterfaceStyle = .dark
            self.present(alert, animated: true)

        } else {
            self.present(timerViewController, animated: true)
        }
    }
}

extension PagesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) { // using this method to get the current page
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        nextButton.setTitle(isLastPage() ? "Continue" : "Next", for: .normal)
    }
}























































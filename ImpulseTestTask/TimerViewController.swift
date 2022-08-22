//
//  FirstPageViewController.swift
//  ImpulseTestTask
//
//  Created by IvannaVasilkova on 19.08.2022.
//

import UIKit

class TimerViewController: UIViewController {  // ViewController for representing timer
    
    private var timer = Timer()
    private var time : Int = 60
    private var timeDuration: Int = 60 // initial time
    private var contentView = UIView()
    private var counterLabel = UILabel()
    private var continueButton = UIButton()
    private var progressView = UIProgressView(progressViewStyle: .bar)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setContentView()
        setCounterLabel()
        setProgressView()
        setContinueButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        runTimer() // on appearing of view we launch the timer
        TimerScreenStateService.shared.onDidPresentTimerScreen() // change special variable which shows whether timer was shown.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate() // stop the timer whether view is going to disappear
    }
    
    private func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimerUpdate), userInfo: nil, repeats: true)
    }
    
    private func formatTime() -> String? {
        guard time >= 0 else { return "00:00" }
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(time))
    }
    
    @objc func onTimerUpdate() {
        time -= 1
        counterLabel.text = formatTime()
        
        if time < 0 {
            timer.invalidate()
            progressView.progress = 1.0
            updateContinueButton(isEnabled: true)
            
        } else {
            self.progressView.setProgress((60 - Float(time) + 1) / 60, animated: false)
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: { [weak self] in
                self?.progressView.layoutIfNeeded()
            }) // animation for making progress smoother
        }
    }
    
    @objc func tappedContinueButton(sender: UIButton!){
        TimerScreenStateCoreDataProvider.shared.save(didPresentScreen: true) // if the time is up, we save  "didPresentScreen = true" to the CoreData.
        self.dismiss(animated: true)
    }
    
    private func updateContinueButton(isEnabled : Bool = false) {
        continueButton.isEnabled = isEnabled
        continueButton.layer.opacity = isEnabled ? 1 : 0.6
    }
    
    private func setContentView() {
        contentView.backgroundColor = .backgroundSecondary
        contentView.layer.cornerRadius = 28
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setCounterLabel(){
        counterLabel.textColor = .white
        counterLabel.textAlignment = .center
        counterLabel.text = formatTime()
        counterLabel.font = .interFontSemiBold?.withSize(68)
        
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(counterLabel)
        
        NSLayoutConstraint.activate([
            counterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -68),
            counterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            counterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28),
        ])
    }
    
    private func setProgressView(){
        progressView.progress = 0.0
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 4
        progressView.progressTintColor = .accentColor
        progressView.backgroundColor = .white.withAlphaComponent(0.24)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 32),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28),
            progressView.heightAnchor.constraint(equalToConstant: 8)
        ])
    }

    private func setContinueButton(){
        continueButton.setTitle("Continue", for: .normal)
        continueButton.backgroundColor = .accentColor
        continueButton.titleLabel?.font = .interFontBold?.withSize(16)
        continueButton.layer.cornerRadius = 10
        updateContinueButton(isEnabled: false)
        
        continueButton.addTarget(self, action: #selector(tappedContinueButton), for: .touchUpInside)

        continueButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            continueButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            continueButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
 }

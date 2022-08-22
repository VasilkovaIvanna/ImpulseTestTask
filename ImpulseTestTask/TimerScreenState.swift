//
//  TimerScreenState.swift
//  ImpulseTestTask
//
//  Created by IvannaVasilkova on 21.08.2022.
//

import Foundation

public class TimerScreenStateService { // this service is created to managed whether a time in timer was up to satisfy next requirment: To show timer until the time will not completely expire (even if the app was reloaded). 
    public static var shared = TimerScreenStateService()
    
    private init () {}
    
    private(set) var didPresentTimerScreen = false
    
    public func onDidPresentTimerScreen(){
        self.didPresentTimerScreen = true
    }
}

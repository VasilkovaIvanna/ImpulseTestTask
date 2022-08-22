//
//  TimerScreenStateCoreDataProvider.swift
//  ImpulseTestTask
//
//  Created by IvannaVasilkova on 21.08.2022.
//

import Foundation
import CoreData

class TimerScreenStateCoreDataProvider { // service for managing, saving and fetching data from TimerScreenState entity
    
    public static var shared = TimerScreenStateCoreDataProvider()
    
    private init () {}
    
    public weak var managedContext: NSManagedObjectContext!
    
    private func createNew() -> TimerScreenState {
        let entity = NSEntityDescription.entity(forEntityName: "TimerScreenState", in: managedContext)!
        return TimerScreenState(entity: entity, insertInto: managedContext)
    }
    
    public func save(didPresentScreen: Bool) {
        let timerScreenState = fetch() ?? createNew()
        timerScreenState.setValue(didPresentScreen, forKeyPath: "didPresentScreen")

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save TimerScreenState entity. \(error), \(error.userInfo)")
        }
    }
    
    public func fetch() -> TimerScreenState? {
        let fetchRequest = NSFetchRequest<TimerScreenState>(entityName: "TimerScreenState")
        do {
            return try managedContext.fetch(fetchRequest).last
        } catch let error as NSError {
          print("Could not fetch TimerScreenState entity. \(error), \(error.userInfo)")
          return nil
        }
    }
}

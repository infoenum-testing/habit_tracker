//
//  InitialDataLoader.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 08/09/25.
//

import Foundation

final class InitialDataLoader {
    static let shared = InitialDataLoader()
    private init() {}
    
    func loadInitialData() {
        guard let url = Bundle.main.url(forResource: "initialData", withExtension: "json") else {
            print("initialData.json not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            if let jsonDict = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                CoreDataManager.shared.saveDataFromJSON(jsonDict)
                UserDefaults.standard.set(true, forKey: "isInitialDataSaved")
            }
        } catch {
            print("Failed to load or parse initialData.json: \(error)")
        }
    }
    
    func loadSubscribedArcHistoryData() {
        guard let url = Bundle.main.url(forResource: "subscribed_arc_history", withExtension: "json") else {
            print("subscribed_arc_history.json not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            if let jsonDict = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                // CoreDataManager.shared.saveSubscribedArcHistoryFromJSON(jsonDict)
            }
        } catch {
            print("Failed to load or parse subscribed_arc_history.json: \(error)")
        }
    }
}

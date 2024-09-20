//
//  APIKEY.swift
//  Gemini
//
//  Created by Sagar Jangra on 18/08/2024.
//

import Foundation

enum APIKEY {
    // Fetch the API key from 'GenerativeAI-Info.plist'
    static var `default`: String {
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'GenerativeAI-Info.plist'.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else{
            fatalError("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
        }
        
        if value.starts(with: "_") {
            fatalError("Follow instructions at https://ai.google.dev/tutorials/setup to get an API key.")
        }
        return value
    }
}

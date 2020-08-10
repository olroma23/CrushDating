//
//  Bundle-Decodable .swift
//  Love Dating
//
//  Created by Roman Oliinyk on 29.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

extension Bundle {
    
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("failed to decode \(file) from bundle")
        }
        
        return loaded
    }
}

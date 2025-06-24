//
//  Item.swift
//  habits
//
//  Created by Maisie Bell on 24/06/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

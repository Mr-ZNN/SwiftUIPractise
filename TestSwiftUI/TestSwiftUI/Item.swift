//
//  Item.swift
//  TestSwiftUI
//
//  Created by Neil on 21/5/25.
//

import SwiftData
import Foundation

@Model
class Item {
    var title: String
    var timestamp: Date
    var category: String?

    init(title: String, timestamp: Date, category: String? = nil) {
        self.title = title
        self.timestamp = timestamp
        self.category = category
    }
}

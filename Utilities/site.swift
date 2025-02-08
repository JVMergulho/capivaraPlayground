//
//  site.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 05/02/25.
//

import SwiftUI

// Archeology Site

struct Site: Hashable, Identifiable{
    
    var id = UUID()
    
    let name: String
    let painting: String
    let location: CGPoint
}

let Sites: [Site] = [
    Site(name: "Toca do Vento", painting: "painting1", location: CGPoint(x: 0.13, y: 0.41)),
    Site(name: "Pedra Furada", painting: "painting1", location: CGPoint(x: 0.42, y: 0.68)),
    Site(name: "Toca do Paraguaio", painting: "painting2", location: CGPoint(x: 0.71, y: 0.64))
]

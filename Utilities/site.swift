//
//  site.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 05/02/25.
//

import SwiftUI

// Archeology Site
enum Site: CaseIterable, Identifiable{
    case extrema
    case furada
    case paraguaio
    
    var id: Self { self }
    
    var name: String {
        switch self {
        case .extrema:
            return "Toca da Extrema II"
        case .furada:
            return "Pedra Furada"
        case .paraguaio:
            return "Toca do Paraguaio"
        }
    }
    
    var painting: String {
        switch self {
        case .extrema:
            return "painting1"
        case .furada:
            return "painting1"
        case .paraguaio:
            return "painting2"
        }
    }
    
    var location: CGPoint {
        switch self {
        case .extrema:
            return CGPoint(x: 0.13, y: 0.41)
        case .furada:
            return CGPoint(x: 0.42, y: 0.68)
        case .paraguaio:
            return CGPoint(x: 0.71, y: 0.64)
        }
    }
}

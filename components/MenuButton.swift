//
//  MenuButton.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 07/02/25.
//

import SwiftUI

struct MenuButton: View {
    let title: String
    let buttonAction: () -> ()
    
    var body: some View {
        Button(action:{
            buttonAction()
        }){
            Text(title)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.white)
                .frame(width: 180, height: 60)
                .background(Color.redTitle)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

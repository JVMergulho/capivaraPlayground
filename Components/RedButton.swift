//
//  MenuButton.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 07/02/25.
//

import SwiftUI

struct RedButton: View {
    let title: String
    let disabled: Bool
    let buttonAction: () -> ()
    
    init(title: String, disabled: Bool = false, buttonAction: @escaping () -> Void) {
        self.title = title
        self.disabled = disabled
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        Button(action:{
            buttonAction()
        }){
            Text(title)
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(.white)
                .frame(width: 280, height: 60)
                .background(disabled ? Color.redDisabled : Color.redTitle)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .disabled(disabled)
    }
}

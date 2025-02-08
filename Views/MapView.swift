//
//  MapView.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 07/02/25.
//

import SwiftUI

struct MapView: View {
    
    @Binding var selectedSite: Site?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    
                    Image(.mapCapivara)
                        .resizable()
                        .scaledToFit()
                    
                    ForEach(Sites) { site in
                        Button(action: {
                            selectedSite = site
                        }, label: {
                            VStack {
                                Image(.mapPin)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .foregroundColor(.red)
                                
                                Text(site.name)
                                    .font(.caption)
                                    .foregroundStyle(.black)
                                    .padding(5)
                                    .background(Color.white.opacity(0.6))
                                    .cornerRadius(10)
                            }
                        })
                        .position(
                            x: site.location.x * geometry.size.width,
                            y: site.location.y * geometry.size.height
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    MapView(selectedSite: .constant(Sites[0]))
}

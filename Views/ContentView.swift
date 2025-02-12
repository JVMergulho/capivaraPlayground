//
//  ContentView.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 04/02/25.
//

import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            
            MenuView(path: $path)
                .navigationDestination(for: Page.self){ page in
                    
                    switch page{
                        case .map:
                            ParkView(path: $path)
                        case .arSite(let site):
                            ARSiteView(selectedSite: site)
                        case .credits:
                            Text("João Mergulhão")
                        case .menu:
                            MenuView(path: $path)
                        case .timeline:
                            TimelineView()
                        case .intro:
                            IntroView(path: $path)
                        case .warning(let site):
                            WarningView(path: $path, selectedSite: site)
                    }
                }
        }
    }
}

#Preview{
    if #available(iOS 17.0, *) {
        ContentView()
    } else {
        // Fallback on earlier versions
    }
}

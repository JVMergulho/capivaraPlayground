//
//  Events.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 21/02/25.
//
import SwiftUI

struct TimelineEvent: Identifiable {
    let id = UUID()
    let year: String
    let title: String
    let description: String
}

let timeEvents: [TimelineEvent] = [
    TimelineEvent(year: "300,000 B.P.", title: "Emergence of Homo Sapiens in Africa", description: "The origins of our species trace back to Africa. The oldest known Homo sapiens skull was discovered in Morocco and dates back approximately 300,000 years."),
    
    TimelineEvent(year: "50,000 B.P.", title: "Human Presence in Serra da Capivara", description: "Archeological artifacts suggest human occupation in the region far earlier than previously thought for the Americas. This has raised the theory that humans arrived via sea routes from Africa."),
    
    TimelineEvent(year: "13,000 B.P.", title: "Clovis Culture in North America", description: "The Clovis people spread across the continent. In the 20th century, the dominant theory suggested they were the first inhabitants of the Americas, arriving from Russia via the Bering Strait."),
    
    TimelineEvent(year: "1973", title: "Niède Guidon's First Discoveries", description: "Archaeologist Niède Guidon begins research in Serra da Capivara. The first recorded site was Toca do Paraguaio."),
    
    TimelineEvent(year: "1979", title: "National Park foundation", description: "Serra da Capivara National Park was established to protect the historical and natural heritage of the region."),
    
    TimelineEvent(year: "1991", title: "UNESCO World Heritage Status", description: "Serra da Capivara was designated a UNESCO World Heritage Site for its historical and cultural significance."),
    
    TimelineEvent(year: "2020+", title: " Ongoing Research", description: "Studies continue to explore the origins of the first inhabitants of the Americas, reassessing traditional theories.")
]

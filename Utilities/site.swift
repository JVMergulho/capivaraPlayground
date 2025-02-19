//
//  site.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 05/02/25.
//

import SwiftUI

struct Site: Hashable, Identifiable {
    var id = UUID()
    let name: String
    let painting: String
    let location: CGPoint
    let siteAbout: String
    let paintingAbout: String
    let infoBoard: String
}

let Sites: [Site] = [
    Site(
        name: "Toca do Vento",
        painting: "painting3",
        location: CGPoint(x: 0.13, y: 0.41),
        siteAbout: "Toca do Paraguaio, in Serra da Capivara, is a rock shelter 420 meters above sea level and contains over 900 cave paintings, as well as other archaeological remains, such as ceramic fragments. It was the first site studied by Niède Guidon's team in the Area where the current park is located, where two skeletons with distinct features were found, dating back to 7 to 8 thousand years ago, suggesting multiple migrations to the Americas. The site is crucial for understanding prehistoric human occupation.",
        paintingAbout: "A notable rock painting in Brazil's Serra da Capivara National Park depicts two capybaras, a mother and her offspring, symbolizing the park due to the historical presence of these animals in the region. Above them, two human figures are shown alongside another animal, possibly illustrating prehistoric daily life activities such as hunting or rituals, highlighting interactions between early inhabitants and local fauna.",
        infoBoard: "infoPedraFurada"
    ),
    
    Site(
        name: "Pedra Furada",
        painting: "painting1",
        location: CGPoint(x: 0.42, y: 0.68),
        siteAbout: "The Toca do Boqueirão da Pedra Furada is one of the most important archaeological sites in the Serra da Capivara, Brazil. Recognized worldwide for its cave paintings and archaeological remains, the site has been a key point in studies on the human presence in the Americas. Excavations carried out at the site have revealed traces of fire pits and chipped stone artifacts dating back up to 50,000 years, challenging traditional theories about the arrival of the first inhabitants to the continent.",
        paintingAbout: "A notable rock painting in Brazil's Serra da Capivara National Park depicts two capybaras, a mother and her offspring, symbolizing the park due to the historical presence of these animals in the region. Above them, two human figures are shown alongside another animal, possibly illustrating prehistoric daily life activities such as hunting or rituals, highlighting interactions between early inhabitants and local fauna. ",
        infoBoard: "infoPedraFurada"
    ),
    
    Site(
        name: "Toca do Paraguaio",
        painting: "painting2",
        location: CGPoint(x: 0.71, y: 0.64),
        siteAbout: "Toca do Paraguaio is a rock shelter 420 meters above sea level and contains over 900 cave paintings, as well as other archaeological remains, such as ceramic fragments. It was the first site studied by Niède Guidon's where they found two skeletons with distinct features, dating back to 7 to 8 thousand years ago, suggesting multiple migrations to the Americas. The site is crucial for understanding prehistoric human occupation in the continent.",
        paintingAbout: "The cave paintings of Toca do Paraguai has a strongly narrative character, featuring motifs that depict everyday scenes and hybrid figures, resulting from the fusion of different themes. A striking example is this painting, which combines characteristic features of deer and rheas. It is theorized that these figures represent characters from the mythical-religious universe of their creators.",
        infoBoard: "infoParaguaio"
    )
]

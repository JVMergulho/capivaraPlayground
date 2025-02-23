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
        siteAbout: "The Toca do Vento is part of the Serra Branca Circuit, a group of archaeological sites located in the northwest of the Serra da Capivara National Park. Discovered by researchers in 1973, the shelter was being used by a family who lived there while collecting latex from the maniçoba plant, a common practice in the region.",
        paintingAbout: "The painting features a line of capybaras drawn in the Serra Branca style. This style is characteristic of the Serra da Capivara and stands out for its complexity and beauty. It is marked by clear lines and geometric patterns, which can represent human figures, animals and abstract symbols, reflecting a rich connection with nature and everyday life.",
        infoBoard: "infoVento"
    ),
    
    Site(
        name: "Pedra Furada",
        painting: "painting1",
        location: CGPoint(x: 0.42, y: 0.8),
        siteAbout: "The Toca do Boqueirão da Pedra Furada is one of the most important archaeological sites in the Serra da Capivara. Recognized worldwide for its cave paintings and archaeological remains, the site has been a key point in studies on the human presence in the Americas. Excavations carried out at the site have revealed traces of fire pits and chipped stone artifacts dating back up to 50,000 years, challenging traditional theories about the arrival of the first inhabitants to the continent.",
        paintingAbout: "A notable rock painting in Brazil's Serra da Capivara National Park depicts two capybaras, a mother and her offspring, symbolizing the park due to the historical presence of these animals in the region. Above them, two human figures are shown alongside another animal, possibly illustrating prehistoric daily life activities such as hunting or rituals, highlighting interactions between early inhabitants and local fauna. ",
        infoBoard: "infoPedraFurada"
    ),
    
    Site(
        name: "Toca do Paraguaio",
        painting: "painting2",
        location: CGPoint(x: 0.71, y: 0.74),
        siteAbout: "The Toca do Paraguaio is a rock shelter 420 meters above sea level and contains over 900 cave paintings, as well as other archaeological remains, such as ceramic fragments. It was the first site studied by Niède Guidon where she found two skeletons with distinct features, dating back to 9 to 10 thousand years ago, suggesting multiple migrations to the Americas. The site is crucial for understanding prehistoric human occupation in the continent.",
        paintingAbout: "The cave paintings of Toca do Paraguai has a strongly narrative character, featuring motifs that depict everyday scenes and hybrid figures, resulting from the fusion of different themes. A striking example is this painting, which combines characteristic features of deer and rheas. It is theorized that these figures represent characters from the mythical-religious universe of their creators.",
        infoBoard: "infoParaguaio"
    )
]

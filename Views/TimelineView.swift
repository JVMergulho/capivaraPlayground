import SwiftUI

struct TimelineEvent: Identifiable {
    let id = UUID()
    let year: String
    let title: String
    let description: String
}

struct TimelineView: View {
    let events: [TimelineEvent] = [
        TimelineEvent(year: "50.000 a.C.", title: "Vestígios Humanos na Serra da Capivara", description: "Evidências de ocupação humana, como ferramentas de pedra e fogueiras, indicam presença humana muito antes do que se pensava."),
        TimelineEvent(year: "13.000 a.C.", title: "Cultura Clóvis na América do Norte", description: "Povos Clóvis, antes considerados os primeiros habitantes das Américas, se espalham pelo continente."),
        TimelineEvent(year: "1970", title: "Descobertas por Niède Guidon", description: "A arqueóloga Niède Guidon encontra indícios de presença humana na Serra da Capivara com até 50.000 anos."),
        TimelineEvent(year: "1991", title: "Patrimônio Mundial da UNESCO", description: "A Serra da Capivara é reconhecida como Patrimônio Cultural da Humanidade."),
        TimelineEvent(year: "2020+", title: "Novas Pesquisas", description: "Estudos continuam analisando as origens dos primeiros habitantes da América, reavaliando teorias tradicionais.")
    ]
    
    var body: some View {
        
        ZStack{
            Color.mapBg
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack{
                    ParkBoardView(title: "Timeline")
                    
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(events) { event in
                            HStack{
                                Circle()
                                    .frame()
                                
                                VStack(alignment: .leading) {
                                    Text(event.year)
                                        .bold()
                                        .foregroundColor(.redTitle)
                                        .frame(width: 100, alignment: .leading)
                                    VStack(alignment: .leading) {
                                        Text(event.title)
                                            .font(.headline)
                                            .foregroundColor(.redTitle)
                                        
                                        Text(event.description)
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                            .padding(.top, 8)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    .padding()
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}

import SwiftUI

struct TimelineView: View {
    
    var body: some View {
        
        ZStack{
            Color.mapBg
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack{
                    ParkBoardView(title: "Timeline")
                    
                    VStack(alignment: .leading) {
                        ForEach(0..<events.count) { index in
                            ZStack(alignment: .leading){
                                
                                if (index < events.count - 1){
                                    HStack{
                                        Rectangle()
                                        .frame(width: 4, height: 180)
                                        .foregroundColor(.redTitle)
                                        
                                        Spacer()
                                    }
                                    .padding(.top, 80)
                                    .padding(.leading, 7)
                                }
                                
                                VStack(alignment: .leading){
                                    HStack{
                                        Circle()
                                            .frame(width: 18)
                                            .foregroundStyle(Color.redTitle)
                                        
                                        VStack(alignment: .leading) {
                                            Text(events[index].year)
                                                .bold()
                                                .foregroundColor(.redTitle)
                                                .frame(alignment: .leading)
                                            
                                            Text(events[index].title)
                                                .font(.headline)
                                                .foregroundColor(.redTitle)
                                        }
                                    }
                                    
                                    Text(events[index].description)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                        .padding(.top, 8)
                                        .padding(.leading, 20)
                                }
                            }
                            .frame(height: 160)
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

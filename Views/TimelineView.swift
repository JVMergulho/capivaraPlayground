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
                        ForEach(0..<timeEvents.count) { index in
                            ZStack(alignment: .leading){
                                
                                if (index < timeEvents.count - 1){
                                    HStack{
                                        Rectangle()
                                        .frame(width: 4, height: 190)
                                        .foregroundColor(.redTitle)
                                        
                                        Spacer()
                                    }
                                    .padding(.top, 80)
                                    .padding(.leading, 8)
                                }
                                
                                VStack(alignment: .leading){
                                    HStack{
                                        Circle()
                                            .frame(width: 20)
                                            .foregroundStyle(Color.redTitle)
                                        
                                        VStack(alignment: .leading) {
                                            Text(timeEvents[index].year)
                                                .bold()
                                                .foregroundColor(.redTitle)
                                                .frame(alignment: .leading)
                                            
                                            Text(timeEvents[index].title)
                                                .foregroundColor(.redTitle)
                                        }
                                        .padding(.leading, 10)
                                    }
                                    .font(.system(size: 22))
                                    
                                    Text(timeEvents[index].description)
                                        .foregroundColor(.black)
                                        .padding(.top, 8)
                                        .padding(.leading, 38)
                                }
                                .font(.system(size: 20))
                            }
                            .frame(height: 160)
                        }
                    }
                    .padding(.top, 44)
                    .padding(.horizontal, 80)
                }
            }
            .scrollIndicators(.hidden)
        }
        .foregroundStyle(Color.black)
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}

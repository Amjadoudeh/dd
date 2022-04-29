import SwiftUI

struct TabBar: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @State var hoverColor: Color = .teal
    @State var tabItemWidth: CGFloat = 0
    
    var body: some View {
        HStack {
            buttons
        }
        .padding(.horizontal, 8)
        .padding(.top, 14)
        .frame(height: 88 , alignment: .top)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 34 ,style: .continuous))
        /// using the background to creat a circle and make the hover effect by moving it
        .background(
            background
        )
        /// drawing the line above the circle
        .overlay(
            overlay
        )
        .strokeStyle(cornerRadius: 34)
        .frame(maxHeight: .infinity , alignment: .bottom)
        .ignoresSafeArea()
    }
    
    var buttons: some View {
        ForEach(tabItems) { item in
            Button {
                withAnimation {
                    selectedTab = item.tab
                    hoverColor = item.color
                }
                
            } label: {
                VStack(spacing: 0) {
                    Image(systemName: item.icon)
                        .symbolVariant(.fill)
                        .font(.body.bold())
                        .frame(width: 44 , height: 30)
                    Text(item.text)
                        .font(.caption2)
                        .lineLimit(1)
                }
                // just to fix the size of each
                .frame(maxWidth: .infinity)
            }
            .foregroundStyle(selectedTab == item.tab ? .primary : .secondary)
            .blendMode(selectedTab == item.tab ? .overlay : .normal)
/// using the GeometryReader & PreferenceKey  to position the overlay on landspace view
            .overlay(
                GeometryReader{ proxy in
//                    Text("\(proxy.size.width)")
                    Color.clear.preference(key: TabPreferenceKey.self , value: proxy.size.width)
                }
            )
            .onPreferenceChange(TabPreferenceKey.self) {
                value in
                tabItemWidth = value
            }
        }
    }
    
    var background: some View {
        HStack {
            if selectedTab == .library { Spacer() }
            if selectedTab == .explore { Spacer() }
            if selectedTab == .notifications {
                Spacer()
                Spacer()
            }
            Circle().fill(hoverColor).frame(width: tabItemWidth)
            if selectedTab == .home { Spacer() }
            if selectedTab == .explore {
                Spacer()
                Spacer()
            }
            if selectedTab == .notifications { Spacer() }
        }
        .padding(.horizontal, 8)
    }
    
    var overlay: some View {
        HStack {
            if selectedTab == .library { Spacer() }
            if selectedTab == .explore { Spacer() }
            if selectedTab == .notifications {
                Spacer()
                Spacer()
            }
            Rectangle()
                .fill(hoverColor)
                .frame(width: 29, height: 5)
                .cornerRadius(30)
                .frame(width: tabItemWidth)
                .frame(maxHeight: .infinity, alignment: .top)
            if selectedTab == .home { Spacer() }
            if selectedTab == .explore {
                Spacer()
                Spacer()
            }
            if selectedTab == .notifications { Spacer() }
        }
        .padding(.horizontal, 8)
    }
}


struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .preferredColorScheme(.light)
.previewInterfaceOrientation(.portrait)
        TabBar()
            .preferredColorScheme(.dark)
    }
}

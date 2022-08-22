import SwiftUI

struct ExploreView: View {
    @State var hasScrolled: Bool = false
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView {
                scrollDetection
                coursesSection
                
                Text("Topics".uppercased())
                    .titleStyle()
                topicsSection
                
                Text("popular".uppercased())
                    .titleStyle()
                
                handbooksSection
            }
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .overlay(NavigationBar(title: "Recent", hasScrolled: $hasScrolled))
            .background(Image("Blob 1").offset(x: -100, y: -350))
        }
    }
    var coursesSection: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack (spacing: 16){
                ForEach(courses) { course in
                    SmallCourseItem(course: course)
                }
            }
            .padding(.horizontal, 20)
            Spacer()
            
        }
    }
    
    var handbooksSection: some View {
        HStack(alignment: .top, spacing: 16) {
            ForEach(handbooks) { handbook in
                HandbookItem(handbook: handbook)
            }
        }
        .padding(.horizontal, 20)
    }
    
    var topicsSection: some View {
        VStack {
            ForEach(topics) { topic in
                TopicListRow(topic: topic)
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
    
    var scrollDetection: some View {
        /// to target the position of the scrollView(starting form after the navBar) I had to use named( ) with coordinateSpace(name: "scroll"), since global targets the full screen and local targets a fram moves with it
        GeometryReader { proxy in
            // Text("\(proxy.frame(in: .named("scroll")).minY)")
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0) /// adding a frame to get rid of the default hight of the Geometry
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeInOut) {
                if value < 0 {
                    hasScrolled = false
                } else {
                    hasScrolled = true
                }
            }
        })
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}

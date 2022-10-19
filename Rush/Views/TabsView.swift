//
//  TabsView.swift
//  Rush
//
//  Created by Michael Gillund on 10/11/22.
//

import SwiftUI

struct TabsView: View {
    
    @Binding var index: Int
    var tabs: [Tabs]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack {
                    ForEach(0 ..< tabs.count, id: \.self) { row in
                        Button(action: {
                            withAnimation {
                                index = row
                            }
                        }, label: {
                            if tabs[row].title == Date().formatDates() {
                                Text("Today")
                                    .font(.system(size: 16, weight: .bold))
                            }else{
                                Text(tabs[row].title)
                                    .scaledToFill()
                                    .font(.system(size: 16, weight: .bold))
                                    .frame(width: 50)
                            }
                        })
                        .tint(index == row ? Color.blue : Color.gray)
                        .controlSize(index == row ? ControlSize.large : ControlSize.regular)
                    }
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.automatic)
                .onAppear{
                    proxy.scrollTo(index, anchor: .top)
                }
                .onChange(of: index) { target in
                    withAnimation {
                        proxy.scrollTo(target,anchor: .top)
                    }
                }
            }
        }
    }
}

//struct TabsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabsView()
//    }
//}

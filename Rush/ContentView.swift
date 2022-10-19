//
//  ContentView.swift
//  Rush
//
//  Created by Michael Gillund on 10/4/22.
//

import SwiftUI

struct ContentView: View {

    @State
    private var today: Int = Dates.today
    
    @State
    var tabs: [Tabs] = Dates.tabs
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack{
                Image(colorScheme == .dark ? "Rush Light" : "Rush Dark")
                    .resizable()
                    .frame(width: 34, height: 34)
                Text("Rush")
                    .font(.system(size: 34, weight: .bold))
                Spacer()
            }
            .padding(.top, 60)
            .padding(.horizontal)

//            UIPageViewController Method
            
            TabsView(index: $today, tabs: tabs)
            PageView(pages: Dates.global.map {
                HomeView(date: $0.value)
                    .environmentObject(ViewModel())
            }, currentPage: $today)
            .ignoresSafeArea()
            .background(Color.systemGroupedBackground)

//            TabView Method

//            TabView(selection: $today){
//                ForEach(Dates.global){ index in
//                    HomeView(date: index.value)
//                        .environmentObject(ViewModel())
//                        .tag(index.tag)
//                }
//            }
//            .ignoresSafeArea()
//            .tabViewStyle(.page)
//            .indexViewStyle(.page(backgroundDisplayMode: .never))
        }
        .background(Color.systemGroupedBackground)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

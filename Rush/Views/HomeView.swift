//
//  HomeView.swift
//  Rush
//
//  Created by Michael Gillund on 10/11/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject
    private var model: ViewModel
    
    let date: Date
    
    var body: some View {
        List {
            ForEach(model.sections) { section in
                Section(header: Text(section.title), content: {
                    ForEach(section.sports?.sorted(by: {$0.sorted < $1.sorted}) ?? []) { sport in
                        ScoresView(event: sport)
                    }
                })
            }
        }
        .refreshable {
            do {
                await self.model.fetch()
            }catch {
                print(error)
            }
        }
        .task {
            do {
                await self.model.fetch()
            }catch {
                print(error)
            }
        }
        .onAppear{
            self.model.date = date
        }
    }
}
    

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(date: Date())
            .environmentObject(ViewModel())
    }
}

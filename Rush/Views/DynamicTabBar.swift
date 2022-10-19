//
//  DynamicTabBar.swift
//  Rush
//
//  Created by Michael Gillund on 10/5/22.
//

import SwiftUI

struct DynamicTabBar: View {
    
    @Binding var expanded: Bool
    var date: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                HStack {
                    if expanded {
                        Image(systemName: "house.fill")
                            .foregroundColor(Color.systemBackground)
                            .padding(.horizontal)
                    }
                    Spacer()
                    Text(date)
                        .foregroundColor(Color.systemBackground)
                        .bold()
                    Spacer()
                    if expanded {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Color.systemBackground)
                            .padding(.horizontal)
                    }
                }
                .frame(maxWidth: expanded ? .infinity : 125, maxHeight: 50)
//                .frame(maxWidth: expanded ? .infinity : 125, maxHeight: expanded ? 125: 50)
                .background(Color.primary)
                .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 1.0)) {
                        expanded.toggle()
                    }
                }
            }
            .padding()
        }
    }
}

//struct DynamicTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        DynamicTabBar()
//    }
//}

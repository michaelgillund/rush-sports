//
//  HeaderView.swift
//  Rush
//
//  Created by Michael Gillund on 10/16/22.
//

import SwiftUI

struct HeaderView: View {
    
    let icon: String
    let title: String
    
    var body: some View {
        VStack{
            HStack(spacing: 2){
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .font(.system(size: 12, weight: .regular))
//                    .font(.system(size: 12, weight: .regular, width: .compressed))
                Text(title)
                    .foregroundColor(.gray)
                    .font(.system(size: 12, weight: .regular))
                Spacer()
            }
            .padding(.vertical)
            Divider()
        }
    }
}

//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView(title: "NFL").previewLayout(.sizeThatFits)
//    }
//}

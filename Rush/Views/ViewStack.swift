//
//  ViewStack.swift
//  Rush
//
//  Created by Michael Gillund on 10/16/22.
//

import SwiftUI

struct ViewStack<Content: View>: View {

        var content: Content
        
        init(@ViewBuilder content: @escaping ()->Content){
            self.content = content()
        }
    
        var body: some View {
            VStack{
                content
                    .padding(.horizontal)
                    .padding(.vertical)
            }
            .background(CustomCorner(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 10))
            .foregroundColor(Color.secondarySystemBackground)
 
        }
}
struct CustomCorner: Shape{
    
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

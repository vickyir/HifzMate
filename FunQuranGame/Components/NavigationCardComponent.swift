//
//  NavigationCardComponent.swift
//  FunQuranGame
//
//  Created by Vicky Irwanto on 16/03/24.
//

import SwiftUI

struct NavigationCardComponent: View {
    var firstIcon: String = ""
    var image: String = ""
    var text: String = ""
    var textSec: String = ""
    var textRight: String = ""
    var textColor: String = ""
    var secIcon: String = ""
    var textDesc: String = ""
    
    var body: some View {
        HStack {
            ZStack(alignment: .center) {
                if !image.isEmpty {
                    Image(image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.leading, 0)
                        .foregroundColor(textColor != "" ? .red : .black)
                    
                    Text(text)
                        .foregroundColor(textColor != "" ? .red : .black)
                        .font(.system(size: 12, weight: .semibold))
                } else {
                    Image(systemName: firstIcon)
                        .padding(.leading, 0)
                        .foregroundColor(textColor != "" ? .red : .black)
                        .font(.body)
                }
            }
            
            VStack(alignment: .leading) {
                Text(textSec)
                    .foregroundColor(textColor != "" ? .red : .black)
                    .font(.body)
                    .padding(.top, 10)
                
                Text(textDesc)
                    .foregroundColor(.gray)
                    .font(.body)
                    .padding(.bottom, 10)
            }
            
            Spacer()
            
            Text(textRight)
                .foregroundColor(.black)
                .padding(.trailing, 10)
                .font(.body)
            
            if (secIcon != "") {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(red: 0.78, green: 0.78, blue: 0.80))
                    .font(.footnote)
                    .fontWeight(.semibold)
            } else {
                EmptyView()
            }
        }
        .cornerRadius(12)
        .padding(.horizontal, 0)
        .background(Color.white)
    }
}


#Preview {
    NavigationCardComponent()
}

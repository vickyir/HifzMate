//
//  SectionHeaderComponent.swift
//  FunQuranGame
//
//  Created by Vicky Irwanto on 16/03/24.
//

import SwiftUI

struct SectionHeaderComponent: View {
    var sectionTitle: String = ""
    var sectionSubtitle: String = ""
    var acc: Bool = false
    
    var body: some View {
        Group {
            VStack(alignment: .leading){
                Text(sectionTitle)
                    .bold()
                    .font(.system(.title2))
                Text(sectionSubtitle)
                    .font(.system(.body))
                    .foregroundColor(Color.gray)
                    .padding(0)
            }
        }
        .padding(.horizontal, acc == false ? 15 : 0)
        .padding(.top, 0)
        .padding(.bottom, 10)
    }
}

#Preview {
    SectionHeaderComponent()
}

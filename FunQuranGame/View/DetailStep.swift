//
//  DetailStep.swift
//  FunQuranGame
//
//  Created by Vicky Irwanto on 16/03/24.
//

import SwiftUI

struct DetailStep: View {
    let ayatCount: Int
    let surahNumber: Int
    let selectedStepIndex: Int
    let steps: [Int]  // Add this line

    @StateObject private var quranViewModel = QuranViewModel()

    var body: some View {
        List {
            Section {
                Group {
                    Image("Banner-Bismillah") // Menambahkan gambar di bagian atas
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            
            let startIndex = selectedStepIndex == 0 ? 0 : steps[0..<selectedStepIndex].reduce(0, +)

            ForEach(startIndex..<(startIndex + ayatCount), id: \.self) { index in
                if let ayah = quranViewModel.detailSurah?.ayat[index] {
                    VStack(alignment: .leading) {
                        Text("\(ayah.ar)")
                        Text("\(ayah.idn)")
                    }
                }
            }
        }
        .navigationTitle("Detail Step")
        .task {
            await quranViewModel.didFetchDetailUser(with: surahNumber)
        }
    }
}

#Preview {
    DetailStep(ayatCount: 1, surahNumber: 1, selectedStepIndex: 1, steps: [1])
}

//
//  Surah.swift
//  FunQuranGame
//
//  Created by Vicky Irwanto on 16/03/24.
//

import SwiftUI

struct Surah: View {
    @StateObject var quranViewModel = QuranViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    Section {
                        Group {
                            ForEach(filteredSurahData, id: \.nomor) { surah in
                                if surah.nomor >= 78 {
                                    let tempatTurun = surah.tempat_turun == "mekah" ? "Makiyyah" : (surah.tempat_turun == "madinah" ? "Madaniyah" : surah.tempat_turun)
                                    NavigationLink(destination: DetailSurah(url: "\(surah.audio)", id: surah.nomor), label: {
                                        VStack {
                                            NavigationCardComponent(image: "NomorFrame",text: "\(surah.nomor)", textSec : surah.nama_latin, textRight : surah.nama, textDesc: "\(tempatTurun) • \(surah.jumlah_ayat) Ayat")
                                        }
                                        .onAppear {
                                            print(surah.nomor)
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Surah Index")
                .background(Color(uiColor: .systemGray6))
                .navigationBarTitleDisplayMode(.inline)
                .task {
                    await quranViewModel.didFetchSurahData()
                }
                .searchable(text: $searchText)

                if quranViewModel.isLoading {
                    Color.white.opacity(0.7)
                        .ignoresSafeArea()
                    ProgressView("Loading...")
                }
            }
        }
    }

    private var filteredSurahData: [ModelSurah] {
        if searchText.isEmpty {
            return quranViewModel.surahData.reversed()
        } else {
            return quranViewModel.surahData.filter { $0.nama_latin.lowercased().contains(searchText.lowercased()) }
        }
    }
}

#Preview {
    Surah()
}

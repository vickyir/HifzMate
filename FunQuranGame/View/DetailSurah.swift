//
//  DetailSurah.swift
//  FunQuranGame
//
//  Created by Vicky Irwanto on 16/03/24.
//

import SwiftUI
import AVFoundation
import AVFAudio

struct DetailSurah: View {
    var url: String
    var id: Int
    
    @State var song1 = false
    @StateObject private var soundManager = SoundManager()
    @StateObject private var quranViewModel = QuranViewModel()
    @State private var selectedStepIndex: Int? = nil
    
    var body: some View {
        VStack{
            ZStack
            {
                List {
                    Section {
                        Group {
                            Text(quranViewModel.detailSurah?.nama_latin ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text(quranViewModel.detailSurah?.arti ?? "")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .padding(.top, -10)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    
                    let ayatCount = quranViewModel.detailSurah?.jumlah_ayat ?? 0
                    let steps: [Int] = {
                        if ayatCount >= 40 {
                            return [10, 10, 10, ayatCount - 30]
                        } else if ayatCount >= 30 {
                            return [10, 10, ayatCount - 20]
                        } else if ayatCount >= 15 {
                            return [10, ayatCount - 10]
                        } else {
                            return [ayatCount]
                        }
                    }()
                    
                    ForEach(0..<steps.count, id: \.self) { index in
                        let startAyah = index == 0 ? 1 : steps[0..<index].reduce(1, +)
                        let endAyah = startAyah + steps[index] - 1
                        let rangeText = "Ayat \(startAyah) - \(endAyah)"
                        
                        Section {
                            NavigationLink(destination: DetailStep(ayatCount: steps[index], surahNumber: quranViewModel.detailSurah?.nomor ?? 0, selectedStepIndex: index, steps: steps)) {
                                NavigationCardComponent(textSec: "Step \(index + 1)", textDesc: "\(steps[index]) Ayat • \(rangeText)")
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    
                    
                    NavigationLink {
                        Quiz(indexSurah: id)
                    } label: {
                        Text("Take a Quiz")
                    }

                    
                }
                
                if quranViewModel.isLoading {
                    Color.white.opacity(0.7)
                        .ignoresSafeArea()
                    ProgressView("Loading...")
                }
            }
           
        }
        
        
        Image(systemName: song1 ? "pause.circle.fill": "play.circle.fill")
            .font(.system(size: 25))
            .padding(.trailing)
            .onTapGesture {
                soundManager.playSound(sound: "\(url)")
                song1.toggle()
                
                if song1 {
                    soundManager.audioPlayer?.play()
                } else {
                    soundManager.audioPlayer?.pause()
                }
            }
            .task {
                await quranViewModel.didFetchDetailUser(with: id)
            }
    }
}


#Preview {
    DetailSurah(url: "Nama Surah", id: 1)
}

class SoundManager : ObservableObject {
    var audioPlayer: AVPlayer?
    
    func playSound(sound: String){
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
        }
    }
}

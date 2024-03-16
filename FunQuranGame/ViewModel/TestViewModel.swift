//
//  TestViewModel.swift
//  FunQuranGame
//
//  Created by Vicky Irwanto on 16/03/24.
//

import Foundation
import Combine

class QuranViewModel:ObservableObject {
    @Published var surahData = [ModelSurah]()
    @Published var detailSurah: Detail?
    @Published var isLoading = true
    private var cancellabels = Set<AnyCancellable>()
    
    func didFetchSurahData() async{
        guard let url = URL(string:"https://equran.id/api/surat") else {return}
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [ModelSurah].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion:{ completion in
                switch completion{
                case .failure(let error):
                    print("Error data : \(error)")
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { surah in
                print(surah[0].nama_latin)
                self.surahData = surah
                
            })
            .store(in: &cancellabels)
      
    }
    
    func didFetchDetailUser(with id: Int) async{
        guard let url = URL(string: "https://equran.id/api/surat/\(id)") else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: Detail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion{
                case .failure(let error):
                    print("Error data : \(error)")
                case .finished:
                    self.isLoading = false
                }
                
            }, receiveValue: { surah in
                self.detailSurah = surah
            })
            .store(in: &cancellabels)
    }
}

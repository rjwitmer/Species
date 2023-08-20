//
//  SpeciesListView.swift
//  Species
//
//  Created by Bob Witmer on 2023-08-17.
//

import SwiftUI
import AVFAudio

struct SpeciesListView: View {
    @StateObject var speciesVM = SpeciesViewModel()
    @State private var searchText = ""
    @State private var audioPlayer: AVAudioPlayer!
    @State private var lastSound = -1
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(searchResults) {species in
                    LazyVStack {
                        NavigationLink(destination: DetailView(species: species)) {
                            Text(species.name.capitalized)
                                .font(.title)
                        }
                        
                    }
                    .onAppear() {
                        Task {
                            await speciesVM.loadNextIfNeeded(species: species)
                        }
                    }
                }
                .navigationTitle("Species")
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Load All") {
                            Task {
                                await speciesVM.loadAll()
                            }
                        }
                        .buttonStyle(.plain)
                        .bold()
                        .foregroundColor(.accentColor)
                    }
                    ToolbarItem(placement: .status) {
                        Text("\(speciesVM.speciesArray.count) of \(speciesVM.count)")
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            var nextSound: Int
                            repeat {
                                nextSound = Int.random(in: 0...8)
                            } while nextSound == lastSound
                            lastSound = nextSound
                            let soundName = String(nextSound)
                            
                            guard let soundFile = NSDataAsset(name: soundName) else {
                                print("😡 Could not read file named \(soundName).")
                                return
                            }
                            do {
                                audioPlayer = try AVAudioPlayer(data: soundFile.data)
                                audioPlayer.play()
                            } catch {
                                print("😡 ERROR: \(error.localizedDescription) creating audioPlayer.")
                            }
                            
                        } label: {
                            Image("peek")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 25)
                        }
                        
                    }
                }
                .searchable(text: $searchText)
                if speciesVM.isLoading {
                    ProgressView()
                        .tint(.green)
                        .scaleEffect(4)
                }
            }
            
        }
        .task {
            await speciesVM.getData()
        }
    }
    
    var searchResults: [Species] {
        if searchText.isEmpty {
            return speciesVM.speciesArray
        }
        else {
            return speciesVM.speciesArray.filter{$0.name.capitalized.contains(searchText)}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesListView()
    }
}

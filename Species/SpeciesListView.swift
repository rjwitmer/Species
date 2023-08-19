//
//  SpeciesListView.swift
//  Species
//
//  Created by Bob Witmer on 2023-08-17.
//

import SwiftUI

struct SpeciesListView: View {
    @StateObject var speciesVM = SpeciesViewModel()
    @State private var searchText = ""
    
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
                        .buttonStyle(.borderedProminent)
                    }
                    ToolbarItem(placement: .status) {
                        Text("\(speciesVM.speciesArray.count) of \(speciesVM.count)")
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

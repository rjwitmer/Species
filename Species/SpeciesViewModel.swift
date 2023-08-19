//
//  SpeciesViewModel.swift
//  Species
//
//  Created by Bob Witmer on 2023-08-18.
//

import Foundation

@MainActor
class SpeciesViewModel: ObservableObject {
    
    private struct Returned: Codable {
        var count: Int
        var next: String?       // Optional because null is returned on the last page and it must be handled
        var results: [Species]
    }

    @Published var count = 0
    @Published var speciesArray: [Species] = []
    @Published var isLoading = false
    var urlString: String = "https://swapi.dev/api/species/"
    
    func getData() async {
        print("🕸️ We are accessing the URL \(urlString)")
        isLoading = true
        // convert urlString to a special URL type
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from:  url)
            
            // Try to decode JSON data into our out data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data")
                isLoading = false
                return
            }
            count = returned.count
            urlString = returned.next ?? ""    // Optional to handle null case
            speciesArray += returned.results
            isLoading = false
        } catch {
            print("😡 ERROR: Could not use URL at \(urlString) to get data and response --> \(error.localizedDescription)")
            isLoading = false
        }
    }
    
    func loadNextIfNeeded(species: Species) async {
        guard let lastSpecies = speciesArray.last else {
            return
        }
        
        if species.id == lastSpecies.id && urlString.hasPrefix("http") {
            Task {
                await getData()
            }
        }
        
    }
    
    func loadAll() async {
        guard urlString.hasPrefix("http") else {return}
        
        await getData()     // Get next page of data
        await loadAll()     // Call loadAll() again - will stop when all pages are retried (urlString == nul)
    }
}

//
//  DetailView.swift
//  Species
//
//  Created by Bob Witmer on 2023-08-19.
//

import SwiftUI

struct DetailView: View {
    @StateObject var speciesVM = SpeciesViewModel()
    let species: Species
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(species.name)
                .font(.largeTitle)
                .bold()
            
            Rectangle()
                .frame(height: 2)
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray)
                .padding(.bottom)

            Group {
                HStack(alignment: .top) {
                    Text("Classification:")
                        .bold()
                    
                    Text(species.classification.capitalized)
                }

                HStack(alignment: .top) {
                    Text("Designation:")
                        .bold()
                    
                    Text(species.designation.capitalized)
                }

                HStack(alignment: .top) {
                    HStack {
                        Text("Height:")
                            .bold()
                        
                        Text(species.average_height)
                    }
                    
                    HStack {
                        Text("Lifespan:")
                            .bold()
                        
                        Text(species.average_lifespan)
                    }
                }
                
                HStack(alignment: .top) {
                    Text("Language:")
                        .bold()
                    
                    Text(species.language.capitalized)
                }
                
                HStack(alignment: .top) {
                    Text("Skin Colors:")
                        .bold()
                    
                    Text(species.skin_colors)
                }
                
                HStack(alignment: .top) {
                    Text("Hair Colors:")
                        .bold()
                    
                    Text(species.hair_colors)

                }
                
                HStack(alignment: .top) {
                    Text("Eye Colors:")
                        .bold()
                    
                    Text(species.eye_colors)

                }
            }
            .font(.title2)
            
            HStack {
                Spacer()
                speciesImage
                Spacer()
            }
            
            Spacer()
            
        }

        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }

}

extension DetailView {

    var speciesImage: some View {
        AsyncImage(url: URL(string: speciesVM.returnedSpeciesURL(urlString: "https://gallaugher.com/wp-content/uploads/2023/04/\(species.name).jpg"))) { phase in
            if let image = phase.image {    // We have a valid image
                image
                    .resizable()
                    .scaledToFit()
                    .background(.white)
                    .cornerRadius(15)
                    .shadow(radius: 15, x: 5, y: 5)
                    .padding(.trailing)
            } else if phase.error != nil {  // We have an error
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .background(.white)
                    .frame(width: 180, height: 150)
                    .cornerRadius(15)
                    .shadow(radius: 15, x: 5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray.opacity(0.5), lineWidth: 1)
                    }
                    .padding(.trailing)
            } else {    // Use a placeholder
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 180, height: 180)
                    .padding(.trailing)
            }
        }

    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(species: Species(name: "Swifter", classification: "Coder", designation: "Sentient", average_height: "175", skin_colors: "various", hair_colors: "various or none", eye_colors: "blue, green, brown, black, hazel, gray, violet", average_lifespan: "83", language: "Swift"))
    }
}

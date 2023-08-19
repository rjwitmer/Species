//
//  DetailView.swift
//  Species
//
//  Created by Bob Witmer on 2023-08-19.
//

import SwiftUI

struct DetailView: View {
    
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
                    
                    Spacer()
                    
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
            
            Spacer()
            
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(species: Species(name: "Swifter", classification: "Coder", designation: "Sentient", average_height: "175", skin_colors: "various", hair_colors: "various or none", eye_colors: "blue, green, brown, black, hazel, gray, violet", average_lifespan: "83", language: "Swift"))
    }
}

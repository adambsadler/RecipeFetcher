//
//  RecipeView.swift
//  RecipeFetcher
//
//  Created by Adam Sadler on 11/6/24.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    var smallImage: UIImage?
    var largeImage: UIImage?
    
    @State private var isExpanded: Bool = false
    
    init(recipe: Recipe, smallImage: UIImage?, largeImage: UIImage?) {
        self.recipe = recipe
        self.smallImage = smallImage
        self.largeImage = largeImage
    }
    
    var body: some View {
        VStack {
            HStack {
                if !isExpanded, let image = smallImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                } else if let sourceString = recipe.sourceURL, let sourceURL = URL(string: sourceString) {
                    Link(destination: sourceURL) {
                        Image(systemName: "link")
                            .foregroundStyle(Color.black)
                            .font(.title2)
                    }
                }
                
                Spacer()
                
                Text(recipe.name)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    withAnimation {
                        isExpanded.toggle()
                    }
                } label: {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundStyle(Color.black)
                        .font(.title2)
                }
            }
            
            if isExpanded {
                VStack {
                    if let image = largeImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    }
                    
                    if let urlString = recipe.youtubeURL {
                        YouTubeVideoView(videoURL: urlString)
                            .frame(height: 300)
                            .cornerRadius(10)
                            .padding()
                    }
                    
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8.0)
                .foregroundStyle(Color.white)
                .opacity(0.5)
        )
    }
}

#Preview {
    RecipeView(recipe: Recipe(cuisine: "Malaysian", name: "Apam Balik", photoURLLarge: "", photoURLSmall: "", uuid: "", sourceURL: "https://nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ", youtubeURL: "https://www.youtube.com/watch?v=6R8ffRRJcrg"), smallImage: nil, largeImage: nil)
}

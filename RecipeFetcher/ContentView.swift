//
//  ContentView.swift
//  RecipeFetcher
//
//  Created by Adam Sadler on 11/6/24.
//

import SwiftUI

struct ContentView: View {
    var recipeVM = RecipeViewModel()
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.white, .blue],
                           center: .topLeading,
                           startRadius: 0,
                           endRadius: 800
            ).ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Text("Recipes")
                        .fontDesign(.serif)
                        .font(.largeTitle)
                    
                    if recipeVM.recipes.isEmpty {
                        Text("Pull down to load recipes...")
                            .padding(.top)
                    } else {
                        ForEach(recipeVM.recipes, id: \.self) { recipe in
                            RecipeView(recipe: recipe, smallImage: recipeVM.smallImages[recipe.uuid], largeImage: recipeVM.largeImages[recipe.uuid])
                                .padding(.horizontal)
                        }
                    }
                    
                }
                .padding(.top)
            }.refreshable {
                await recipeVM.loadRecipes()
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ContentView()
}

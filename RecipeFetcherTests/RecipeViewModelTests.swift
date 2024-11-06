//
//  RecipeViewModelTests.swift
//  RecipeFetcherTests
//
//  Created by Adam Sadler on 11/6/24.
//

import Testing

@testable import RecipeFetcher

struct RecipeViewModelTests {
    let recipeVM = RecipeViewModel()

    @Test func testLoadRecipes() async throws {
        #expect(recipeVM.recipes.isEmpty)
        
        await recipeVM.loadRecipes()
        
        #expect(!recipeVM.recipes.isEmpty)
    }
    
    @Test func testDownloadAndCacheImages() async throws {
        #expect(recipeVM.smallImages.isEmpty)
        #expect(recipeVM.largeImages.isEmpty)
        
        let newRecipe = Recipe(cuisine: "Malaysian",
                               name: "Apam Balik",
                               photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                               photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                               uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                               sourceURL: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                               youtubeURL: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
        recipeVM.recipes.append(newRecipe)
        
        await recipeVM.downloadAndCacheImages()
        
        #expect(!recipeVM.smallImages.isEmpty)
        #expect(!recipeVM.largeImages.isEmpty)
    }
}

//
//  RecipeViewModel.swift
//  RecipeFetcher
//
//  Created by Adam Sadler on 11/6/24.
//

import SwiftUI

@Observable
class RecipeViewModel {
    private let networkManager = NetworkManager()
    var recipes: [Recipe] = []
    var error: Error?
    var smallImages: [String: UIImage] = [:]
    var largeImages: [String: UIImage] = [:]
    
    func loadRecipes() async {
        do {
            let recipes = try await networkManager.fetchRecipes()
            self.recipes = recipes
            await downloadAndCacheImages()
        } catch {
            self.error = error
        }
    }
    
    func downloadAndCacheImages() async {
        for recipe in recipes {
            let smallFileName = "\(recipe.uuid)_small.jpg"
            let largeFilename = "\(recipe.uuid)_large.jpg"
            
            if let smallURL = recipe.photoURLSmall, let smallImage = await networkManager.downloadAndCacheImage(from: smallURL, fileName: smallFileName) {
                smallImages[recipe.uuid] = smallImage
            }
            
            if let largeURL = recipe.photoURLLarge, let largeImage = await networkManager.downloadAndCacheImage(from: largeURL, fileName: largeFilename) {
                largeImages[recipe.uuid] = largeImage
            }
        }
    }
}

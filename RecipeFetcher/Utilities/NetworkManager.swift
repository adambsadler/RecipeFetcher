//
//  NetworkManager.swift
//  RecipeFetcher
//
//  Created by Adam Sadler on 11/6/24.
//

import Foundation
import UIKit

class NetworkManager {
    private let url: URL
    private let fileHelper = FileHelper()
    
    init(url: URL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!) {
        self.url = url
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
        return recipeResponse.recipes
    }
    
    func downloadAndCacheImage(from urlString: String, fileName: String) async -> UIImage? {
        if fileHelper.fileExists(at: fileName) {
            return fileHelper.loadImage(fileName: fileName)
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            fileHelper.saveImageToDocuments(data: data, fileName: fileName)
            return UIImage(data: data)
        } catch {
            print("Error downloading image: \(error)")
            return nil
        }
    }
}

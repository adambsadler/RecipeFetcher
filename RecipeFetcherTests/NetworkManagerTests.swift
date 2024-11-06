//
//  NetworkManagerTests.swift
//  RecipeFetcherTests
//
//  Created by Adam Sadler on 11/6/24.
//

import Testing
import Foundation

@testable import RecipeFetcher

struct NetworkManagerTests {
    let networkManager = NetworkManager()

    @Test func testFetchRecipes() async throws {
        let recipes = try await networkManager.fetchRecipes()
        #expect(!recipes.isEmpty)
    }
    
    @Test func testFetchRecipesWithEmptyData() async throws {
        let emptyNetworkManager = NetworkManager(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!)
        let recipes = try await emptyNetworkManager.fetchRecipes()
        #expect(recipes.isEmpty)
    }

    @Test func testDownloadAndCacheImage() async throws {
        let image = await networkManager.downloadAndCacheImage(from: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", fileName: "test_image.jpg")
        #expect(image != nil)
    }
}

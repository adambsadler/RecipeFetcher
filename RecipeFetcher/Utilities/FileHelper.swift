//
//  FileHelper.swift
//  RecipeFetcher
//
//  Created by Adam Sadler on 11/6/24.
//

import Foundation
import UIKit

struct FileHelper {
    func getFileURL(for fileName: String) -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsDirectory.appending(path: fileName)
    }
    
    func saveImageToDocuments(data: Data, fileName: String) {
        guard let fileURL = getFileURL(for: fileName) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("Error saving image to documents directory: \(error)")
        }
    }
    
    func fileExists(at fileName: String) -> Bool {
        guard let fileURL = getFileURL(for: fileName) else { return false }
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    func loadImage(fileName: String) -> UIImage? {
        guard let fileURL = getFileURL(for: fileName), let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }
}

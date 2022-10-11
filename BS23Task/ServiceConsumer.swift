//
//  ServiceConsumer.swift
//  BS23Task
//
//  Created by Romana on 11/10/22.
//

import Foundation
import SwiftUI

class ServiceConsumer: ObservableObject {
    
    let dataURL = "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=marvel"
    
    func loadData(completion:@escaping (Movie) -> ()) {
        guard let url = URL(string: dataURL) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let movies: Movie = try JSONDecoder().decode(Movie.self, from: data)
                        completion(movies)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
    
}

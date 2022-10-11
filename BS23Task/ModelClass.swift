//
//  ModelClass.swift
//  BS23Task
//
//  Created by Romana on 11/10/22.
//

import Foundation

struct Movie: Codable {
    var page: Int
    var results: [MovieResult]
    var total_pages: Int
    var total_results: Int
}

struct MovieResult: Identifiable, Codable {
    var id: Int
    var adult: Bool
    var backdrop_path: String
    var genre_ids: [Int]
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Double
    var poster_path: String
    var release_date: String
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Double
}

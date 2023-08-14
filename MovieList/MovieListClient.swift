//
//  MovieListClient.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import Foundation

final class MovieListClient {
    private var apiKey: String {
        "629dffce2b8a8f3cf597af9e1c49fdcf"
    }

    func fetchMovies(filters: [Filter], page: Int) async throws -> PaginatedResult<Movie> {
        let result: PaginatedResult<Movie> = try await fetchData(
            from: MovieListEndpoint.movies.url,
            queryItems: filters.map(\.query),
            page: page
        )
        return result
    }

    func fetchGenres() async throws -> [Genre] {
        let container: GenresContainer = try await fetchData(from: MovieListEndpoint.genres.url)
        return container.genres
    }

    func fetchLanguages() async throws -> [Language] {
        try await fetchData(from: MovieListEndpoint.languages.url)
    }

    private func buildURL(
        base: URL,
        queryItems: [URLQueryItem]?,
        page: Int?
    ) -> URL {
        var url = base
        let apiKey = URLQueryItem(name: "api_key", value: apiKey)

        var mutableQueryItems: [URLQueryItem] = []
        mutableQueryItems.append(apiKey)

        if let queryItems,
           !queryItems.isEmpty {
            mutableQueryItems.append(contentsOf: queryItems)
        }

        if let page {
            let pageQuery = URLQueryItem(
                name: "page",
                value: String(page)
            )

            mutableQueryItems.append(pageQuery)
        }

        url.append(queryItems: mutableQueryItems)

        print("url: \(url)")

        return url
    }

    private func fetchData<T: Codable>(
        from url: URL,
        queryItems: [URLQueryItem]? = nil,
        page: Int? = nil
    ) async throws -> T {
        let url = buildURL(
            base: url,
            queryItems: queryItems,
            page: page
        )

        let (data, _) = try await URLSession.shared.data(from: url)

        let json = try JSONSerialization.jsonObject(with: data)
        print("*** json: \(json)")

        let result: MovieListResultType<T> = try MovieListResultType(data: data)

        switch result {
        case .success(let result):
            print("*** result: \(result)")
            return result
        case .error(let error):
            print("*** error: \(error)")
            throw error
        }
    }
}

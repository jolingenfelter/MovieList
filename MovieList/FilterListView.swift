//
//  FilterListView.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/14/23.
//

import SwiftUI

struct FilterController {
    private let apiClient = MovieListClient()

    private(set) var isLoading: Bool = false
    private(set) var allGenres: [Genre] = []
    private(set) var allLanguages: [Language]  = []

    @Binding
    var selectedFilters: [Filter]

    var error: AlertModel?

    mutating
    func fetchFilters() async {
        isLoading = true

        defer {
            isLoading = false
        }

        do {
            let genres = try await apiClient.fetchGenres()
            let languages = try await apiClient.fetchLanguages()

            self.allGenres = genres
            self.allLanguages = languages
        } catch {
            self.error = AlertModel(
                title: "Alert",
                message: error.localizedDescription,
                actions: [.ok]
            )
        }
    }
}

struct FilterButton: View {
    @Binding var isSelected: Bool

    let title: String

    var body: some View {
        Button {
            isSelected.toggle()
            print("*** isSelected: \(isSelected)")
        } label: {
            HStack {
                Text(title)
                Spacer()
            }
        }

    }
}

struct FilterListView: View {
    @State
    private var controller: FilterController

    init(appliedFilters: Binding<[Filter]>) {
        _controller = State(wrappedValue: FilterController(selectedFilters: appliedFilters))
    }
    
    var body: some View {
        NavigationStack {
            List {
                DisclosureGroup {
                    ForEach(controller.allGenres) { genre in
                        FilterButton(isSelected: <#T##Binding<Bool>#>, title: genre)
                    }
                } label: {
                    Text("Genres")
                        .font(.headline)
                }

                DisclosureGroup {
                    ForEach(controller.allLanguages) { language in
                        Text(language.englishName)
                    }
                } label: {
                    Text("Languages")
                        .font(.headline)
                }
            }
            .navigationTitle("Filters")
            .onAppear {
                Task {
                    await controller.fetchFilters()
                }
            }
        }
    }
}

//struct FilterListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterListView()
//    }
//}

//
//  ScrumStore.swift
//  icu001
//
//  Created by Hanjun Kang on 6/30/23.
//

import Foundation

@MainActor
class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = []

    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("scrums.data")
    }

    func load() async throws {
        let task = Task<[DailyScrum], Error> {
            let url = try Self.fileURL()
            guard let data = try? Data(contentsOf: url) else {
                return []
            }
            let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: data)
            return dailyScrums
        }
        scrums = try await task.value
    }

//    func load() {
//        guard let url = try? Self.fileURL(), let data = try? Data(contentsOf: url), let scrums = try? JSONDecoder().decode([DailyScrum].self, from: data) else {
//            return
//        }
//        self.scrums = scrums
//    }

    func save(scrums: [DailyScrum]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(scrums)
            let url = try Self.fileURL()
            try data.write(to: url)
        }
        let _ = try await task.value
    }
}

//
//  ViewModel.swift
//  Rush
//
//  Created by Michael Gillund on 10/4/22.
//

import SwiftUI

@MainActor
final class ViewModel: ObservableObject {
    
    @Published var sections: [Sections] = []
    @Published var date: Date = Date()
    @Published var error: Error?
    @Published private(set) var state: LoadingState = .loading

    var isLoading: Bool {
        state == .loading
    }
    func fetch() async {
        self.state = .loading
        do {
            async let nfl: SportsModel = Network.shared.fetch(endpoint: .nfl, date: date.formatDate())
            async let nba: SportsModel = Network.shared.fetch(endpoint: .nba, date: date.formatDate())
            async let mlb: SportsModel = Network.shared.fetch(endpoint: .mlb, date: date.formatDate())
            async let nhl: SportsModel = Network.shared.fetch(endpoint: .nhl, date: date.formatDate())
            async let ncaaf: SportsModel = Network.shared.fetch(endpoint: .ncaaf, date: date.formatDate())
            async let ncaab: SportsModel = Network.shared.fetch(endpoint: .ncaab, date: date.formatDate())
            async let mls: SportsModel = Network.shared.fetch(endpoint: .mls, date: date.formatDate())
            async let epl: SportsModel = Network.shared.fetch(endpoint: .epl, date: date.formatDate())
            async let wnba: SportsModel = Network.shared.fetch(endpoint: .wnba, date: date.formatDate())

            var section: [Sections] = []

            if try await !nfl.events.isEmpty {
                try await section.append(.init(icon: "football.fill", title: "NFL", sports: nfl.events, leagues: nfl.leagues))
            }
            if try await !nba.events.isEmpty {
                try await section.append(.init(icon: "basketball.fill", title: "NBA", sports: nba.events, leagues: nba.leagues))
            }
            if try await !mlb.events.isEmpty {
                try await section.append(.init(icon: "baseball.fill", title: "MLB", sports: mlb.events, leagues: mlb.leagues))
            }
            if try await !nhl.events.isEmpty {
                try await section.append(.init(icon: "hockey.puck.fill", title: "NHL", sports: nhl.events, leagues: nhl.leagues))
            }
            if try await !ncaaf.events.isEmpty {
                try await section.append(.init(icon: "football.fill", title: "NCAAF", sports: ncaaf.events, leagues: ncaaf.leagues))
            }
            if try await !ncaab.events.isEmpty {
                try await section.append(.init(icon: "basketball.fill", title: "NCAAB", sports: ncaab.events, leagues: ncaab.leagues))
            }
            if try await !mls.events.isEmpty {
                try await section.append(.init(icon: "soccerball", title: "MLS", sports: mls.events, leagues: mls.leagues))
            }
            if try await !epl.events.isEmpty {
                try await section.append(.init(icon: "soccerball", title: "EPL", sports: epl.events, leagues: epl.leagues))
            }
            if try await !wnba.events.isEmpty {
                try await section.append(.init(icon: "basketball.fill", title: "WNBA", sports: wnba.events, leagues: wnba.leagues))
            }

            self.sections = section
            self.state = .success(data: self.sections)
        }catch{
            self.state = .failed(error: error)
            print(error)
        }
    }
}
struct Sections: Identifiable, Equatable {
    
    let id = UUID().uuidString
    var icon: String
    var title: String
    var sports: [Event]?
    var leagues: [Leagues]?
    
    static func == (lhs: Sections, rhs: Sections) -> Bool {
        return true
    }
}
enum LoadingState: Equatable {
    case loading
    case success(data: [Sections])
    case failed(error: Error)
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.success(data: let lhsType), .success(data: let rhsType)):
            return lhsType == rhsType
        case (.failed(error: let lhsType), .failed(error: let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
        }
    }
}

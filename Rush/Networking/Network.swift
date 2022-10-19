//
//  Network.swift
//  Rush
//
//  Created by Michael Gillund on 10/4/22.
//

import SwiftUI
import Foundation

public class Network {

    public static let shared = Network()

    public func request<Model: Codable>(url: String) async throws -> Model {
        let session = URLSession.shared
        let urls = URL(string: url)!
        let request = URLRequest(url: urls)
        let (data, _) = try await session.data(for: request)
        let object = try JSONDecoder().decode(Model.self, from: data)
        return object
    }
    
    //
    func fetch<Model: Codable>(endpoint: Endpoint, date: String) async throws -> Model {
        let session = URLSession.shared
        let request = request(endpoint, date: date)
        let (data, _) = try await session.data(for: request)
        let object = try JSONDecoder().decode(Model.self, from: data)
        return object
    }
    
    private func request(_ endpoint: Endpoint, date: String) -> URLRequest {
        let url = url(endpoint)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "dates", value: date),
        ]
        return URLRequest(url: components.url!)
    }

    private func url(_ endpoint: Endpoint) -> URL {
        let url = URL(string: "https://site.api.espn.com/apis/site/v2/sports/")!
        return url.appendingPathComponent(endpoint.build())
    }
}

public enum Endpoint {
    case nfl
    case nba
    case mlb
    case nhl
    case golf
    case ncaaf
    case ncaab
    case mls
    case epl
    case wnba
          
    public func build() -> String {
        switch self {
            case .nfl:
                return "football/nfl/scoreboard"
            case .nba:
                return "basketball/nba/scoreboard"
            case .mlb:
                return "baseball/mlb/scoreboard"
            case .nhl:
                return "hockey/nhl/scoreboard"
            case .golf:
                return "golf/pga/scoreboard"
            case .ncaaf:
                return "football/college-football/scoreboard"
            case .ncaab:
                return "basketball/mens-college-basketball/scoreboard"
            case .mls:
                return "soccer/usa.1/scoreboard"
            case .epl:
                return "soccer/eng.1/scoreboard"
            case .wnba:
                return "basketball/wnba/scoreboard"
        }
    }
}

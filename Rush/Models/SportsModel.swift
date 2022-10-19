//
//  SportsModel.swift
//  Rush
//
//  Created by Michael Gillund on 10/4/22.
//

import Foundation

// MARK: - Models

// MARK: - SportsModel
struct SportsModel: Codable, Identifiable {
    let id: UUID = UUID()
    let events: [Event]
    let leagues: [Leagues]
    
    enum CodingKeys: String, CodingKey{
        case events, leagues
    }
}
// MARK: - Leagues
struct Leagues: Codable {
    let name: String
    let abbreviation: String
    let slug: String
}

// MARK: - Event
struct Event: Codable, Identifiable, Equatable, Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let date: String
    let name: String?
    let competitions: [Competition]
    let status: Status
    let links: [SportsLinks]
    
    enum CodingKeys: String, CodingKey{
        case date, competitions, status, links, id
        case name = "shortName"
    }
    
    var outcome: Bool {
        
        return true
    }
    var league: String {
        var value: String = ""
        if links[0].href.contains("nfl") ||
            links[0].href.contains("ncaaf"){
            value = "football"
        }else if links[0].href.contains("nba") ||
                    links[0].href.contains("ncaab") ||
                    links[0].href.contains("wnba") ||
                    links[0].href.contains("wncaa"){
            value = "basketball"
        }else if links[0].href.contains("mlb"){
            value = "baseball"
        }else if links[0].href.contains("nhl"){
            value = "hockey"
        }else if links[0].href.contains("mls") ||
                    links[0].href.contains("epl"){
            value = "soccer"
        }
        return value
    }
    var home_pitcher: String{
        return competitions[0].competitors[0].probables?[0].athlete.shortName ?? ""
    }
    var away_pitcher: String{
        return competitions[0].competitors[1].probables?[0].athlete.shortName ?? ""
    }
    // Home Team
    var home_name: String {
        return competitions[0].competitors[0].team.shortDisplayName ?? ""
    }
    var home_image: String {
        let str = competitions[0].competitors[0].team.logo ?? ""
        return str
    }
    var home_image_dark: String {
        var str = competitions[0].competitors[0].team.logo ?? ""
        if let i = str.firstIndex(of: "5") {
            let value = i.utf16Offset(in:str)
            str.insert("-", at: str.index(str.startIndex, offsetBy: value + 3))
            str.insert("d", at: str.index(str.startIndex, offsetBy: value + 4))
            str.insert("a", at: str.index(str.startIndex, offsetBy: value + 5))
            str.insert("r", at: str.index(str.startIndex, offsetBy: value + 6))
            str.insert("k", at: str.index(str.startIndex, offsetBy: value + 7))
        }else{
           print("Not Found")
        }
        return str
    }
    var home_score: String {
        var score: String  = ""
        if status.type.description.hasPrefix("Scheduled"){
            score = ""
        }else{
            score = competitions[0].competitors[0].score ?? ""
        }
        return score
    }
    var home_abv: String {
        return competitions[0].competitors[0].team.abbreviation ?? ""
    }
    var home_color: String {
        return competitions[0].competitors[0].team.color ?? ""
    }
    // Away Team
    var away_name: String {
        return competitions[0].competitors[1].team.shortDisplayName ?? ""
    }
    var away_image: String {
        let str = competitions[0].competitors[1].team.logo ?? ""
        return str
    }
    var away_image_dark: String {
        var str = competitions[0].competitors[1].team.logo ?? ""
        if let i = str.firstIndex(of: "5") {
            let value = i.utf16Offset(in:str)
            str.insert("-", at: str.index(str.startIndex, offsetBy: value + 3))
            str.insert("d", at: str.index(str.startIndex, offsetBy: value + 4))
            str.insert("a", at: str.index(str.startIndex, offsetBy: value + 5))
            str.insert("r", at: str.index(str.startIndex, offsetBy: value + 6))
            str.insert("k", at: str.index(str.startIndex, offsetBy: value + 7))
        }else{
           print("Not Found")
        }
        return str
    }
    var away_score: String {
        var score: String  = ""
        if status.type.description.hasPrefix("Scheduled"){
            score = ""
        }else{
            score = competitions[0].competitors[1].score ?? ""
        }
        return score
    }
    var away_abv: String {
        return competitions[0].competitors[1].team.abbreviation ?? ""
    }
    var away_color: String {
        return competitions[0].competitors[1].team.color ?? ""
    }
    // Odds
    var odds: String {
        var value: String = competitions[0].odds?[0].details ?? ""
        if value.hasPrefix("nil"){
            value = ""
        }else if competitions[0].odds?[0].overUnder == nil {
            value = ""
        }else{
            value = competitions[0].odds?[0].details ?? ""
        }
        return value
    }
    var over_under: String {
        var value: String = competitions[0].odds?[0].overUnder?.clean ?? ""
        if competitions[0].odds?[0].overUnder == nil {
            value = ""
        }else if value.hasPrefix("nil") {
            value = ""
        }else{
            value = "o/u\(competitions[0].odds?[0].overUnder?.clean ?? "")"
        }
        return value
    }
    // Event Status
    var gametime: String {
        var time: String = ""
        if status.type.state.hasPrefix("pre"){
            time = SportsDate(date: date)
        }
        else{
            time = status.type.shortDetail
            let remove_one = "-"
            if let range_one = time.range(of: remove_one) {
                time.removeSubrange(range_one)
            }
            let remove_two = "of "
            if let range_two = time.range(of: remove_two) {
                time.removeSubrange(range_two)
            }
        }
        return time
    }
    var sorted: String {
        var value: String = ""
        if status.type.state.hasPrefix("pre"){
            value = "B"
        }else if status.type.state.hasPrefix("in"){
            value = "A"
        }else if status.type.state.hasPrefix("post"){
            value = "C"
        }
        return value
    }
    var state: String {
        return status.type.state
    }
    var description: String {
        return status.type.description
    }
    var live: Bool {
        var valid: Bool
        if status.type.state.hasPrefix("pre") || status.type.state.hasPrefix("post"){
            valid = false
        }else{
            valid = true
        }
        return valid
    }
    var pre: Bool {
        var valid: Bool
        if status.type.state.hasPrefix("pre"){
            valid = true
        }else{
            valid = false
        }
        return valid
    }
    var post: Bool{
        var valid: Bool
        if status.type.state.hasPrefix("post"){
            valid = true
        }else{
            valid = false
        }
        return valid
    }
    var series: String {
        return competitions[0].series?.summary ?? ""
    }
    var channel: String {
        var value: String = ""
        for broadcast in competitions[0].broadcasts ?? [] {
            for name in broadcast.names ?? []{
                value = name
            }
        }
        return value
    }
    // Baseball Only
    var outs: String {
        var value: String
        if live == false {
            value = ""
        }else{
            if competitions[0].situation?.outs == 0 || competitions[0].situation?.outs == 1 {
                value = "\(String(competitions[0].situation?.outs ?? 0)) Out"
            }else{
                value = "\(String(competitions[0].situation?.outs ?? 0)) Outs"
            }
        }
        return value
    }
    var first_base: Bool {
        return competitions[0].situation?.onFirst ?? false
    }
    var second_base: Bool {
        return competitions[0].situation?.onSecond ?? false
    }
    var third_base: Bool {
        return competitions[0].situation?.onThird ?? false
    }
    //
    var home_hits: String {
        return "\(competitions[0].competitors[0].hits ?? 0)"
    }
    var away_hits: String {
        return "\(competitions[0].competitors[1].hits ?? 0)"
    }
    var home_errors: String {
        return "\(competitions[0].competitors[0].errors ?? 0)"
    }
    var away_errors: String {
        return "\(competitions[0].competitors[1].errors ?? 0)"
    }
    //
    var home_linescore: [LineScores]{
        return competitions[0].competitors[0].linescores ?? []
    }
    var away_linescore: [LineScores]{
        return competitions[0].competitors[1].linescores ?? []
    }
}
// MARK: - Competition
struct Competition: Codable {
    let id: String
    let competitors: [Competitors]
    let situation: Situation?
    let odds: [Odds]?
    let series: Series?
    let broadcasts: [Broadcast]?
}
// MARK: - Competitors
struct Competitors: Codable {
    let id: String?
    let team: Team
    let records: [Records]?
    let score: String?
    let hits: Int?
    let errors: Int?
    let linescores: [LineScores]?
    let probables: [Probables]?
}
struct Probables: Codable {
    struct Athlete: Codable {
        let shortName: String
    }
    let abbreviation: String
    let athlete: Athlete
}
struct LineScores: Codable, Identifiable {
    let id: UUID = UUID()
    let value: Int?
    
    enum CodingKeys: String, CodingKey{
        case value
    }
}
// MARK: - Broadcast
struct Broadcast: Codable {
    let names: [String]?
}
// MARK: - Records
struct Records: Codable {
    let summary: String?
}
// MARK: - Links
struct SportsLinks: Codable {
    let href: String
}
struct Series: Codable {
    let summary: String?
}
// MARK: - Odds
struct Odds: Codable {
    let details: String?
    let overUnder: Float?
}
// MARK: - Team
struct Team: Codable {
    let abbreviation, displayName, shortDisplayName: String?
    let color: String?
    let logo: String?
    let links: [SportsLinks]
}
// MARK: - Situation
struct Situation: Codable {
    let outs: Int?
    let onFirst: Bool?
    let onSecond: Bool?
    let onThird: Bool?
    let shortDownDistanceText: String?
    let possession: String?
    let isRedZone: Bool?
}
// MARK: - Status
struct Status: Codable {
    let clock: Double?
    let displayClock: String?
    let period: Double?
    let type: Types
}
// MARK: - Type
struct Types: Codable {
    let name, description, detail, shortDetail: String
    let state: String
}

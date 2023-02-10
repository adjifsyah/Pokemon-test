//
//  URLSessionClient.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import Foundation

class URLSessionClient {
    typealias Result = Swift.Result<[PokemonModel], Error>
    typealias ResultDetail = Swift.Result<DetailPokemonResponse, Error>
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func getListPokemon(urlStr: String, completion: @escaping (Result) -> Void) {
        let component = URLComponents(string: urlStr)
        guard let url = component?.url else { return }
        
        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            guard self != nil else { return }
            
            if let data = data, let response = response as? HTTPURLResponse {
                completion(URLSessionClient.mapObject(data, response))
            } else {
                completion(.failure(NetworkError.networkError))
            }
        }.resume()
    }
    
    func getDetailPokemon(urlStr: String, completion: @escaping (ResultDetail) -> Void) {
        let component = URLComponents(string: urlStr)
        guard let url = component?.url else { return }
        
        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            guard self != nil else { return }
            
            if let data = data, let response = response as? HTTPURLResponse {
                completion(URLSessionClient.mapObject(data, response))
            } else {
                completion(.failure(NetworkError.networkError))
            }
        }.resume()
    }
    
    private static func mapObject(_ data: Data, _ response: HTTPURLResponse) -> Result {
        do {
            let listPokemon = try ListPokemonMapper.mapListPokemon(data: data, response: response)
            return .success(listPokemon)
        } catch {
            return .failure(NetworkError.unexpectedData)
        }
    }
    
    private static func mapObject(_ data: Data, _ response: HTTPURLResponse) -> ResultDetail {
        do {
            let listPokemon = try ListPokemonMapper.mapDetailPokemon(data: data, response: response)
            return .success(listPokemon)
        } catch {
            return .failure(NetworkError.unexpectedData)
        }
    }
}

struct ListPokemonMapper {
    private init() { }
    
    static func mapListPokemon(data: Data, response: HTTPURLResponse) throws -> [PokemonModel] {
        guard
            response.statusCode == 200,
            let items = try? JSONDecoder().decode(RemotePokemonResponse.self, from: data)
        else {
            throw NetworkError.unexpectedData
        }
        
        let spesificMap = items.dataPokemon.map {
            PokemonModel(
                name: $0.pokemonName,
                imageStr: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\( $0.pokemonUrl.components(separatedBy: ["/", "."]).filter { Int($0) != nil }.first ?? "").png"
            )
        }
        return spesificMap
    }
    
    static func mapDetailPokemon(data: Data, response: HTTPURLResponse) throws -> DetailPokemonResponse {
        guard
            response.statusCode == 200,
            let items = try? JSONDecoder().decode(RemoteDetailPokemonResponse.self, from: data)
        else {
            throw NetworkError.unexpectedData
        }
        
        let spesificMap = DetailPokemonResponse(pokemonTypes: items
            .pokemonTypes.map {
                PokemonType(pokemonType: $0.pokemonTypes.name)
            },
                                                pokemonStatistics: items
            .pokemonStatistics
            .map { PokemonStatistic(titleType: $0.titleStats.name,
                                    valueType: $0.valueStats)
            },
                                                pokemonName: items.pokemonName,
                                                pokemonImage: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(items.pokemonId).png",
                                                pokemonHeight: items.pokemonHeight,
                                                pokemonWeight: items.pokemonWeight,
                                                pokemonExperience: items.pokemonExperience)
        return spesificMap
    }
    
}


// MARK: - MODEL LIST

struct PokemonModel {
    let name: String
    let imageStr: String
}

struct RemoteSpesificPokemon: Codable {
    let sprites: RemoteSpirits
}

struct RemoteSpirits: Codable {
    let other: RemoteOthers
}

struct RemoteOthers: Codable {
    let home: RemoteHome
}

struct RemoteHome: Codable {
    let imagePokemon: String
    
    enum CodingKeys: String, CodingKey {
        case imagePokemon = "front_default"
    }
}

struct PokemonImageModel: Codable {
    let imagePokemon: String
    
    enum CodingKeys: String, CodingKey {
        case imagePokemon = "front_default"
    }
}

// MARK: - MODEL MY POKEMON



// MARK: - MODEL DETAIL

struct RemoteDetailPokemonResponse: Codable {
    let pokemonTypes: [RemotePokemonTypes]
    let pokemonStatistics: [RemotePokemonStatistic]
    let pokemonName: String
    let pokemonId: Int
    let pokemonHeight: Int
    let pokemonWeight: Int
    let pokemonExperience: Int
    
    enum CodingKeys: String, CodingKey {
        case pokemonTypes = "types"
        case pokemonStatistics = "stats"
        case pokemonName = "name"
        case pokemonId = "id"
        case pokemonHeight = "height"
        case pokemonWeight = "weight"
        case pokemonExperience = "base_experience"
    }
}

struct DetailPokemonResponse: Codable {
    let pokemonTypes: [PokemonType]
    let pokemonStatistics: [PokemonStatistic]
    let pokemonName: String
    let pokemonImage: String
    let pokemonHeight: Int
    let pokemonWeight: Int
    let pokemonExperience: Int
    
    enum CodingKeys: String, CodingKey {
        case pokemonTypes = "types"
        case pokemonStatistics = "stats"
        case pokemonName = "name"
        case pokemonImage
        case pokemonHeight = "height"
        case pokemonWeight = "weight"
        case pokemonExperience = "base_experience"
    }
}


// Poison, grass
struct RemotePokemonTypes: Codable {
    let pokemonTypes: RemotePokemonType
    
    enum CodingKeys: String, CodingKey {
        case pokemonTypes = "type"
    }
}

struct RemotePokemonType: Codable {
    let name: String
}

struct PokemonType: Codable {
    let pokemonType: String
    
    enum CodingKeys: String, CodingKey {
        case pokemonType = "name"
    }
}
//


// Pokemon Statistic like Hp = 50
struct RemotePokemonStatistic: Codable {
    let titleStats: RemotePokemonStats
    let valueStats: Int
    
    
    enum CodingKeys: String, CodingKey {
        case titleStats = "stat"
        case valueStats = "base_stat"
    }
}

struct RemotePokemonStats: Codable {
    let name: String
}

struct PokemonStatistic: Codable {
    let titleType: String
    let valueType: Int
}
//

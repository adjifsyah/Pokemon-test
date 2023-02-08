//
//  URLSessionClient.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import Foundation

class URLSessionClient {
    typealias Result = Swift.Result<[PokemonModel], Error>
    
    let urlSession: URLSession
    
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
    
    private static func mapObject(_ data: Data, _ response: HTTPURLResponse) -> Result {
        do {
            let listPokemon = try ListPokemonMapper.mapListPokemon(data: data, response: response)
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
        let spesificMap = items.dataPokemon.map { PokemonModel(name: $0.pokemonName)}
        return spesificMap
    }
    
}


struct PokemonModel {
    let name: String
}

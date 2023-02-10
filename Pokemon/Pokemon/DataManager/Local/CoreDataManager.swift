//
//  CoreDataManager.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 10/02/23.
//

import UIKit
import CoreData

class CoreDataManager {
    private init() { }
    typealias ResultDefault = Swift.Result<[PokemonModel], Error>
    typealias SaveResult = Swift.Result<String, Error>
    
    static func save(pokemonName: String, imageUrl: String, pokeId: Int, navigationController: UINavigationController,
                     completion: @escaping (SaveResult) -> Void) {
        var users = [PokemonModel]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let newEntity =  NSEntityDescription.entity(forEntityName: "MyPokemon", in: managedContext)!
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyPokemon")
        let newHistory =  NSManagedObject(entity: newEntity, insertInto: managedContext)
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            result.forEach{ user in
                users.append(
                    PokemonModel(name: user.value(forKey: "pokemon_name") as? String ?? "",
                                 imageStr: user.value(forKey: "image_url") as? String ?? "",
                                 pokemonId: user.value(forKey: "pokemon_id") as? Int ?? 0
                                )
                )
            }
            guard
                users.filter({ $0.name == pokemonName }).isEmpty
            else {
                return AlertHelper.showGeneralAlert(message: "\(pokemonName) already exists",
                                                    navigationController: navigationController)
            }
            
            newHistory.setValue(pokemonName, forKey: "pokemon_name")
            newHistory.setValue(imageUrl, forKey: "image_url")
            newHistory.setValue(pokeId, forKey: "pokemon_id")
            
            try managedContext.save()
            completion(.success(pokemonName))
        } catch let err as NSError {
            completion(.failure(err))
        }
    }
    
    // fungsi refrieve semua data
    static func retrieve(completion: @escaping (ResultDefault) -> Void) {
        var users = [PokemonModel]()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyPokemon")
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            result.forEach{ user in
                users.append(
                    PokemonModel(name: user.value(forKey: "pokemon_name") as? String ?? "",
                                 imageStr: user.value(forKey: "image_url") as? String ?? "",
                                 pokemonId: user.value(forKey: "pokemon_id") as? Int ?? 0
                                )
                )
            }
            completion(.success(users))
        } catch let err {
            completion(.failure(err))
        }
    }
    
    static func delete(_ pokemonName: String, navigationController: UINavigationController, completion: @escaping (Result<String, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "MyPokemon")
        fetchRequest.predicate = NSPredicate(format: "pokemon_name = %@", pokemonName)
        
        do {
            let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
            managedContext.delete(dataToDelete)
            
            try managedContext.save()
            completion(.success(pokemonName))
        } catch let err {
            completion(.failure(err))
        }
    }
    
}

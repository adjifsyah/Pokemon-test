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
    typealias Result = Swift.Result<[PokemonModel], Error>
    typealias SaveResult = Swift.Result<String, Error>
    
    static func save(pokemonName: String, imageUrl: String, navigationController: UINavigationController,
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
                                 imageStr: user.value(forKey: "image_url") as? String ?? ""
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
            
            try managedContext.save()
            completion(.success(pokemonName))
        } catch let err as NSError {
            completion(.failure(err))
        }
    }
    
    // fungsi refrieve semua data
    static func retrieve(completion: @escaping (Result) -> Void) {
        var users = [PokemonModel]()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyPokemon")
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            result.forEach{ user in
                users.append(
                    PokemonModel(name: user.value(forKey: "pokemon_name") as? String ?? "",
                                 imageStr: user.value(forKey: "image_url") as? String ?? ""
                                )
                )
            }
            completion(.success(users))
        } catch let err {
            completion(.failure(err))
        }
    }
    
    //    static func update(_ damageName:String, _ merekLaptop:String, _ tipeLaptop:String){
    //
    //        // referensi ke AppDelegate
    //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    //
    //        // managed context
    //        let managedContext = appDelegate.persistentContainer.viewContext
    //
    //        // fetch data to delete
    //        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
    //        //           fetchRequest.predicate = NSPredicate(format: "email = %@", email)
    //
    //        do{
    //            let fetch = try managedContext.fetch(fetchRequest)
    //            let dataToUpdate = fetch[0] as! NSManagedObject
    //            dataToUpdate.setValue(damageName, forKey: "damage_name")
    //            dataToUpdate.setValue(merekLaptop, forKey: "merek_laptop")
    //            dataToUpdate.setValue(tipeLaptop, forKey: "tipe_laptop")
    //
    //            try managedContext.save()
    //        }catch let err{
    //            print(err)
    //        }
    //
    //    }
    
    // fungsi menghapus by email user
    static func delete(_ pokemonName: String, navigationController: UINavigationController) {
        
        // referensi ke AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // fetch data to delete
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "MyPokemon")
        //           fetchRequest.predicate = NSPredicate()
        fetchRequest.value(forKey: pokemonName)
        
        do {
            let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
            managedContext.delete(dataToDelete)
            
            try managedContext.save()
        } catch let err as NSError {
            AlertHelper.showGeneralAlert(message: err.localizedDescription, navigationController: navigationController)
        }
        
    }
}

//
//  DetailPokemonInteractor.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 09/02/23.
//

import UIKit

class DetailPokemonInteractor: DetailPokemonInteractorProtocol {
    weak var presenter: DetailPokemonPresenterProtocol?
    
    private let services = URLSessionClient(urlSession: URLSession(configuration: .ephemeral))
    func fetchDetailPokemon(byId: String, navigationController: UINavigationController) {
        GeneralLoading.showLoading(getNavigation: navigationController)
        services.getDetailPokemon(urlStr: "https://pokeapi.co/api/v2/pokemon/\(byId)") { result in
            switch result {
            case .success(let success):
                self.presenter?.getDetailPokemon(data: success)
                DispatchQueue.main.async {
                    GeneralLoading.hideLoading(getNavigation: navigationController)
                }
            case .failure(let failure):
                AlertHelper.showGeneralAlert(message: failure.localizedDescription, navigationController: navigationController)
            }
        }
    }
    
    func saveMyPokemon(name: String, imageUrl: String, navigationController: UINavigationController) {
        CoreDataManager.save(pokemonName: name, imageUrl: imageUrl, navigationController: navigationController) { result in
            switch result {
            case .success(let success):
                AlertHelper.showGeneralAlert(message: "\(success) saved successfully", navigationController: navigationController)
            case .failure(let failure):
                AlertHelper.showGeneralAlert(message: failure.localizedDescription, navigationController: navigationController)
            }
        }
    }
    
    /*
     func save(name: String, data: [String]) {
         let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         let newEntity =  NSEntityDescription.entity(forEntityName: "HistoryDamage", in: managedContext)!
         let newHistory =  NSManagedObject(entity: newEntity, insertInto: managedContext)
         newHistory.setValue(name, forKey: "history_name")
         newHistory.setValue(data, forKey: "damage_list")
         
         do {
             try managedContext.save()
             self.navigationController?.popViewController(animated: true)
         } catch let error as NSError {
             print("Could not save \(error)")
         }
     }
     
     // fungsi refrieve semua data
     func retrieve() -> [UserModel]{
         
         var users = [UserModel]()
         
         // referensi ke AppDelegate
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         
         // managed context
         let managedContext = appDelegate.persistentContainer.viewContext
         
         // fetch data
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
         
         do{
             let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
             
             result.forEach{ user in
                 users.append(
                     UserModel(
                         id: user.value(forKey: "damage_id") as! String,
                         name: user.value(forKey: "damage_name") as! String,
                         merek: user.value(forKey: "merek_laptop") as! String,
                         tipe: user.value(forKey: "tipe_laptop") as! String
                     )
                 )
             }
         }catch let err{
             print(err)
         }
         
         return users
         
     }
     
     func update(_ damageName:String, _ merekLaptop:String, _ tipeLaptop:String){
         
         // referensi ke AppDelegate
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         
         // managed context
         let managedContext = appDelegate.persistentContainer.viewContext
         
         // fetch data to delete
         let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
         //           fetchRequest.predicate = NSPredicate(format: "email = %@", email)
         
         do{
             let fetch = try managedContext.fetch(fetchRequest)
             let dataToUpdate = fetch[0] as! NSManagedObject
             dataToUpdate.setValue(damageName, forKey: "damage_name")
             dataToUpdate.setValue(merekLaptop, forKey: "merek_laptop")
             dataToUpdate.setValue(tipeLaptop, forKey: "tipe_laptop")
             
             try managedContext.save()
         }catch let err{
             print(err)
         }
         
     }
     
     // fungsi menghapus by email user
     func delete(_ damageId: String){
         
         // referensi ke AppDelegate
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         
         // managed context
         let managedContext = appDelegate.persistentContainer.viewContext
         
         // fetch data to delete
         let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
         //           fetchRequest.predicate = NSPredicate()
         fetchRequest.value(forKey: damageId)
         
         do{
             let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
             managedContext.delete(dataToDelete)
             
             try managedContext.save()
         }catch let err{
             print(err)
         }
         
     }
     */
}

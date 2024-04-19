//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: "WaterDrops")
        
        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.danny.waterdropstoday")!
        let storeURL = containerURL.appendingPathComponent("WaterDrops.sqlite")
        let description = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [description]
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

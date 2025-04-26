import SwiftData

protocol StorageClientProtocol {
    func save<T: PersistentModel>(_ model: T) async
    func replaceAndSave<T: PersistentModel>(
        newModel: T,
        where shouldDelete: ((T) -> Bool)?
    ) async
    func fetchSingle<T: PersistentModel>() async -> T?
    func flushAllData() async
}

final class StorageClient: StorageClientProtocol {
    private var context: ModelContext?
    private var container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: ContractorInfoData.self,
                                           CompanyAddressData.self,
                                           BankAccountData.self,
                                           BankInfoData.self,
                                           ServiceInfoData.self
            )
            
            Task { @MainActor in
                context = container.mainContext
            }
        } catch {
            fatalError("Failed to set up SwiftData container: \(error)")
        }
    }
    
    @MainActor
    func save<T: PersistentModel>(_ model: T) async {
        guard let context else { return }
        context.insert(model)
        do {
            try context.save()
            print("✅ \(T.self) saved successfully!")
        } catch {
            print("❌ Failed to save \(T.self): \(error)")
        }
    }
    
    @MainActor
    func replaceAndSave<T: PersistentModel>(
        newModel: T,
        where shouldDelete: ((T) -> Bool)? = nil
    ) async {
        let fetchDescriptor = FetchDescriptor<T>()
        
        guard let context else { return }
        do {
            let existingObjects = try context.fetch(fetchDescriptor)
            
            for object in existingObjects {
                if shouldDelete?(object) ?? true { // delete all if no filter is provided
                    context.delete(object)
                }
            }
            
            context.insert(newModel)
            try context.save()
        } catch {
            print("❌ Failed to replace and save \(T.self): \(error)")
        }
    }
    
    @MainActor
    func fetchSingle<T: PersistentModel>() -> T? {
        let fetchDescriptor = FetchDescriptor<T>()
        guard let context else { return nil }
        do {
            let results = try context.fetch(fetchDescriptor)
            return results.first
        } catch {
            return nil
        }
    }
    
    @MainActor
    func flushAllData() async {
        guard let context else { return }
        
        do {
            try flush(ContractorInfoData.self)
            try flush(CompanyAddressData.self)
            try flush(BankAccountData.self)
            try flush(BankInfoData.self)
            try flush(ServiceInfoData.self)
            
            try context.save()
            print("✅ All data flushed successfully!")
        } catch {
            print("❌ Failed to flush data: \(error)")
        }
    }

    private func flush<T: PersistentModel>(_ type: T.Type) throws {
        guard let context else { return }
        let fetchDescriptor = FetchDescriptor<T>()
        let objects = try context.fetch(fetchDescriptor)
        
        for object in objects {
            context.delete(object)
        }
    }
}


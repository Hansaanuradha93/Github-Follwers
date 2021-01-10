import Foundation

// MARK: PersistenceActionType
enum PersistenceActionType {
    case add, remove
}


// MARK: - PersistenceManager
enum PersistenceManager {
    
    // MARK: Properties
    static private let defaults = UserDefaults.standard
    
    // MARK: Enums
    enum Keys {
        static let favourites = "favourites"
    }
}


// MARK: - Private Methods
extension PersistenceManager {
    
    static func updateWith(favourite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavourites { result in
            switch result {
            case .success(var favourites):
                switch actionType {
                case .add:
                    guard !favourites.contains(favourite) else {
                        completed(.alreadyInFavourites)
                        return
                    }
                    favourites.append(favourite)
                    
                case .remove:
                    favourites.removeAll { $0 == favourite }
                }
                
                completed(save(favourites: favourites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveFavourites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(favourites))
        } catch {
            completed(.failure(.unableToFavourute))
        }
    }
    
    
    static func save(favourites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourites)
            defaults.set(encodedFavourites, forKey: Keys.favourites)
            return nil
        } catch {
            return .unableToFavourute
        }
    }
}

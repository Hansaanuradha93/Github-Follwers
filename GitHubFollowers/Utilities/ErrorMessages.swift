import Foundation

enum GFError: String, Error {
    
    case invalidUsername        = "This username created an invalid request. Please try again."
    case unableToComplete       = "Unable to complete the request. Please check your internet connection."
    case invalidResponse        = "Invalid response from the server. Please try again"
    case invalidData            = "Data recieved from the server is invalid. Please try again."
    case unableToFavourute      = "There was an error favouriting this user. Please try again."
    case alreadyInFavourites    = "This user is already in your favourite list."
    
}

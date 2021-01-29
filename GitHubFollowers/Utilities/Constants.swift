import UIKit

// MARK: - SFSymbols
enum SFSymbols {
    static let location = UIImage(systemName: "mappin.and.ellipse")
    static let repos = UIImage(systemName: "folder")
    static let gists = UIImage(systemName: "text.alignleft")
    static let followers = UIImage(systemName: "heart")
    static let followings = UIImage(systemName: "person.2")
}
            
            
// MARK: - Images
enum Images {
    static let ghLogo = UIImage(named: "gh-logo")
    static let placeHolder = UIImage(named: "avatar-placeholder")
    static let emptyState = UIImage(named: "empty-state-logo")
}
            
            
// MARK: - ScreenSize
enum ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}


// MARK: - DeviceTypes
enum DeviceTypes {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale

    static let isiPhoneSE = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}


// MARK: - Strings
struct Strings {
    
    // Titles
    static let search = "Search"
    static let favourites = "Favourites"
    
    // Placeholders
    static let enterAUsername = "Enter a username"
    static let searchForAUsername = "Search for a username"
    
    // Alerts
    static let success = "Success!"
    static let somethingWentWrong = "Something went wrong!"
    static let unableToCompleteTheRequest = "Unable to complete request"
    static let emptyUsername = "Empty Username"
    static let pleaseEnterUsername = "Please enter a username. We need to know who to look for 😀."
    static let badSuffHappened = "Bad Stuff Happened"
    static let userDoesNotHaveFollowers = "This user doesn't have any followers. Go follow them 😀"
    static let youHaveSuccessfullyFavouritedTheUser = "You have successfully favourited this user 🎉"
    static let invalidUrl = "Invalid URL"
    static let theUrlAttachedToThisUserIsInvalid = "The url attached to this user is invalid."
    static let noFollowers = "No Followers"
    static let thisUserHasNoFollowers = "This user doesn't have any followers. Go follow this user 😀."
    static let unableToRemove = "Unable to remove"
    static let noFavouritesGoFollowSome = "No favourites?\nGo follow a user from follower screen 😀"
    
    // Labels
    static let publicRepos = "Public Repos"
    static let publicGists = "Public Gists"
    static let followers = "Followers"
    static let following = "Following"
    static let githubSince = "GitHub since"
    static let noLocation = "No Location"
    static let noBioAvailable = "No bio available"
    
    // Buttons
    static let ok = "Ok"
    static let getFollowers = "Get Followers"
    static let githubProfile = "Github Profile"
}


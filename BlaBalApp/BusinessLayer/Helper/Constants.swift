//
//  Constants.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import Foundation
import SwiftUI



struct Constants {
   
    @Environment(\.colorScheme) var colorScheme
    
//    static var colorScheme: ColorScheme = .dark // Assuming colorScheme is defined in Constants
    

    
    // MARK: - Buttons
    struct Buttons {
        static let login                    = "Log in"
        static let signup                   = "Sign up"
        static let email                    = "Continue with Email"
        static let facebook                 = "Continue with Facebook"
        static let apple                    = "Continue with Apple"
        static let cont                     = "Continue"
        static let done                     = "Done"
        static let editpic                  = "Edit profile picture"
        static let editprofile              = "Edit personal details"
        static let goingto                  = "Going to"
        static let back                     = "Back"
        static let startfrom                = "Start from"
        static let save                     = "Save"
        static let ok                       = "Ok"
        static let verifyId                 = "Verify my Id"
        static let verifyEmail              = "Verify Email"
        static let verifyPhone              = "Verify phone number"
        static let addbio                   = "Add a mini bio"
        static let addpref                  = "Add my preferences"
        static let addVehicle               = "Add vehicle"
        static let logout                   = "Logout"
        static let getVehicleInfo           = "Your Vehicles"
        static let changePassword           = "Change Password"
        static let verifyNumber             = "Verify Phone Number"
        static let searchRide               = "Search Ride"
        static let publishRide              = "Publish Ride"
        static let publisdedRides           = "Published Rides"
        static let bookedRides              = "Booked Rides"
        static let numberOfSeats            = "Select number of seats :"
        static let bookRide                 = "Book Ride"
    }
    // MARK: - Placeholderss
    struct Placeholders {
        static let emailplc                 = "Enter your email"
        static let passwordplc              = "Enter your password"
        static let fname                    = "Enter your first name"
        static let lname                    = "Enter your last name"
        static let phonenumber              = "Mobile phone"
        static let bio                      = "Post something about you..."
        static let travelPreference         = "Traveling preferences"
        static let post                     = "Postal address"
        static let plateNumber              = "PB 15U 4303"
        static let year                     = "2016"
        static let brand                    = "Maruti"
        static let model                    = "Swift"
        static let oldPassword              = "Old password"
        static let NewPassword              = "New password"
        static let ConfirmNewPassword       = "Confirm new password"
        static let description              = "Write ride description here :"
        static let estimatedTime            = "Write the estimated time here"
        static let enterAmount              = "Enter Amount"
        static let searchHere               = "Search Location here"
    }
    // MARK: - Headers
    struct Header {
        static let login                    = "Login"
        static let signup                   = "SignUp"
        static let travel                   = "Your future travel plans will appear here."
        static let seats                    = "Number of seats to book"
        static let publishSeats             = "Number of seats to publish"
        static let pick                     = "Pick-up"
        static let details                  = "Edit Personal Details"
        static let changePassword           = "Change Password"
        static let searchLocation           = "Search Location"
        static let yourProfile              = "Your profile"
        static let about                    = "About you"
        static let vehicle                  = "Vehicles"
        static let registerVehicle          = "Register Vehicle"
        static let confirmPasscode          = "Confirm Passcode"
        static let startLocation            = "Choose Start Location"
        static let destinationLocation      = "Choose Destination"
        static let rideDetails              = "Ride Details"
        
    }
    // MARK: Texts
    struct Texts {
        static let pickride                 = "Your pick of rides at low prices"
        static let login                    = "How do you want to log in?"
        static let signup                   = "How do you want to sign up?"
        static let notamember               = "Not a member yet?"
        static let haveaccount              = "Already a member?"
        static let invalidPasswod           = "*invalid password"
        static let invalidEmail             = "*invalid email"
        static let validPasswod             = "*valid password"
        static let validEmail               = "*valid email"
        static let age                      = "* minimum age 14 year"
        static let travel                   = "Find the perfect ride from thousands of destinations, or publish to  share your travel costs."
        static let nomsg                    = "No message right now.Book or offer a ride to contact someone."
        static let newcomer                 = "New comer"
        static let confirm                  = "Confirm"
        static let deptTime                 = "Departure time"
        static let estTime                  = "Estimated time"
        static let value                    = "2 hours"
        static let passengers               = "Passengers"
        static let reachTime                = "Reach time"
        static let ridestatus               = "Ride status"
        static let totalPrice               = "Total price"
        static let model                    = "Model"
        static let vehicleNumber            = "Vehicle Number"
        static let Manufactureyear          = "Manufactured year"
        static let VehicleType              = "Vehicle Type"
        static let color                    = "Color"
        static let update                   = "Update"
        
    }
    // MARK: - Labels
    struct Labels {
        static let email                    = "Email"
        static let password                 = "Password"
        static let help                     = "Help"
        static let ok                       = "Ok"
        static let fname                    = "First name"
        static let lname                    = "Last name"
        static let gender                   = "Gender"
        static let bday                     = "Date Of Birth"
        static let title                    = ["Miss/Madam", "Sir", "Rather not say"]
        static let titles                   = "Title"
        static let search                   = "Search"
        static let publish                  = "Publish"
        static let ride                     = "Your rides"
        static let inbox                    = "Inbox"
        static let person                   = "Profile"
        static let phone                    = "Phone number"
        static let bio                      = "Bio"
        static let travelPreference         = "Travel preferences"
        static let address                  = "Postal address"
        static let selectCountry            = "Select country :"
        static let vehicleBrand             = "Vehicle brand"
        static let vehicleModel             = "Vehicle model"
        static let vehicleType              = "Vehicle type :"
        static let vehicleColor             = "Vehicle color :"
        static let year                     = "Manufactured year :"
        static let plateNumber              = "License plate number :"
        static let oldPassword              = "Old password"
        static let NewPassword              = "New password"
        static let ConfirmNewPassword       = "Confirm new password"
        
    }
    
    // MARK: - Images
    struct Images {
        static let travel                   = "travel"
        static let car                      = "car"
        static let road                     = "road"
        static let dest                     = "destination"
        static let image                    = "Image"
        static let carbg                    = "carbg"
        static let car2                     = "car2"
        static let blue                     = "download"
        static let white                    = "Bank"
    }
    

    
    // MARK: - Icons
    struct Icons {
        static let bgImage                  = "cars"
        static let mail                     = "envelope"
        static let apple                    = "apple.logo"
        static let cross                    = "xmark"
        static let back                     = "chevron.backward"
        static let rightChevron             = "chevron.right"
        static let eye                      = "eye.fill"
        static let eyeSlash                 = "eye.slash.fill"
        static let questionMark             = "questionmark.circle"
        static let facebook                 = "f.cursive.circle"
        static let square                   = "square"
        static let circle                   = "circle"
        static let squarecheckmark          = "checkmark.square.fill"
        static let pluscircle               = "plus.circle"
        static let minuscircle              = "minus.circle"
        static let magnifyingGlass          = "magnifyingglass"
        static let locationNorth            = "location.north.circle.fill"
        static let car                      = "car.2"
        static let bubble                   = "bubble.left.and.bubble.right.fill"
        static let perosn                   = "person.circle"
        static let perosncircle             = "person.circle.fill"
        static let person                   = "person"
        static let location                 = "location.fill"
        static let pencil                   = "pencil"
        static let calander                 = "calendar"
        static let star                     = "star.fill"
        static let starHollow               = "star"
        static let arrowRight               = "arrowshape.right.fill"
        static let quotes                   = "quote.closing"
        static let clock                    = "clock"
        static let phone                    = "phone.fill"
        static let personText               = "person.text.rectangle"
        static let checkmark                = "checkmark.seal.fill"
        static let carfill                  = "car.fill"
        static let rupeeSign                = "rupeesign"
        static let seat                     = "figure.seated.seatbelt"

    }
    // MARK: - Validations
    struct Validations {
        static let emailValidation          = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let emailFormat              = "SELF MATCHES %@"
        static let passwordValidation       = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^\\da-zA-Z]).{8,20}$"
    }
    // MARK: - Alert
    struct Alert {
        static let passwordDiscripti        = "Password must be atleast 8 character long. \n Password must contain atleat one capital letter and one small character.\nPassword must have atleast one special character. \n Password must contain one numeric value."
        static let passwordDiscription      = "Password must have : \n * 8 to 20 character. \n * Atleast one special character. \n * Atleast one capital alphabet and one small alphabet. \n * Atleast one integer or numeric value."
        static let invalidemail             = "Invalid email"
        static let invalidname              = "Invalid name"
        static let emptyfield               = "Field can't be empty"
        static let invalidName              = "Name is invalid"
        static let invalidPhone             = "Invalid phone number"
        static let failToSendOTP            = "Fail to send OTP. Please try again later."
        static let error                    = "Error"
        static let usrExist                 = "User already exist"
        static let userNotExist             = "Invalid User Password"
        static let success                  = "Success"
        static let vehicleAddSuccess        = "Vehicle Added Successfully"
        static let updateUserFail           = "Eroor While Updating User"
        static let updateUserSucess         = "User Updated Successfully"
        static let numberVerified           = "Phone Number Verified"
        static let ridePublishSuccess       = "Ride published successfully"
        static let rideCancelled            = "Ride Cancelled successfully"
        static let failToPublishRide        = "Error occur while publishing ride"
        static let failToCancel             = "Error occur while cancelling ride"
        static let warning                  = "Warning"
        static let deleteItem               = "Are you sure you want to delete this item?"
        static let delete                   = "Delete"
    }
    // MARK: - Urls
    struct Url {
        static let baseUrl                  = "http://192.180.2.134:3001/"
        static let signUpUrl                = baseUrl+"users"
        static let signOutUrl               = baseUrl+"users/sign_out"
        static let loginUrl                 = baseUrl+"users/sign_in"
        static let checkEmail               = baseUrl+"email_check"
        static let vehicleUrl               = baseUrl+"vehicles"
        static let getSpecificVehicleUrl    = baseUrl+"show_by_id"
        static let phoneVerify              = baseUrl+"verify"
        static let sendOTP                  = baseUrl+"phone"
        static let updatePassword           = baseUrl+"update_password"
        static let searchRide               = baseUrl+"search"
        static let publishRide              = baseUrl+"publishes"
        static let bookRide                 = baseUrl+"book_publish"
        static let cancelRide               = baseUrl+"cancel_publish"
        static let getBookedRides           = baseUrl+"booked_publishes"
        static let deleteVehicle            = baseUrl+"/"
        static let cancelBookedRide         = baseUrl+"cancel_booking"
        static let addImage                 = baseUrl+"user_images"
        static let createChat               = baseUrl+"chats"
        static let mapUrl                   = "https://maps.googleapis.com/maps/api/place/textsearch/json?query="
        static let fetchPublishRideUrl      = "https://maps.googleapis.com/maps/api/directions/json?origin="
        static let srcLong                  = "?source_longitude="
        static let srcLat                   = "&source_latitude="
        static let desLong                  = "&destination_longitude="
        static let desLat                   = "&destination_latitude="
        static let passCount                = "&passengers_count="
        static let dateUrl                  = "&date="
        static let email                    = "email"
        static let password                 = "password"
        static let currentPassword          = "current_password"
        static let confirmPassword          = "password_confirmation"
        static let fname                    = "first_name"
        static let lname                    = "last_name"
        static let dob                      = "dob"
        static let title                    = "title"
        static let phnnumber                = "phone_number"
        static let passcode                 = "passcode"
        static let confirmpass              = "Confirm"
        static let appjson                  = "application/json"
        static let conttype                 = "Content-Type"
        static let auth                     = "Authorization"
        static let token                    = "Token"
        static let userLoggedIN             = "userLoggedIn"
        static let vehicle                  = "vehicle"
        static let country                  = "country"
        static let vehicleNumber            = "vehicle_number"
        static let vehicleBrand             = "vehicle_brand"
        static let vehicleName              = "vehicle_name"
        static let vehicleType              = "vehicle_type"
        static let vehicleColor             = "vehicle_color"
        static let model                    = "vehicle_model_year"
        static let bio                      = "bio"
        static let travelPreference         = "travel_preferences"
        static let postalAddress            = "postal_address"
        static let sourceLong               = "source_longitude"
        static let sourceLat                = "source_latitude"
        static let destLong                 = "destination_longitude"
        static let destLat                  = "destination_latitude"
        static let passengerCount           = "passengers_count"
        static let date                     = "date"
        static let source                   = "source"
        static let destination              = "destination"
        static let publishId                = "publish_id"
        static let seats                    = "seats"
        static let time                     = "time"
        static let setPrice                 = "set_price"
        static let aboutRide                = "about_ride"
        static let vehicleId                = "vehicle_id"
        static let estimateTime             = "estimate_time"
        static let userData                 = "userData"
    
    }
    
    struct ImageUrl {
        
        static let mimeType                   = "image/jpeg"
        static let fileName                   = "image.jpg"
        static let fieldName                  = "image"
        static let multipart                  = "mmultipart/form-data; boundary="
        static let boundary                   = "boundary="
        static let formData                   = "Content-Disposition: form-data; name="
        
    }
    
    struct API {
        static let apiKey                   = "AIzaSyDUzn63K64-sXadyIwRJExCfMaicagwGq4"
    }
    
    struct DefaultValues {
        static let country                  = "Afganistan"
        static let vehicleColor             = "Black"
        static let vehicleType              = "Hatchback"
        static let noRatings                = "No ratings"
        static let noPhone                  = "unverified"
        static let bday                     = "dd/mm/yyyy"
        static let bio                      = "bio is empty"
        static let start                    = "Start From"
        static let dest                     = "Going to"
        static let unknown                  = "Unknown"
        static let selectVehicle            = "Select your vehicle"
        static let publish                  = "Publish"
        static let gaussianBlur             = "gaussianBlur"
        static let confirmBooking           = "confirm booking"
    }
    
    struct Errors {
        static let decodeerror              = "Can't decode the data"
        static let unexpected               = "Unexpected Response"
        static let signOut                  = "Signed Out successfully"
        static let cantConvertJson          = "Cannot convert data to JSON"
        static let imageUploadSuccess       = "Image upload Successfully"
        static let rideBookedSuccessfully   = "Ride Booked Successfully"
        static let errorUploadImage         = "Error while uploaing Image, try after sometime"
        static let cantBookRide             = "Can't Book Ride"
    }
    
    struct UserDefaultsKeys {
        static let userLoggedIn             = "userLoggedIn"
        static let userDataKey              = "UserDataKey"
    }
    
    struct JsonKey {
        static let vehicle                  = "vehicle"
        static let user                     = "user"
        static let publish                  = "publish"
        static let passenger                = "passenger"
    }
    
    
    
    // MARK: - Request Methods
    struct Methods {
        static let post                     = "POST"
        static let get                      = "GET"
        static let delete                   = "DELETE"
        static let put                      = "PUT"
        static let patch                    = "PATCH"
    }
    // MARK: - Errors
    struct Error {
        static let invalidUrl               = "Invalid Url"
        static let invalidDateFormat        = "Invalid date format"
       
    }
    // MARK: - DateFormat
    struct Date {
        static let dateFormat               = "dd/MM/yyyy"
        static let dateTimeFormat           =  "dd/MM/yyyy HH:mm a"
        static let timeFormat               = "hh:mm a"
        static let estimatedTime            = "HH:mm"
        static let estimatedTimeformat      = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        static let dateFormat2              = "EEE, d MMMM, h:mm a"
        static let dateIdentifier           = "en_US"
        static let stringToDateForamat      = "yyyy-MM-dd"
        static let outputDateFormat         = "MMMM d, yyyy"
    }
    // MARK: - Titles
    struct Titles {
        static let name                     = "What's your name?"
        static let dob                      = "What's your date of birth?"
        static let title                    = "How would you like to be addressed ?"
        static let phnNum                   = "Please input your mobile number"
    }
    // MARK: - Colors
    struct Colors {
        static let bluecolor                = /*@START_MENU_TOKEN@*/Color(red: 0.321, green: 0.501, blue: 0.927)/*@END_MENU_TOKEN@*/
        static let underline = LinearGradient(gradient: Gradient(colors: [.blue.opacity(0), .blue, .blue.opacity(0)]), startPoint: .leading, endPoint: .trailing)
    }
    
    struct MultipartFormData {
        static let mimeType                 = "image/jpeg"
        static let fileName                 = "image.jpg"
        static let fieldName                = "image"
        static let multipartformdata        = "multipart/form-data; boundary="
    }

   
//        struct TransparentBackground {
//            static var backgroundImage: String {
//                if colorScheme == .dark {
//                    return "background"
//                } else {
//                    return "bluebg"
//                }
//            }
//        }
    

    
    struct Arrays {
        static let country: [String]        =  ["Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Anguilla", "Antigua & Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia & Herzegovina", "Botswana", "Brazil", "British Virgin Islands", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Cape Verde", "Cayman Islands", "Chad", "Chile", "China", "Colombia", "Congo", "Cook Islands", "Costa Rica", "Cote D Ivoire", "Croatia", "Cruise Ship", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Estonia", "Ethiopia", "Falkland Islands", "Faroe Islands", "Fiji", "Finland", "France", "French Polynesia", "French West Indies", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guam", "Guatemala", "Guernsey", "Guinea", "Guinea Bissau", "Guyana", "Haiti", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Isle of Man", "Israel", "Italy", "Jamaica", "Japan", "Jersey", "Jordan", "Kazakhstan", "Kenya", "Kuwait", "Kyrgyz Republic", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Mauritania", "Mauritius", "Mexico", "Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Namibia", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Norway", "Oman", "Pakistan", "Palestine", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russia", "Rwanda", "Saint Pierre & Miquelon", "Samoa", "San Marino", "Satellite", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "South Africa", "South Korea", "Spain", "Sri Lanka", "St Kitts & Nevis", "St Lucia", "St Vincent", "St. Lucia", "Sudan", "Suriname", "Swaziland", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor L'Este", "Togo", "Tonga", "Trinidad & Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks & Caicos", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "Uruguay", "Uzbekistan", "Venezuela", "Vietnam", "Virgin Islands (US)", "Yemen", "Zambia", "Zimbabwe"]
        
        static let vehicleType: [String]           = ["Hatchback", "Sedan", "Convertible", "Estate", "SUV", "Station Wagon"]
        static let vehicleColors                   = ["Black", "White", "Silver", "Gray", "Blue", "Red", "Green", "Yellow", "Orange", "Brown", "Beige", "Gold", "Bronze", "Copper", "Maroon", "Navy", "Charcoal", "Gunmetal", "Burgundy", "Dark Blue"]

    }

 
   
}

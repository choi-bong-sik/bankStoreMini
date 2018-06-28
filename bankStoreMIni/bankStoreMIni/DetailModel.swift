//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on June 28, 2018

import UIKit

class DetailModel: NSObject {
    var advisories : [AnyObject]!
    var appletvScreenshotUrls : [AnyObject]!
    var artistId : Int!
    var artistName : String!
    var artistViewUrl : String!
    var artworkUrl100 : String!
    var artworkUrl512 : String!
    var artworkUrl60 : String!
    var averageUserRating : Float!
    var averageUserRatingForCurrentVersion : Int!
    var bundleId : String!
    var contentAdvisoryRating : String!
    var currency : String!
    var currentVersionReleaseDate : String!
    var descriptionField : String!
    var features : [AnyObject]!
    var fileSizeBytes : String!
    var formattedPrice : String!
    var genreIds : [String]!
    var genres : [String]!
    var ipadScreenshotUrls : [AnyObject]!
    var isGameCenterEnabled : Bool!
    var isVppDeviceBasedLicensingEnabled : Bool!
    var kind : String!
    var languageCodesISO2A : [String]!
    var minimumOsVersion : String!
    var price : Int!
    var primaryGenreId : Int!
    var primaryGenreName : String!
    var releaseDate : String!
    var releaseNotes : String!
    var screenshotUrls : [String]!
    var sellerName : String!
    var sellerUrl : String!
    var supportedDevices : [String]!
    var trackCensoredName : String!
    var trackContentRating : String!
    var trackId : Int!
    var trackName : String!
    var trackViewUrl : String!
    var userRatingCount : Int!
    var userRatingCountForCurrentVersion : Int!
    var version : String!
    var wrapperType : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        
        artistId = dictionary["artistId"] as? Int
        artistName = dictionary["artistName"] as? String
        artistViewUrl = dictionary["artistViewUrl"] as? String
        artworkUrl100 = dictionary["artworkUrl100"] as? String
        artworkUrl512 = dictionary["artworkUrl512"] as? String
        artworkUrl60 = dictionary["artworkUrl60"] as? String
        averageUserRating = dictionary["averageUserRating"] as? Float
        averageUserRatingForCurrentVersion = dictionary["averageUserRatingForCurrentVersion"] as? Int
        bundleId = dictionary["bundleId"] as? String
        contentAdvisoryRating = dictionary["contentAdvisoryRating"] as? String
        currency = dictionary["currency"] as? String
        currentVersionReleaseDate = dictionary["currentVersionReleaseDate"] as? String
        descriptionField = dictionary["description"] as? String
        fileSizeBytes = dictionary["fileSizeBytes"] as? String
        formattedPrice = dictionary["formattedPrice"] as? String
        isGameCenterEnabled = dictionary["isGameCenterEnabled"] as? Bool
        isVppDeviceBasedLicensingEnabled = dictionary["isVppDeviceBasedLicensingEnabled"] as? Bool
        kind = dictionary["kind"] as? String
        minimumOsVersion = dictionary["minimumOsVersion"] as? String
        price = dictionary["price"] as? Int
        primaryGenreId = dictionary["primaryGenreId"] as? Int
        primaryGenreName = dictionary["primaryGenreName"] as? String
        releaseDate = dictionary["releaseDate"] as? String
        releaseNotes = dictionary["releaseNotes"] as? String
        sellerName = dictionary["sellerName"] as? String
        sellerUrl = dictionary["sellerUrl"] as? String
        trackCensoredName = dictionary["trackCensoredName"] as? String
        trackContentRating = dictionary["trackContentRating"] as? String
        trackId = dictionary["trackId"] as? Int
        trackName = dictionary["trackName"] as? String
        trackViewUrl = dictionary["trackViewUrl"] as? String
        userRatingCount = dictionary["userRatingCount"] as? Int
        userRatingCountForCurrentVersion = dictionary["userRatingCountForCurrentVersion"] as? Int
        version = dictionary["version"] as? String
        wrapperType = dictionary["wrapperType"] as? String
    }
    
}

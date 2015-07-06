//
//  Constants.swift
//  5thAve
//
//  Created by KEEVIN MITCHELL on 3/26/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
//typedef enum {
//    PAPHomeTabBarItemIndex = 0,
//    PAPEmptyTabBarItemIndex = 1,
//    PAPActivityTabBarItemIndex = 2
//} PAPTabBarControllerViewControllerIndex;
//

// Ilya     400680
// James    403902
// David    1225726
// Bryan    4806789
// Thomas   6409809
// Ashley   12800553
// Héctor   121800083
// Kevin    500011038
// Chris    558159381
// Matt     723748661


var kPAPParseEmployeeAccounts = ["400680","403902","1225726","4806789", "6409809", "12800553", "121800083", "500011038", "558159381", "723748661"]


//MARK: - NSUserDefaults

struct GlobalConstants {
    static let kPAPUserDefaultsActivityFeedViewControllerLastRefreshKey = "com.parse.Anypic.userDefaults.activityFeedViewController.lastRefresh"
    static let kPAPUserDefaultsCacheFacebookFriendsKey = "com.parse.Anypic.userDefaults.cache.facebookFriends"
    
    //MARK: -Launch URLs
    static let kPAPLaunchURLHostTakePicture = "camera"
    
    //MARK: -NSNotification
    static let PAPAppDelegateApplicationDidReceiveRemoteNotification = "com.parse.Anypic.appDelegate.applicationDidReceiveRemoteNotification"
    static let PAPUtilityUserFollowingChangedNotification = "com.parse.Anypic.utility.userFollowingChanged"
    static let PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification = "com.parse.Anypic.utility.userLikedUnlikedPhotoCallbackFinished"
    static let PAPUtilityDidFinishProcessingProfilePictureNotification = "com.parse.Anypic.utility.didFinishProcessingProfilePictureNotification"
    static let PAPTabBarControllerDidFinishEditingPhotoNotification = "com.parse.Anypic.tabBarController.didFinishEditingPhoto"
    static let PAPTabBarControllerDidFinishImageFileUploadNotification = "com.parse.Anypic.tabBarController.didFinishImageFileUploadNotification"
    static let PAPPhotoDetailsViewControllerUserDeletedPhotoNotification = "com.parse.Anypic.photoDetailsViewController.userDeletedPhoto"
    
    static let PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotification = "com.parse.Anypic.photoDetailsViewController.userLikedUnlikedPhotoInDetailsViewNotification"
    static let PAPPhotoDetailsViewControllerUserCommentedOnPhotoNotification = "com.parse.Anypic.photoDetailsViewController.userCommentedOnPhotoInDetailsViewNotification"
    
    //MARK: -User Info Keys
    
    static let PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey  = "liked"
    static let kPAPEditPhotoViewControllerUserInfoCommentKey = "comment"
    
    //MARK: -Installation Class
    static let kPAPInstallationUserKey = "user"
    
    //MARK: -- Activity Class
    
    static let kPAPActivityClassKey = "Activity"
    
    // MARK: -- Activity Class
    
    // Field keys
    
    static let kPAPActivityTypeKey = "type"
    static let kPAPActivityFromUserKey = "fromUser"
    static let kPAPActivityToUserKey = "toUser"
    static let kPAPActivityContentKey = "content"
    static let kPAPActivityPhotoKey = "photo"
    
    // Type values
    static let kPAPActivityTypeLike = "like"
    static let kPAPActivityTypeFollow = "follow"
    static let kPAPActivityTypeComment = "comment"
    static let kPAPActivityTypeJoined = "joined"
    
    // MARK: - User Class
    // Field keys
    static let kPAPUserDisplayNameKey = "displayName"
    static let kPAPUserFacebookIDKey = "facebookId"
    static let kPAPUserPhotoIDKey = "photoId"
    static let kPAPUserProfilePicSmallKey = "profilePictureSmall"
    static let kPAPUserProfilePicMediumKey = "profilePictureMedium"
    static let kPAPUserFacebookFriendsKey = "facebookFriends"
    static let kPAPUserAlreadyAutoFollowedFacebookFriendsKey = "userAlreadyAutoFollowedFacebookFriends"
    static let kPAPUserEmailKey = "email"
    static let kPAPUserAutoFollowKey = "autoFollow"
    
    // MARK: - Photo Class
    // Class key
    static let kPAPPhotoClassKey = "Photo"
    
    
    // Field key
    static let kPAPPhotoPictureKey = "image"
    static let kPAPPhotoThumbnailKey = "thumbnail"
    static let kPAPPhotoUserKey = "user"
    static let kPAPPhotoOpenGraphIDKey = "fbOpenGraphID"
    
    
    // MARK: - Cached Photo Attributes
    // Keys
    static let kPAPPhotoAttributesIsLikedByCurrentUserKey = "isLikedByCurrentUser"
    static let kPAPPhotoAttributesLikeCountKey = "likeCount"
    static let kPAPPhotoAttributesLikersKey = "likers"
    static let kPAPPhotoAttributesCommentCountKey = "commentCount"
    static let kPAPPhotoAttributesCommentersKey = "commenters"
    
    // MARK: - Cached User Attributes
    // keys
    static let kPAPUserAttributesPhotoCountKey = "photoCount"
    static let kPAPUserAttributesIsFollowedByCurrentUserKey = "isFollowedByCurrentUser"
    
    // MARK: - Push Notification Payload Keys
    static let kAPNSAlertKey = "alert"
    static let kAPNSBadgeKey = "badge"
    static let kAPNSSoundKey = "sound"
    
    
    // the following keys are intentionally kept short, APNS has a maximum payload limit
    static let kPAPPushPayloadPayloadTypeKey = "p"
    static let kPAPPushPayloadPayloadTypeActivityKey = "a"
    
    static let kPAPPushPayloadActivityTypeKey = "t"
    static let kPAPPushPayloadActivityLikeKey = "l"
    static let kPAPPushPayloadActivityCommentKey = "c"
    static let kPAPPushPayloadActivityFollowKey = "f"
    
    static let kPAPPushPayloadFromUserObjectIdKey = "fu"
    static let kPAPPushPayloadToUserObjectIdKey = "tu"
    static let kPAPPushPayloadPhotoObjectIdKey = "pid"
    
    
    
}



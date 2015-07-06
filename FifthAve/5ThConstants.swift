//
//  5ThConstants.swift
//  5thAve
//
//  Created by KEEVIN MITCHELL on 3/26/15.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation
let kPAPUserDefaultsActivityFeedViewControllerLastRefreshKey = "com.parse.Anypic.userDefaults.activityFeedViewController.lastRefresh"
let kPAPUserDefaultsCacheFacebookFriendsKey = "com.parse.Anypic.userDefaults.cache.facebookFriends"

//MARK: -Launch URLs
let kPAPLaunchURLHostTakePicture = "camera"

//MARK: -NSNotification
let PAPAppDelegateApplicationDidReceiveRemoteNotification = "com.parse.Anypic.appDelegate.applicationDidReceiveRemoteNotification"
let PAPUtilityUserFollowingChangedNotification = "com.parse.Anypic.utility.userFollowingChanged"
let PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification = "com.parse.Anypic.utility.userLikedUnlikedPhotoCallbackFinished"
let PAPUtilityDidFinishProcessingProfilePictureNotification = "com.parse.Anypic.utility.didFinishProcessingProfilePictureNotification"
let PAPTabBarControllerDidFinishEditingPhotoNotification = "com.parse.Anypic.tabBarController.didFinishEditingPhoto"
let PAPTabBarControllerDidFinishImageFileUploadNotification = "com.parse.Anypic.tabBarController.didFinishImageFileUploadNotification"
let PAPPhotoDetailsViewControllerUserDeletedPhotoNotification = "com.parse.Anypic.photoDetailsViewController.userDeletedPhoto"

let PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotification = "com.parse.Anypic.photoDetailsViewController.userLikedUnlikedPhotoInDetailsViewNotification"
let PAPPhotoDetailsViewControllerUserCommentedOnPhotoNotification = "com.parse.Anypic.photoDetailsViewController.userCommentedOnPhotoInDetailsViewNotification"

//MARK: -User Info Keys

let PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey  = "liked"
let kPAPEditPhotoViewControllerUserInfoCommentKey = "comment"

//MARK: -Installation Class
let kPAPInstallationUserKey = "user"

//MARK: -- Activity Class

let kPAPActivityClassKey = "Activity"

// MARK: -- Activity Class

// Field keys

let kPAPActivityTypeKey = "type"
let kPAPActivityFromUserKey = "fromUser"
let kPAPActivityToUserKey = "toUser"
let kPAPActivityContentKey = "content"
let kPAPActivityPhotoKey = "photo"

// Type values
let kPAPActivityTypeLike = "like"
let kPAPActivityTypeFollow = "follow"
let kPAPActivityTypeComment = "comment"
let kPAPActivityTypeJoined = "joined"

// MARK: - User Class
// Field keys
let kPAPUserDisplayNameKey = "displayName"
let kPAPUserFacebookIDKey = "facebookId"
let kPAPUserPhotoIDKey = "photoId"
let kPAPUserProfilePicSmallKey = "profilePictureSmall"
let kPAPUserProfilePicMediumKey = "profilePictureMedium"
let kPAPUserFacebookFriendsKey = "facebookFriends"
let kPAPUserAlreadyAutoFollowedFacebookFriendsKey = "userAlreadyAutoFollowedFacebookFriends"
let kPAPUserEmailKey = "email"
let kPAPUserAutoFollowKey = "autoFollow"

// MARK: - Photo Class
// Class key
let kPAPPhotoClassKey = "Photo"


// Field key
let kPAPPhotoPictureKey = "image"
let kPAPPhotoThumbnailKey = "thumbnail"
let kPAPPhotoUserKey = "user"
let kPAPPhotoOpenGraphIDKey = "fbOpenGraphID"


// MARK: - Cached Photo Attributes
// Keys
let kPAPPhotoAttributesIsLikedByCurrentUserKey = "isLikedByCurrentUser"
let kPAPPhotoAttributesLikeCountKey = "likeCount"
let kPAPPhotoAttributesLikersKey = "likers"
let kPAPPhotoAttributesCommentCountKey = "commentCount"
let kPAPPhotoAttributesCommentersKey = "commenters"

// MARK: - Cached User Attributes
// keys
let kPAPUserAttributesPhotoCountKey = "photoCount"
let kPAPUserAttributesIsFollowedByCurrentUserKey = "isFollowedByCurrentUser"

// MARK: - Push Notification Payload Keys
let kAPNSAlertKey = "alert"
let kAPNSBadgeKey = "badge"
let kAPNSSoundKey = "sound"


// the following keys are intentionally kept short, APNS has a maximum payload limit
let kPAPPushPayloadPayloadTypeKey = "p"
let kPAPPushPayloadPayloadTypeActivityKey = "a"

let kPAPPushPayloadActivityTypeKey = "t"
let kPAPPushPayloadActivityLikeKey = "l"
let kPAPPushPayloadActivityCommentKey = "c"
let kPAPPushPayloadActivityFollowKey = "f"

let kPAPPushPayloadFromUserObjectIdKey = "fu"
let kPAPPushPayloadToUserObjectIdKey = "tu"
let kPAPPushPayloadPhotoObjectIdKey = "pid"



let storyboard = UIStoryboard(name: "Main", bundle: nil)

//Round picture

let imageborder:CGFloat = 1.0
let imagebordercolor = UIColor.whiteColor().CGColor

// Popup Cart

let size = ["SMALL", "MEDIUM", "LARGE", "EXTRA"]
let color = ["BLACK", "YELLOW", "WHITE"]


// Menu settings

let MenuWidth:CGFloat = 280



// PFImageView

let defaultimage = UIImage(named: "EFM_Launch.jpg")
let defaultdata = UIImageJPEGRepresentation(defaultimage, 1.0)
let defaultfile = PFFile(name: "defaultimage.jpg", data: defaultdata)

let defaultpicture = PFFile(name: "profile.jpg", data: defaultdata)



// Shopping Cart Picker

let country = ["CHINA", "FRANCE", "UK", "USA"]
let month = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
let year = 2015
let maxyear = 4000

// PLACEHOLDER
let firstnameplaceholder = "FIRST NAME"
let lastnameplaceholder = "LAST NAME"
let addressplaceholder = "ADDRESS"
let cityplaceholder = "CITY"
let postalplaceholder = "POSTAL CODE"
let stateplaceholder = "STATE/REGION"

let cardnumberplaceholder = "CARD NUMBER"
let cvcplaceholder = "CVC CODE"



// Storyboard constant id about the view controller

let TimelineViewControllerID = "TimelineView"
let ShopDashboardID = "ShopDashboard"
let CommentTableViewID = "CommentTableView"
let SearchTableViewControllerID = "SearchTableViewController"
let ProfilViewControllerID = "ProfilViewController"
let EditProfileViewControllerID = "EditProfileViewController"
let SettingsViewControllerID = "SettingsViewController"

let ShoppingCartViewControllerID = "ShoppingCartViewController"
let CheckOutViewControllerID = "CheckOutViewController"
let WalletViewControllerID = "WalletViewController"

let CreditCardInfoViewControllerID = "CreditCardInfoViewController"
let BillingAddressViewControllerID = "BillingAddressViewController"
let ShippingAddressViewControllerID = "ShippingAddressViewController"

let ListViewControllerID = "ListViewController"


let FlyOutMenuID = "FlyOutMenu"
let MainNavigationControllerID = "MainNavigationController"
let SettingsNavigationControllerID = "SettingsNavigationController"

let Main5THViewControllerID = "Main5THViewController"
let MainTimelineCellID = "MainTimelineCell"
let MainTimelineHeaderCellID = "MainTimelineHeaderCell"
let CommentCellID = "CommentCell"
let MenuCellID = "MenuCell"
let SearchCellID = "SearchCell"
let HeaderSearchCellID = "HeaderSearchCell"
let ShopDashCellID = "ShopDashCell"
let ClosetCollectionCellID = "ClosetCollectionCell"
let ClosetHeaderCellID = "ClosetHeaderCell"
let FavoriteCollectionCellID = "FavoriteCollectionCell"
let PostsCollectionCellID = "PostsCollectionCell"
let ShoppingCartCellID = "ShoppingCartCell"
let BrandProfilTablecellID = "BrandProfilTablecell"
let BrandViewControllerID = "BrandViewController"
let BrandProfilTableviewID = "BrandProfilTableview"
let BrandProfilCollectionViewID = "BrandProfilCollectionView"
let BrandListCategorieID = "BrandListCategorie"
let AddToCartViewControllerID = "AddToCartViewController"


let BrandCollectionImageID = "BrandCollectionImage"
let BrandCollectionCellCartID = "BrandCollectionCellCart"
let BrandCategorieCellID = "BrandCategorieCell"

let BrandStoreViewControllerID = "BrandStoreViewController"
let BrandStoreCellID = "BrandStoreCell"

let AddToCartCellID = "AddToCartCell"

let CollectionCellOnlyImageID =  "CollectionCellOnlyImage"
let CollectionCellCanDeleteID = "CollectionCellCanDelete"
let CollectionCellWithPriceID = "CollectionCellWithPrice"



let NotificationTableCellFollowID = "NotificationTableCellFollow"
let NotificationTableCellActionID = "NotificationTableCellAction"
let NotificationViewControllerID = "NotificationViewController"

let DiscoverViewControllerID = "DiscoverViewController"
let DiscoverBrandID = "DiscoverBrand"
let DiscoverUserID = "DiscoverUser"


let PopoverTagID = "PopoverTag"

//  wishlist keyts
let wishListNotifKey = "wishListKey"
let collectionsNotifKey = "collectionsKey"




//
//  WebserviceConstants.h
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#ifndef WebserviceConstants_h
#define WebserviceConstants_h

typedef void (^webserviceSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^webseriveFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);


#define JSON_FLICKR_FEED @"jsonFlickrFeed"

#define FLICKER_BASE_URL @"https://api.flickr.com/services/"

#define FLICKER_PUBLIC_IMAGE_FETCH_METHOD @"feeds/photos_public.gne?"

#define FLICKER_JSON_RESPONSE_FORMAT @"format=json"

#endif /* WebserviceConstants_h */

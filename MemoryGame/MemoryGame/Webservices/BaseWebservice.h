//
//  BaseWebservice.h
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "WebserviceConstants.h"

static NSString *const HTTPPOST = @"POST";
static NSString *const HTTPGET = @"GET";


@interface BaseWebservice : NSObject {
	
	NSString *requestMethod;
	NSDictionary *parameters;
	NSString *webserviceMethod;
	NSString *contentType;
	NSString *contentLength;
	NSString *baseURL;
	NSURLRequestCachePolicy cachePolicy;
}

- (void)makeRequestWithWebserviceSuccessBlock:(webserviceSuccessBlock)successBlock
							  andFailureBlock:(webseriveFailureBlock)failureBlock;

@end

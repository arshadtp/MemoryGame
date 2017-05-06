//
//  BaseWebservice.m
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import "BaseWebservice.h"

#define ACCEPTABLE_CONTENT_TYPES @"application/x-javascript",@"text/plain",@"application/octet-stream",@"application/json",@"application/javascript"

@interface BaseWebservice ()

{
	AFHTTPRequestOperationManager *manager;
}
@end
@implementation BaseWebservice

- (void)makeRequestWithWebserviceSuccessBlock:(webserviceSuccessBlock)successBlock
								 andFailureBlock:(webseriveFailureBlock)failureBlock {
	
	if (baseURL.length == 0) {
		
		baseURL = FLICKER_BASE_URL;
	}
	
	NSString  *serviceUrlString = [NSString stringWithFormat:@"%@%@",baseURL,webserviceMethod];
	serviceUrlString = [serviceUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
	NSError *error;
	
	NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:requestMethod URLString:serviceUrlString parameters:parameters error:&error];
	request.cachePolicy = cachePolicy;
	
	AFHTTPRequestOperation *operation;
	operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	
	operation.responseSerializer = [AFCompoundResponseSerializer serializer];
	operation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:ACCEPTABLE_CONTENT_TYPES,nil];
	[operation setCompletionBlockWithSuccess:successBlock
									 failure:failureBlock];
	
	[[AFHTTPRequestOperationManager manager].operationQueue addOperation:operation];
	
}

@end

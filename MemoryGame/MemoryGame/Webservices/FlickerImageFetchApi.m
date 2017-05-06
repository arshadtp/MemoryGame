//
//  FlickerImageFetchApi.m
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import "FlickerImageFetchApi.h"
#import "Macro.h"

@implementation FlickerImageFetchApi

- (void) getFlickerImagesWithServiceSuccessBlock:(flickerImageFetchWevServicetSuccessBlock)successBlock andFailureBlock:(flickerImageFetchWevServiceFailureBlock)failureBlock andCachePolicy:(NSURLRequestCachePolicy) requestCachePolicy {
	
	webserviceMethod = [NSString stringWithFormat:@"%@%@",FLICKER_PUBLIC_IMAGE_FETCH_METHOD,FLICKER_JSON_RESPONSE_FORMAT];
	
	requestMethod = HTTPGET;
	cachePolicy = requestCachePolicy;
	
	[self makeRequestWithWebserviceSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
		
		NSString* responseString = [[NSString alloc] initWithData:responseObject encoding:operation.responseStringEncoding];
		
		NSString *responseJSONString =[Utility getJSONStringFromFlickerResponseString:responseString];
		NSError *error;
		NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:[responseJSONString dataUsingEncoding:operation.responseStringEncoding] options:1 error:&error];
		if (!error) {
			
			NSArray *imageArray = [self getImageURLArrayFromResponseDictionary:parsedObject];
			if (imageArray.count > 0) {
				successBlock([imageArray mutableCopy]);
				imageArray = nil;
				return;
			}
			failureBlock([Utility getFlickerDataCorruptedError]);
		} else {
			// retry if correpted data
			[self getFlickerImagesWithServiceSuccessBlock:successBlock andFailureBlock:failureBlock andCachePolicy:cachePolicy];
			[SVProgressHUD showWithStatus:NSLocalizedString(@"Retrying...", nil)];
		}
		
	} andFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
		failureBlock(error);
	}];
}

#define ITEMS @"items"
#define MEDIA @"media"
#define M @"m"

/**
 *  Method to parse and get image URL in array
 *
 *  @param responseDictionary flicker response dictionary
 *
 *  @return image URL string array
 */
- (NSArray *) getImageURLArrayFromResponseDictionary:(NSDictionary *) responseDictionary  {
	
	NSMutableArray *imageArray = [[NSMutableArray alloc]init];
	if (isDictionary(responseDictionary)) {
		NSArray *items = [responseDictionary valueForKey:ITEMS];
		for (NSDictionary *item in items) {
			if (isDictionary(item)) {
				NSDictionary *media = [item valueForKey:MEDIA];
				if (isDictionary(media)) {
					NSString *imageString = [media valueForKey:M];
					[imageArray addObject:imageString];
				}
			}
		}
	}
	return imageArray;
	
}

@end

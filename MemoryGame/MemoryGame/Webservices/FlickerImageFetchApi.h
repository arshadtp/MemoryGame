//
//  FlickerImageFetchApi.h
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseWebservice.h"

typedef void (^flickerImageFetchWevServicetSuccessBlock)(NSMutableArray *imageURLArray);
typedef void (^flickerImageFetchWevServiceFailureBlock)(NSError *error);

@interface FlickerImageFetchApi : BaseWebservice

/**
 *  Method to fetch image from flicker public image API
 *
 *  @param successBlock success call back block
 *  @param failureBlock failure call back block
 *  @param cachePolicy  request cache policy
 */
- (void) getFlickerImagesWithServiceSuccessBlock:(flickerImageFetchWevServicetSuccessBlock)successBlock andFailureBlock:(flickerImageFetchWevServiceFailureBlock)failureBlock andCachePolicy:(NSURLRequestCachePolicy) cachePolicy;
@end

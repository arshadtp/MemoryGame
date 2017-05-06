//
//  NSArray+Random.m
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import "NSArray+Random.h"

@implementation NSArray (Random)

- (id) randomObject {
	
	if ([self count] == 0) {
		
		return nil;
	}
	return [self objectAtIndex: arc4random() % [self count]];
}
@end

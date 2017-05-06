//
//  NSMutableArray+Shuffle.m
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"

@implementation NSMutableArray (Shuffle)

- (void)shuffle {
	
	NSUInteger count = [self count];
	
	for (NSUInteger i = 0; i < count; ++i) {
		
		NSUInteger remainingCount = count - i;
		NSUInteger exchangeIndex = (i + arc4random_uniform((unsigned int)remainingCount));
		[self exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
	}
}
@end

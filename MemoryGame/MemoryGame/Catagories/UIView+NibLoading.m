//
//  UIView+NibLoading.m
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import "UIView+NibLoading.h"

@implementation UIView (NibLoading)

+ (id) loadFromNib {
	NSString* nibName = NSStringFromClass([self class]);
	NSArray* elements = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
	for (NSObject* anObject in elements) {
		if ([anObject isKindOfClass:[self class]]) {
			return anObject;
		}
	}
	return nil;
}
@end

//
//  ImageView.m
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import "ImageView.h"
#import "FSImageLoader.h"

@implementation ImageView

- (id)initWithFrame:(CGRect)frame {
	
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
	}
	return self;
}

- (void)loadImageForUrl:(NSURL *)url {
	
	self.imageURL = url;
	[[FSImageLoader sharedInstance] loadImageForURL:url image:^(UIImage *image, NSError *error) {
		
		if (image) {
			
			[self setImage:image];
		}
	}];
}

- (void)loadImageForUrl:(NSURL *)url withSuccessBlock:(loadImageSuccessBlock) successBlock {
	
	self.imageURL = url;
	[[FSImageLoader sharedInstance] loadImageForURL:url image:^(UIImage *image, NSError *error) {
		
		if (image) {
			
			[self setImage:image];
		}
		successBlock(image, error);
	}];
	
}

+(BOOL) compareImageView:(ImageView *) firstImageView and:(ImageView *) secondImageView {
	
	if ([firstImageView.imageURL isEqual:secondImageView.imageURL]) {
		return YES;
	}
	return NO;
}
@end

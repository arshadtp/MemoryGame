//
//  ImageView.h
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loadImageSuccessBlock)(UIImage *image, NSError *error);

@interface ImageView : UIImageView

@property (nonatomic, strong) NSURL *imageURL;

/**
 *  method to load image from url
 *
 *  uses Ego cache if cached image
 *  @param url URL of the image which is to be loaded
 */

- (void)loadImageForUrl:(NSURL *)url;
/**
 *  method to load image from url with a callback method
 *
 *  uses Ego cache if cached image
 *  @param url          url URL of the image which is to be loaded
 *  @param successBlock success call back method
 */

- (void)loadImageForUrl:(NSURL *)url withSuccessBlock:(loadImageSuccessBlock) successBlock;

/**
 *  Method returns TRUE/FALSE depending upon the URL
 *
 *  Returns TRUE if image URL are equal
 *  @param firstImageView  image view of type MBImageView
 *  @param secondImageView image view of type MBImageView
 *
 *  @return TRUE/FALSE
 */
+(BOOL) compareImageView:(ImageView *) firstImageView and:(ImageView *) secondImageView;
@end

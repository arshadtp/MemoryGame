//
//  Utility.h
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

/**
 *  Method add shake animation for a given view
 *
 *  @param view view to which shake animation is to be added
 */
+ (void) addShakeAnimationToView:(UIView *) view;

/**
 *  Method to trim unwanted charecters from the Flicker response to make it a valid JSON
 *
 *  Flicker response JSON is in the fromat 'jsonFlickrFeed({...valid json....})'. Method trims 'jsonFlickrFeed(' and ')' from the response
 *  @param responseString string which is to be trimmed
 *
 *  @return JSON string
 */
+ (NSString *) getJSONStringFromFlickerResponseString:(NSString *) responseString;

/**
 *  Create a custom NSErron
 *
 *  @return NSError
 */
+ (NSError *) getFlickerDataCorruptedError;

+ (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message andLeftButtonTitle:(NSString *)leftButtonTitle andRightButtonTitle:(NSString *)rightButtonTitle withLeftButtonAction:(void (^)(void))leftButtonAction andRightButtonAction:(void (^)(void))rightButtonAction inViewController:(UIViewController *) viewController;
@end

//
//  Utility.m
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import "Utility.h"

@implementation Utility

#define JSON_FLICKR_FEED @"jsonFlickrFeed"

+ (void) addShakeAnimationToView:(UIView *)view {
	
	CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
	[shake setDuration:0.1];
	[shake setRepeatCount:2];
	[shake setAutoreverses:YES];
	[shake setFromValue:[NSValue valueWithCGPoint:
						 CGPointMake(view.center.x - 5,view.center.y)]];
	[shake setToValue:[NSValue valueWithCGPoint:
					   CGPointMake(view.center.x + 5, view.center.y)]];
	[view.layer addAnimation:shake forKey:@"position"];
}

+ (NSString *) getJSONStringFromFlickerResponseString:(NSString *) responseString {
	
	NSString *trimedResponseString =[responseString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:JSON_FLICKR_FEED]];
	
	if (trimedResponseString.length >2) {
		NSString *trimedString =[trimedResponseString substringWithRange:NSMakeRange(1, [trimedResponseString length]-2)];
		return trimedString;
	}
	return trimedResponseString;
}

+ (NSError *) getFlickerDataCorruptedError {
	
	return [NSError errorWithDomain:@"Corrupted Data" code:333 userInfo:@{NSLocalizedDescriptionKey:@"Response data is not in correct format"}];
}

+ (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message andLeftButtonTitle:(NSString *)leftButtonTitle andRightButtonTitle:(NSString *)rightButtonTitle withLeftButtonAction:(void (^)(void))leftButtonAction andRightButtonAction:(void (^)(void))rightButtonAction inViewController:(UIViewController *) viewController
{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	
	if (leftButtonTitle)
	{
		UIAlertAction *leftAction = [UIAlertAction actionWithTitle:leftButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
			leftButtonAction();
		}];
		[alertController addAction:leftAction];
	}
	
	if (rightButtonTitle)
	{
		UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
			rightButtonAction();
		}];
		[alertController addAction:rightAction];
	}
	[viewController presentViewController:alertController animated:YES completion:nil];
}
@end

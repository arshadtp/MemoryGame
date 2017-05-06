//
//  UIView+NibLoading.h
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NibLoading)

/**
*  method to load nib for a perticular View
*
*  @return view object
*/
+ (id) loadFromNib;
@end

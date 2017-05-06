//
//  TimerView.h
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const TimerCompletedNotification = @"timer expired";

@interface TimerView : UIView

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

/**
 *  Method to show a cound down timer
 *
 *  Also it fires notification when complete
 *  @param timeInterval : inteval in Seconds
 */
- (void) showTimerWithTimeInterVal:(NSTimeInterval) timeInterval;

/**
 *  Hide timer from its super view by setting its height contrain to zero
 *
 */
- (void) hideTimer;
@end

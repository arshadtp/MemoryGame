//
//  MBTimerView.m
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import "TimerView.h"
#import "UIView+NibLoading.h"
#import "Constants.h"
#define PICKER_VISIBLE_HEIGHT 216

@interface TimerView () {
	
	NSTimer *timer;
}
	
@property (nonatomic) NSTimeInterval maxTimeInterval;
@end

@implementation TimerView

- (id)initWithFrame:(CGRect)frame {
	
    self = [super initWithFrame:frame];
    if (self) {
		
        // Initialization code
    }
    return self;
}

// Load custom Nib into Placeholder view
- (id) awakeAfterUsingCoder:(NSCoder*)aDecoder {
	
    BOOL isJustAPlaceholder = ([[self subviews] count] == 0);
    if (isJustAPlaceholder) {
		
        TimerView* theRealThing = [[self class] loadFromNib];
		
		self.translatesAutoresizingMaskIntoConstraints = NO;
		theRealThing.translatesAutoresizingMaskIntoConstraints = NO;
		return theRealThing;
    }
    return self;
}

- (void) showTimerWithTimeInterVal:(NSTimeInterval) timeInterval {
	
	_timerLabel.text = [NSString stringWithFormat:@"%d",(int)timeInterval];
	[self layoutIfNeeded];
	self.hidden = NO;
	//_heightConstraint.constant = PICKER_VISIBLE_HEIGHT;
	_maxTimeInterval = timeInterval;
	timer = [NSTimer scheduledTimerWithTimeInterval:MIN_TIMER_INTERVAL target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}


/**
 *  Timer selector method. 
 *  Update the time text, also fires notification when timer expires
 */
- (void) countDown {
	
	_maxTimeInterval --;
	if (_maxTimeInterval == 0) {
		[timer invalidate];
		[[NSNotificationCenter defaultCenter] postNotificationName:TimerCompletedNotification object:nil];
		[self hideTimer];
	}
	_timerLabel.text = [NSString stringWithFormat:@"%d",(int)_maxTimeInterval];

}

- (void) hideTimer {
	
	self.hidden = YES;
	//_heightConstraint.constant = ZERO_HEIGHT;

}
@end

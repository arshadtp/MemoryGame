//
//  GameCellCollectionViewCell.m
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import "GameCellCollectionViewCell.h"

@implementation GameCellCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
	
	self = [super initWithFrame:frame];
	if (self) {
		
		// Initialization code
	}
	return self;
}

- (void) setCellStatus:(BOOL) seen {
	self.invertedView.hidden = seen;
	self.gameImage.hidden = !seen;

}
- (void) flipImage {
	
	[UIView transitionWithView:self duration:0.65f
					   options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
						   
						   self.invertedView.hidden = !self.invertedView.hidden;
						   self.gameImage.hidden = !self.gameImage.hidden;
					   } completion:^(BOOL finished) {
						   // whatever you'd like to do immediately after the flip completes
					   }];
}

- (void) awakeFromNib {
	[super awakeFromNib];
	self.layer.borderColor = [[UIColor darkGrayColor] CGColor];
	self.layer.borderWidth = 1.0;
}
@end

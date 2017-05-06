//
//  GameCellCollectionViewCell.h
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageView.h"
@interface GameCellCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *invertedView;
@property (weak, nonatomic) IBOutlet ImageView *gameImage;
- (void) setCellStatus:(BOOL) seen;
- (void) flipImage;

@end

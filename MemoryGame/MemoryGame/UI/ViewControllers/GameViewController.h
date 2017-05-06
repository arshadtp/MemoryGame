//
//  ViewController.h
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageView.h"
#import "TimerView.h"

@interface GameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@property (weak, nonatomic) IBOutlet ImageView *questionImageView;
@property (weak, nonatomic) IBOutlet UIButton *startGameButton;
@property (weak, nonatomic) IBOutlet TimerView *timerView;
- (IBAction)newGameButtonAction:(id)sender;

@end


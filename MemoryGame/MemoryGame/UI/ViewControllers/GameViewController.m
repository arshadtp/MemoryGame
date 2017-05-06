//
//  ViewController.m
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#import "GameViewController.h"
#import "FlickerImageFetchApi.h"
#import "GameCellCollectionViewCell.h"
#import "NSMutableArray+Shuffle.h"
#import "NSArray+Random.h"
#import "Constants.h"

static int const TOTAL_CELLS = 9;
static int const MIN_OFFSET = 10;

typedef NS_ENUM(NSInteger, QuestionPosition) {
	TOP          = 1,
	BOTTOM     = 2
};

@interface GameViewController () {
	
	QuestionPosition questionPosition;
	NSUInteger tolatImageToBeLoaded;
	NSMutableArray *imageArray; // a sub set of flicker image array
	NSMutableArray *flickerImageArray; // image array retrieved from flicker

	__weak IBOutlet NSLayoutConstraint *questionViewLandScapeleadingContraint;
	__weak IBOutlet NSLayoutConstraint *questionViewPotraitBottomContraint;
	__weak IBOutlet NSLayoutConstraint *gameCollectionViewWidthContraint;
}

@end


@implementation GameViewController

#pragma Mark - View Related Methods
- (void)viewDidLoad {
	
	[super viewDidLoad];
	[self setInitialViewLayout];
	[self fetchFlickerImages];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerExpired) name:TimerCompletedNotification object:nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
	
	[super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
	[self.imageCollectionView reloadData];
}

- (void) dealloc {
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - #

/**
 *  Hide start game button, timer and question image view
 *  Fetch images from flicker
 *
 */
- (void) setInitialViewLayout {
	
	_startGameButton.hidden = YES;
	_questionImageView.hidden = YES;
	[_timerView hideTimer];
}


#pragma mark - Collection view delegate  methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	
	return flickerImageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	GameCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GameCellCollectionViewCell" forIndexPath:indexPath];
	// Load images asychronously
	NSString *imageURL = [flickerImageArray objectAtIndex:indexPath.row];
	[cell setCellStatus:![imageArray containsObject:imageURL]];
	[cell.gameImage loadImageForUrl:[NSURL URLWithString:imageURL] withSuccessBlock:[self didLoadImageFor:indexPath]];
	
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
				  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	return CGSizeMake(collectionView.frame.size.width/3, collectionView.frame.size.width/3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	
	GameCellCollectionViewCell *cell = (GameCellCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
	if (![imageArray containsObject:cell.gameImage.imageURL.absoluteString]) {
		return;
	}
	if ([ImageView compareImageView:_questionImageView and:cell.gameImage]) { // User selected correct image
		
		[cell flipImage];
		[self showNextImage];
		if ([self isUserWon]) {
			
			_startGameButton.enabled = YES;
			[self showUserWonAlert];
			[self setInitialViewLayout];
		}
		
	} else { // User selected incorrect image
		[Utility addShakeAnimationToView:cell];
	}
}

#pragma Mark - #

/**
 *  call back method when image is loaded
 *
 *  show start button if all image id loaded
 *  param index Path
 */
- (void(^)())didLoadImageFor:(NSIndexPath *)indexPath {

	return ^(UIImage *image, NSError *error){
		if (!error) {
			tolatImageToBeLoaded --;
		}
		if (tolatImageToBeLoaded == 0) {
			_startGameButton.hidden = NO;
			[SVProgressHUD dismiss];
		}
	};
}

#pragma Mark - Game Logic

/**
 *  Start game button action
 *
 *  @param sender id
 */
- (IBAction)newGameButtonAction:(id)sender {
	
	[self startGame];
	_startGameButton.enabled = NO;
}

/**
 *  Game start logic
 *  reload and shuffle image array
 *  reload colection view
 *  show timer
 */
- (void) startGame {
	
	// reload and shuffle image array
	[flickerImageArray shuffle];
	// reload colection view
	[_imageCollectionView reloadData];
	
	tolatImageToBeLoaded = flickerImageArray.count;
	
	_questionImageView.hidden = YES;
	// show timer
	[_timerView showTimerWithTimeInterVal:DEFAULT_TIMER_EXPIRATION_TIME];
	//shift collection view to bottom
	
}

/**
 *  Selector method called when timer is expired
 *  Flip image view and show question
 */
- (void) timerExpired {
	
	imageArray = [[NSMutableArray alloc] initWithArray:flickerImageArray];
	[self flipAllImageView];
	[self showQuestionImageView];
}

/**
 *  Method flips all collection view images
 */
- (void) flipAllImageView {
	
	[[_imageCollectionView visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		if ([obj isKindOfClass:[GameCellCollectionViewCell class]]) {
			GameCellCollectionViewCell *cell = (GameCellCollectionViewCell *)obj;
			[cell flipImage];
			cell.userInteractionEnabled = YES;
		}
	}];
}

/**
 *  Show a random image from image array
 */
- (void) showQuestionImageView {
	
	QuestionPosition pos = arc4random() % 2;
	[self setQuestionPosition:pos];
	
	_questionImageView.hidden = NO;
	[_questionImageView loadImageForUrl:[NSURL URLWithString:[imageArray randomObject]]];
}

- (void) setQuestionPosition:(QuestionPosition) position {
	
	questionPosition = position;
	if (position == TOP) {
		questionViewPotraitBottomContraint.constant = MIN_OFFSET;
		questionViewLandScapeleadingContraint.constant = MIN_OFFSET;
	} else {
		questionViewPotraitBottomContraint.constant = -(gameCollectionViewWidthContraint.constant+MIN_OFFSET+_questionImageView.frame.size.height);
		questionViewLandScapeleadingContraint.constant = -(gameCollectionViewWidthContraint.constant+MIN_OFFSET+_questionImageView.frame.size.width);
	}
}
/**
 *  Method to call when user successfully identfy an image
 *  Remove identifed URL from image array and show a random image from remaining array
 *
 */
- (void) showNextImage {
	
	[imageArray removeObject:[_questionImageView.imageURL absoluteString]];
	[self showQuestionImageView];
}

/**
 *  Return true if when user idetifies all image (image array count = 0)
 *
 *  @return TRUE or FALSE
 */
- (BOOL) isUserWon {
	
	if(imageArray.count == 0) {
		return YES;
	}
	return NO;
}

/**
 *   User won aler
 */
- (void) showUserWonAlert {
	
	[Utility showAlertWithTitle:NSLocalizedString(@"Congratzz!!!",nil) andMessage:NSLocalizedString(@"You Won. Would you like to try once more?",nil) andLeftButtonTitle:NSLocalizedString(@"NO",nil) andRightButtonTitle:NSLocalizedString(@"YES",nil) withLeftButtonAction:^{
		_questionImageView.hidden = YES;
		_startGameButton.hidden = NO;
		_startGameButton.enabled = YES;
	} andRightButtonAction:^{
		[self newGameButtonAction:self];

	} inViewController:self];
}

#pragma mark - #


/**
 *  Method fetches images from flicker
 */
- (void) fetchFlickerImages {
	
	[SVProgressHUD show];
	[SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
	FlickerImageFetchApi *webservice = [[FlickerImageFetchApi alloc] init];
	[webservice getFlickerImagesWithServiceSuccessBlock:^(NSMutableArray *imageURLArray) {
		
		//Shuffle image array
		[imageURLArray shuffle];
		//imitialize image arrays
		flickerImageArray = [imageURLArray subarrayWithRange:NSMakeRange(0, TOTAL_CELLS)].mutableCopy;
		
		tolatImageToBeLoaded = flickerImageArray.count;
		[_imageCollectionView reloadData];
		
	} andFailureBlock:^(NSError *error) {
		
		[SVProgressHUD dismiss];
		[Utility showAlertWithTitle:error.domain andMessage:error.localizedDescription andLeftButtonTitle:NSLocalizedString(@"RETRY", nil) andRightButtonTitle:nil withLeftButtonAction:^{
			[self fetchFlickerImages];
		} andRightButtonAction:nil inViewController:self];
	} andCachePolicy:NSURLRequestReturnCacheDataElseLoad];
}


@end

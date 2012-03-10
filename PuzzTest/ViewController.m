//
//  ViewController.m
//  PuzzTest
//
//  Created by Ren H on 12/02/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize playerImage = _playerImage;
@synthesize playerHolder = _playerHolder;
@synthesize targetImage = _targetImage;
@synthesize targetHolder = _targetHolder;
@synthesize rotationScore = _rotationScore;
@synthesize translationScore = _translationScore;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //PlayerとTargetを(未:ランダムに)配置。
    _playerImage.transform = CGAffineTransformMakeRotation(0.0);
    _playerHolder.transform = CGAffineTransformMakeTranslation(150.0, 250.0);
    _targetImage.transform = CGAffineTransformMakeRotation(0.5);
    _targetHolder.transform = CGAffineTransformMakeTranslation(30.0, 30.0);
    
    //変更後の初期位置,回転を保持。
    lastPlayerTransform = _playerImage.transform;
    lastPlayerHolderTransform = _playerHolder.transform;
    lastTargetTransform = _targetImage.transform;
    lastTargetHolderTransform = _targetHolder.transform;
    
    
    //ジェスチャーの登録
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] 
                                             initWithTarget:self action:@selector(didRotate:)];
    [self.view addGestureRecognizer:rotation];
    [rotation release];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] 
                                   initWithTarget:self action:@selector(didPan:)];
    [self.view addGestureRecognizer:pan];
    [pan release];
    
    /*
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] 
                                       initWithTarget:self action:@selector(didPinch:)];
    [self.view addGestureRecognizer:pinch];
    [pinch release];
    */
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


-(void)didRotate:(id)sender{
    UIRotationGestureRecognizer* rgr = (UIRotationGestureRecognizer*) sender;
	NSLog(@"rotate:%f", rgr.rotation);
    
    _playerImage.transform = CGAffineTransformRotate(lastPlayerTransform, rgr.rotation);
    if ([rgr state] == UIGestureRecognizerStateEnded){
        lastPlayerTransform = _playerImage.transform;
        [self checkRotation];
    }
    
}

-(void)didPan:(id)sender{
    UIPanGestureRecognizer *pgr = (UIPanGestureRecognizer *)sender;
    CGPoint point = [pgr translationInView:self.view];
    NSLog(@"Pan!!!%@", NSStringFromCGPoint(point));
    
    _playerHolder.transform = CGAffineTransformTranslate(lastPlayerHolderTransform, point.x, point.y);
    if ([pgr state] == UIGestureRecognizerStateEnded){
        lastPlayerHolderTransform = _playerHolder.transform;
        [self checkTranslation];
    }
    
}

-(void)didPinch:(id)sender{
    NSLog(@"Pinch!!");
}


-(void)checkRotation{
    CGFloat angle = atan2(lastPlayerTransform.b, lastPlayerTransform.a);
    CGFloat diffAngle = fabs(atan2(lastTargetTransform.b, lastTargetTransform.a) - angle);
    
    _rotationScore.text = [NSString stringWithFormat:@"Rotation: %f [%f]", diffAngle, angle];
}

-(void)checkTranslation{
    CGFloat x = lastPlayerHolderTransform.tx;
    CGFloat y = lastPlayerHolderTransform.ty;
    CGFloat diffx = lastTargetHolderTransform.tx - x;
    CGFloat diffy = lastTargetHolderTransform.ty - y;
    
    _translationScore.text = [NSString stringWithFormat:@"Translation: %f,%f [%f, %f]", diffx, diffy, x, y];
}

@end
//
//  ViewController.m
//  PuzzTest
//
//  Created by Ren Hirasawa on 12/02/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

//@synthesize uirotation = _uirotation;
@synthesize playerImage = _playerImage;
@synthesize playerHolder = _playerHolder;


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
    
    //初期の位置,回転を保持。
    lastPlayerTransform = _playerImage.transform;
    lastHolderTransform = _playerHolder.transform;
    
    
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
    }
    
}

-(void)didPan:(id)sender{
    UIPanGestureRecognizer *pgr = (UIPanGestureRecognizer *)sender;
    CGPoint point = [pgr translationInView:self.view];
    NSLog(@"Pan!!!%@", NSStringFromCGPoint(point));
    
    
    
    //CGAffineTransform *transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(point.x, point.y), CGAffineTransformMakeRotation(_playerImage.transform));
    //!CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformMakeTranslation(_playerImage.transform.tx, _playerImage.transform.ty), point.x, point.y);
    //![_playerImage setTransform:transform];
    
    //_playerImage.frame = CGRectMake(_playerImage.frame.origin.x + point.x, _playerImage.frame.origin.y + point.y, _playerImage.frame.size.width, _playerImage.frame.size.height);
    
    _playerHolder.transform = CGAffineTransformTranslate(lastHolderTransform, point.x, point.y);
    if ([pgr state] == UIGestureRecognizerStateEnded){
        lastHolderTransform = _playerHolder.transform;
    }
}

-(void)didPinch:(id)sender{
    NSLog(@"Pinch!!");
}
@end

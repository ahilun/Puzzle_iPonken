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
@synthesize answerLabel = _answerLabel;


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
    
    
    //ここから関数化？
    [self reGenerateProblem];
    /*
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
    */
    
    
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
        [self checkAnswer];
    }
    
}

-(void)didPan:(id)sender{
    UIPanGestureRecognizer *pgr = (UIPanGestureRecognizer *)sender;
    CGPoint point = [pgr translationInView:self.view];
    NSLog(@"Pan!!!%@", NSStringFromCGPoint(point));
    
    _playerHolder.transform = CGAffineTransformTranslate(lastPlayerHolderTransform, point.x, point.y);
    if ([pgr state] == UIGestureRecognizerStateEnded){
        lastPlayerHolderTransform = _playerHolder.transform;
        [self checkAnswer];
    }
    
}

-(void)didPinch:(id)sender{
    NSLog(@"Pinch!!");
}





//FIXME: checkXXXXは消す。流れの変更。
/*
-(void)checkRotation{
    CGFloat angle = atan2(lastPlayerTransform.b, lastPlayerTransform.a);
    CGFloat diffAngle = fabs(atan2(lastTargetTransform.b, lastTargetTransform.a) - angle);
    
    _rotationScore.text = [NSString stringWithFormat:@"Rotation: %f [%f]", diffAngle, angle];
    [self checkAnswer];
}
-(void)checkTranslation{
    CGFloat x = lastPlayerHolderTransform.tx;
    CGFloat y = lastPlayerHolderTransform.ty;
    CGFloat diffx = fabs(lastTargetHolderTransform.tx - x);
    CGFloat diffy = fabs(lastTargetHolderTransform.ty - y);
    
    _translationScore.text = [NSString stringWithFormat:@"Translation: %f,%f [%f, %f]", diffx, diffy, x, y];
    [self checkAnswer];
}
*/




-(void)displayRotation:(CGFloat)diffAngle
                 angle:(CGFloat)angle
{
    _rotationScore.text = [NSString stringWithFormat:@"Rotation: %f [%f]", diffAngle, angle];
}
-(void)displayTranslation:(CGFloat)diffX
                    diffY:(CGFloat)diffY
                        x:(CGFloat)x
                        y:(CGFloat)y
{
    _translationScore.text = [NSString stringWithFormat:@"Translation: %f,%f [%f, %f]", diffX, diffY, x, y];
}

-(void)checkAnswer{
    CGFloat thresholdAngle = 0.05;
    CGFloat thresholdTranslation = 2.0;
    
    CGFloat angle = atan2(lastPlayerTransform.b, lastPlayerTransform.a);
    CGFloat diffAngle = fabs(atan2(lastTargetTransform.b, lastTargetTransform.a) - angle);
    CGFloat x = lastPlayerHolderTransform.tx;
    CGFloat y = lastPlayerHolderTransform.ty;
    CGFloat diffX = fabs(lastTargetHolderTransform.tx - x);
    CGFloat diffY = fabs(lastTargetHolderTransform.ty - y);
    
    NSLog(@"checkAnswer");
    //angle:<0.05 t:<2
    if (diffAngle <= thresholdAngle && diffX <= thresholdTranslation && diffY <= thresholdTranslation){
        //_answerLabel.text = @"○";
        [[[UIAlertView alloc] initWithTitle:@"Result" message:@"正解です！\nScore:未実装" delegate:self cancelButtonTitle:@"もう一度挑戦" otherButtonTitles:nil, nil] show];
        [self reGenerateProblem];
        
    } else {
        //_answerLabel.text = @"×";
    }
    
    [self displayRotation:diffAngle angle:angle];
    [self displayTranslation:diffX diffY:diffY x:x y:y];
}

-(void)reGenerateProblem{
    //30 <= x <= 140
    //30 <= y <= 280
    //-3 <= a <= 3
    
    float x = [self getRandInt:30.0 max:140.0];
    float y = [self getRandInt:30.0 max:280.0];
    float a = [self getRandInt:-3000000.0 max:3000000.0] / 1000000.0;
    NSLog(@"PlayerReGenerate: x=%f, y=%f, a=%f", x, y, a);
    _playerImage.transform = CGAffineTransformMakeRotation(a);
    _playerHolder.transform = CGAffineTransformMakeTranslation(x, y);
    
    x = [self getRandInt:30.0 max:140.0];
    y = [self getRandInt:30.0 max:280.0];
    a = [self getRandInt:-3000000.0 max:3000000.0] / 1000000.0;
    _targetImage.transform = CGAffineTransformMakeRotation(a);
    _targetHolder.transform = CGAffineTransformMakeTranslation(x, y);
    NSLog(@"TargetReGenerate: x=%f, y=%f, a=%f", x, y, a);
    
    //変更後の初期位置,回転を保持。
    lastPlayerTransform = _playerImage.transform;
    lastPlayerHolderTransform = _playerHolder.transform;
    lastTargetTransform = _targetImage.transform;
    lastTargetHolderTransform = _targetHolder.transform;
}

-(float)getRandInt:(float)min max:(float)max {
    //From: http://d.hatena.ne.jp/craneto/20100721/1279677592
	static int randInitFlag;
	if (randInitFlag == 0) {
		srand(time(NULL));
		randInitFlag = 1;
	}
	return min + (float)(rand()*(max-min+1.0)/(1.0+RAND_MAX));
}

@end
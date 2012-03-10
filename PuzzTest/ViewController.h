//
//  ViewController.h
//  PuzzTest
//
//  Created by Ren H on 12/02/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    IBOutlet UIImageView *playerImage;
    IBOutlet UIView *playerHolder;
    CGAffineTransform lastPlayerTransform;
    CGAffineTransform lastPlayerHolderTransform;
    
    IBOutlet UIImageView *targetImage;
    IBOutlet UIView *targetHolder;
    CGAffineTransform lastTargetTransform;
    CGAffineTransform lastTargetHolderTransform;
    
    IBOutlet UILabel *rotationScore;
    IBOutlet UILabel *translationScore;
    IBOutlet UILabel *answerLabel;
    NSDate *startTime;
}

@property (retain, nonatomic) UIImageView *playerImage;
@property (retain, nonatomic) UIView *playerHolder;
@property (retain, nonatomic) UIImageView *targetImage;
@property (retain, nonatomic) UIView *targetHolder;
@property (retain, nonatomic) UILabel *rotationScore;
@property (retain, nonatomic) UILabel *translationScore;
@property (retain, nonatomic) UILabel *answerLabel;
//@property (retain, nonatomic) NSDate *startTime;

//-(void)checkRotation;       //FIXME:消す
//-(void)checkTranslation;    //FIXME:消す

-(void)displayRotation:(CGFloat)diffAngle
                 angle:(CGFloat)angle;
-(void)displayTranslation:(CGFloat)diffX
                    diffY:(CGFloat)diffY
                        x:(CGFloat)x
                        y:(CGFloat)y;
-(void)checkAnswer;
-(void)reGenerateProblem;
-(float)getRandInt:(float)min max:(float)max;

-(IBAction)clearHiScore;
@end

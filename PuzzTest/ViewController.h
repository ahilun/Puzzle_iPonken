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
}

@property (retain, nonatomic) UIImageView *playerImage;
@property (retain, nonatomic) UIView *playerHolder;
@property (retain, nonatomic) UIImageView *targetImage;
@property (retain, nonatomic) UIView *targetHolder;
@property (retain, nonatomic) UILabel *rotationScore;
@property (retain, nonatomic) UILabel *translationScore;

//@property (retain, nonatomic) CGAffineTransform lastTransform;

//-(IBAction)didRotate:(id)sender;
//-(IBAction)didSwipe:(id)sender;

-(void)checkRotation;
-(void)checkTranslation;
@end

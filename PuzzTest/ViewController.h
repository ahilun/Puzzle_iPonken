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
    CGAffineTransform lastHolderTransform;
}

@property (retain, nonatomic) UIImageView *playerImage;
@property (retain, nonatomic) UIView *playerHolder;
//@property (retain, nonatomic) CGAffineTransform lastTransform;

//-(IBAction)didRotate:(id)sender;
//-(IBAction)didSwipe:(id)sender;
@end

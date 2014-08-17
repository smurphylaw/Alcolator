//
//  BLCViewController.h
//  Alcolator
//
//  Created by Murphy on 8/16/14.
//  Copyright (c) 2014 Murphy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLCViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UILabel *beerCounter;

- (void)buttonPressed:(UIButton *)sender;
@end

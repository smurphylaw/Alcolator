//
//  BLCMainMenuViewController.m
//  Alcolator
//
//  Created by Murphy on 8/17/14.
//  Copyright (c) 2014 Murphy. All rights reserved.
//

#import "BLCMainMenuViewController.h"
#import "BLCViewController.h"
#import "BLCWhiskeyViewController.h"

@interface BLCMainMenuViewController ()

@property (weak, nonatomic) UIButton *wineButton;
@property (weak, nonatomic) UIButton *whiskeyButton;

@end

@implementation BLCMainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    // self.navigationItem.title = @"Alocator"; // Shows the title instead of 'Back'
    self.title = NSLocalizedString(@"Select Alcolator", @"Select Alcolator");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) winePressed:(UIButton *) sender {
    BLCViewController *wineVC = [[BLCViewController alloc] init];
    [self.navigationController pushViewController:wineVC animated:YES];
}

- (void) whiskeyPressed:(UIButton *) sender {
    BLCWhiskeyViewController *whiskeyVC = [[BLCWhiskeyViewController alloc] init];
    [self.navigationController pushViewController:whiskeyVC animated:YES];
}

- (void)loadView {
    self.wineButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.whiskeyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.wineButton setTitle:NSLocalizedString(@"Wine", @"wine") forState:UIControlStateNormal];
    [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey", @"whiskey") forState:UIControlStateNormal];
    
    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = [[UIView alloc] init];
    
    [self.view addSubview:self.wineButton];
    [self.view addSubview:self.whiskeyButton];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
   
    CGRect screenBounds = self.view.bounds;
    CGFloat padding = 20;
    
    CGFloat viewWidth = screenBounds.size.width - padding - padding;
    CGFloat viewHeight = screenBounds.size.height - 100 - padding;
    
    CGFloat itemWidth = viewWidth;
    CGFloat itemHeight = 44;
    
    self.wineButton.frame = CGRectMake(padding, viewHeight/2, itemWidth, itemHeight);
    
    CGFloat bottomOfWineButton = CGRectGetMaxY(self.wineButton.frame);
    self.whiskeyButton.frame = CGRectMake(padding, bottomOfWineButton + padding, itemWidth, itemHeight);

    
}

@end

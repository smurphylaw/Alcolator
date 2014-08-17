//
//  BLCViewController.m
//  Alcolator
//
//  Created by Murphy on 8/16/14.
//  Copyright (c) 2014 Murphy. All rights reserved.
//

#import "BLCViewController.h"

@interface BLCViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation BLCViewController

- (void)viewDidLoad
{
    // Calls the superclass' implementation
    [super viewDidLoad];
    
    // Set our primary view's background color to cyanColor
    self.view.backgroundColor = [UIColor redColor];
    
    // Tells the text field that 'self', this instance of 'BLCViewController' should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    
    // Set the background color for beerPercentTextField to white
    self.beerPercentTextField.backgroundColor = [UIColor lightGrayColor];
    
    // Set the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    
    // Tells 'self.beerCountSlider' that when its value changes, it should call '[self -sliderViewChange:]'
    // This is equivalent to connecting the IBAction
    [self.beerCountSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    self.beerCountSlider.minimumTrackTintColor = [UIColor yellowColor];
    
    // Set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    // Tells 'self.calculateButton' that when a finger is lifted from the button while still inside its bounds, to call '[self -buttonPressed:]'.
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate", @"Calculate command") forState:UIControlStateNormal];
    self.calculateButton.titleLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size:20.0f];
    self.calculateButton.tintColor = [UIColor whiteColor];
    
    // Tells the tap gesture recognizer to call '[self -tapGestureDidFire:]' when it detect a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // Gets rid of the minimum number of lines on the label
    self.resultLabel.numberOfLines = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextField *)sender {
    // Make sure the text is a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}

- (void)sliderValueChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    
    // Show and display slider number automatically
    int numberOfBeers = self.beerCountSlider.value;
    
    NSString *beerCountText = [NSString stringWithFormat:NSLocalizedString(@"Number of Beers: %d", nil), numberOfBeers];
    self.beerCounter.text = beerCountText;
    self.beerCounter.textColor = [UIColor whiteColor];
     
}

- (void)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
    // First, calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // Now, calculate the equivalent amount of wine...
    
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // Decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // Generate the result text, and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
    self.resultLabel.textColor = [UIColor whiteColor];
    self.resultLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

- (void) loadView {
    // Allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    // Allocate and initialize each of our views and the gesture recognizer
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    // Add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    // Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
    self.beerCounter = label;
    
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    // [UIApplication sharedApplication] is a Singleton object that can be thought
    // of as a global object for you to use. It has some information on the
    // app.
    
    /* if ([UIScreen mainScreen].bounds.size.height == 568) {
        // iPhone 5
    } else {
        // iPhone 4
    }
    */
    
    CGRect screenBounds = self.view.bounds;
    
    CGFloat viewWidth = screenBounds.size.width;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    BOOL isPhone = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
    
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        itemHeight = (isPhone) ? 44 : 88;
    } else {
        itemHeight = (isPhone) ? 22 : 44;
    }
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding + 10, itemWidth, itemHeight);
            
            
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
            
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.beerCounter.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfCountLabel = CGRectGetMaxY(self.beerCounter.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfCountLabel + padding, itemWidth, itemHeight * 4);
            
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
    
}

@end

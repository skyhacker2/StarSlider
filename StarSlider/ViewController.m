//
//  ViewController.m
//  StarSlider
//
//  Created by Eleven Chen on 15/7/17.
//  Copyright (c) 2015年 Eleven. All rights reserved.
//

#import "ViewController.h"
#include "StarSlider.h"

@interface ViewController ()
@property (nonatomic, strong) StarSlider* starSlider;
@property (nonatomic, strong) StarSlider* starSlider2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.starSlider = [[StarSlider alloc] initWithFrame:CGRectMake(20, 100, 150, 40)];
    [self.view addSubview:self.starSlider];
    
    self.starSlider2 = [[StarSlider alloc] init];
    [self.view addSubview:self.starSlider2];
}

- (void) updateViewConstraints
{
    NSDictionary* views = @{@"super": self.view,
                            @"starSlider": self.starSlider,
                            @"starSlider2": self.starSlider2};
    self.starSlider2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[starSlider2]-20-|"
                                                                     options:0
                                                                     metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[starSlider]-20-[starSlider2]"
                                                                      options:0
                                                                      metrics:0
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[starSlider2(==50)]"
                                                                     options:0
                                                                     metrics:0
                                                                        views:views]];
    
    [super updateViewConstraints];
}


@end

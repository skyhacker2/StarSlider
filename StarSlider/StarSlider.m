//
//  StarSlider.m
//  StarSlider
//
//  Created by Eleven Chen on 15/7/17.
//  Copyright (c) 2015年 Eleven. All rights reserved.
//

#import "StarSlider.h"

#define OFF_ART	[UIImage imageNamed:@"Star-White-Half.png"]
#define ON_ART	[UIImage imageNamed:@"Star-White.png"]

@interface StarSlider()

@property (assign, nonatomic) CGFloat starWidth;
@end

@implementation StarSlider

- (CGFloat) starWidth
{
    return self.bounds.size.width / 8.0f;
}


- (void) awakeFromNib
{
    [super awakeFromNib];
    [self initViews];
}

- (instancetype) init
{
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    
    return self;
}

- (void) initViews
{
    for (int i = 0; i < 5; i++) {
        UIImageView *view = [[UIImageView alloc] initWithImage:OFF_ART];
        [self addSubview:view];
    }
}

- (void) updateView
{
    self.backgroundColor = [UIColor blackColor];
    float offsetCenter = self.starWidth;
    for (UIImageView* imageView in self.subviews) {
        imageView.center = CGPointMake(offsetCenter, self.bounds.size.height/2);
        offsetCenter += self.starWidth*1.5f;
        [self addSubview:imageView];
    }
    
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"layoutSubviews %f %f", self.bounds.size.width, self.bounds.size.height);
    [self updateView];
}


- (void) updateValueAtPoint: (CGPoint) point
{
    NSInteger newValue = 0;
    UIImageView* changeView = nil;
    for (UIImageView* eatchItem in self.subviews) {
        NSLog(@"point x %f item x %f",point.x, eatchItem.frame.origin.x);
        if (point.x < eatchItem.frame.origin.x) {
            eatchItem.image = OFF_ART;
        } else {
            changeView = eatchItem;
            eatchItem.image = ON_ART;
            newValue++;
        }
    }
    NSLog(@"newValue %d", newValue);
    if (self.value != newValue) {
        self.value = newValue;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        
        // Animation
        [UIView animateWithDuration:0.15f
                         animations:^{
                             changeView.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.1f
                                              animations:^{
                                                  changeView.transform = CGAffineTransformIdentity;
                                              } completion:nil];
                         }];
    }
    
}

- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView:self];
    [self sendActionsForControlEvents:UIControlEventTouchDown];
    [self updateValueAtPoint:point];
    return YES;
}

- (BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.frame, point)) {
        [self sendActionsForControlEvents:UIControlEventTouchDragInside];
    } else {
        [self sendActionsForControlEvents:UIControlEventTouchDragOutside];
    }
    [self updateValueAtPoint:point];
    return YES;
}

- (void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.frame, point)) {
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else {
        [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
    }
}

- (void) cancelTrackingWithEvent:(UIEvent *)event
{
    [self sendActionsForControlEvents:UIControlEventTouchCancel];
}

@end

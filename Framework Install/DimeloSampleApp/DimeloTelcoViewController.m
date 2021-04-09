//
//  DimeloTelcoViewController.m
//  Dimelo
//
//  Created by Oleg Andreev on 19.09.2014.
//  Copyright (c) 2014 Dimelo. All rights reserved.
//

#import "Dimelo/Dimelo.h"
#import "DimeloTelcoViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DimeloTelcoViewController ()

@end

@implementation DimeloTelcoViewController {
    UIColor *_buttonColor;
    Dimelo *_dimelo;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Telecom";

    for (UIView* v in self.view.subviews) {
        if (v.tag == 100) {
            _buttonColor = v.backgroundColor;
            v.clipsToBounds = YES;
            v.layer.cornerRadius = 18.0;
        }
    }

    if (!_dimelo) {
        _dimelo = [Dimelo sharedInstance];
        _dimelo.embeddedAsFragment = YES;
        _dimelo.enableThreads = [[NSUserDefaults standardUserDefaults] boolForKey:@"rc_enable_threads"];
        _dimelo.tintColor = _buttonColor;
        _dimelo.backgroundView.backgroundColor = self.view.backgroundColor;
        UIView *lighterView = [[UIView alloc] initWithFrame:_dimelo.backgroundView.bounds];
        lighterView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        lighterView.translatesAutoresizingMaskIntoConstraints = YES;
        lighterView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.30f];
        [_dimelo.backgroundView addSubview:lighterView];
    }

    _dimelo.userIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey: @"rc_user_id"];

    UIView *logoView = [self.view viewWithTag:200];
    logoView.layer.cornerRadius = logoView.frame.size.height / 2.0f;
    logoView.clipsToBounds = YES;

    // add dimelo chat view as fragment
    UIViewController *vc = [_dimelo chatViewController];
    vc.view.frame = self.container.bounds;
    [self.container addSubview:vc.view];
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
    [vc becomeFirstResponder];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
@end

//
//  DimeloTelcoViewController.m
//  Dimelo
//
//  Created by Oleg Andreev on 19.09.2014.
//  Copyright (c) 2014 Dimelo. All rights reserved.
//

#import "Dimelo.h"
#import "DimeloTelcoViewController.h"
#import "DimeloTestAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface DimeloTelcoViewController ()<DimeloDelegate>

@end

@implementation DimeloTelcoViewController {
    UIColor* _buttonColor;
    Dimelo* _dimelo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Telecom" image:[UIImage imageNamed:@"Telco"] selectedImage:[UIImage imageNamed:@"TelcoSelected"]];

    for (UIView* v in self.view.subviews)
    {
        if (v.tag == 100)
        {
            _buttonColor = v.backgroundColor;
            v.clipsToBounds = YES;
            v.layer.cornerRadius = 18.0;
        }
    }

    UIView* logoView = [self.view viewWithTag:200];
    logoView.layer.cornerRadius = logoView.frame.size.height / 2.0f;
    logoView.clipsToBounds = YES;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (!_dimelo)
    {
        _dimelo = [[Dimelo sharedInstance] copy];
        _dimelo.delegate = self;
        _dimelo.title = @"MyTelecom Online Support";
        _dimelo.tintColor = _buttonColor;
        _dimelo.backgroundView.backgroundColor = self.view.backgroundColor;
        UIView* lighterView = [[UIView alloc] initWithFrame:_dimelo.backgroundView.bounds];
        lighterView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        lighterView.translatesAutoresizingMaskIntoConstraints = YES;
        lighterView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.30f];
        [_dimelo.backgroundView addSubview:lighterView];

        _dimelo.userMessageBackgroundColor = _buttonColor;
        _dimelo.userMessageTextColor = [UIColor whiteColor];

        _dimelo.agentMessageBackgroundColor = [UIColor whiteColor];
        _dimelo.agentMessageTextColor = [UIColor blackColor];
        _dimelo.agentNameColor = [UIColor colorWithWhite:0.0 alpha:0.7f];

        _dimelo.systemMessageBackgroundColor = [UIColor blackColor];
        _dimelo.systemMessageTextColor = [UIColor colorWithWhite:0.0 alpha:1.0];

        _dimelo.dateTextColor = [UIColor colorWithWhite:0.0 alpha:0.8f];
    }

    self.tabBarController.tabBar.tintColor = _buttonColor ?: self.view.backgroundColor;
}

- (void) openChat:(id)sender
{
    [_dimelo displayChatView];
}

- (IBAction) closeChat:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void) dimeloDisplayChatViewController:(Dimelo*)dimelo
{
    UIViewController* vc = [dimelo chatViewController];

    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeChat:)];

    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
    }

    [self presentViewController:vc animated:YES completion:^{}];
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end

//
//  DimeloBankViewController.m
//  Dimelo
//
//  Created by Oleg Andreev on 19.09.2014.
//  Copyright (c) 2014 Dimelo. All rights reserved.
//

#import "Dimelo.h"
#import "DimeloBankViewController.h"
#import "DimeloTestAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface DimeloBankViewController ()<DimeloDelegate>

@end

@implementation DimeloBankViewController {
    Dimelo* _dimelo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Bank" image:[UIImage imageNamed:@"Bank"] selectedImage:[UIImage imageNamed:@"BankSelected"]];

    for (UIView* v in self.view.subviews)
    {
        if (v.tag == 100)
        {
            v.clipsToBounds = YES;
            v.layer.cornerRadius = 4.0;
        }
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (!_dimelo)
    {
        _dimelo = [[Dimelo sharedInstance] copy];
        _dimelo.delegate = self;
        _dimelo.title = @"Local Bank Live Support";
        _dimelo.tintColor = self.view.backgroundColor;
        _dimelo.backgroundView.backgroundColor = self.view.backgroundColor;

        UIView* lighterView = [[UIView alloc] initWithFrame:_dimelo.backgroundView.bounds];
        lighterView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        lighterView.translatesAutoresizingMaskIntoConstraints = YES;
        lighterView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
        [_dimelo.backgroundView addSubview:lighterView];

        {
            UIImage* userBubble = [[UIImage imageNamed:@"DimeloBankUserBubble"]
                                   resizableImageWithCapInsets:UIEdgeInsetsMake(18, 19, 18, 36) resizingMode:UIImageResizingModeStretch];
            UIImage* agentBubble = [[UIImage imageNamed:@"DimeloBankAgentBubble"]
                                    resizableImageWithCapInsets:UIEdgeInsetsMake(18, 36, 18, 19) resizingMode:UIImageResizingModeStretch];

            _dimelo.userMessageBubbleImage   = [userBubble imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            _dimelo.agentMessageBubbleImage  = [agentBubble imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            _dimelo.systemMessageBubbleImage = [[[UIImage imageNamed:@"DimeloBankSystemBubble"]
                                          resizableImageWithCapInsets:UIEdgeInsetsMake(18, 36, 18, 19) resizingMode:UIImageResizingModeStretch]
                                         imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

            _dimelo.userAttachmentBubbleImage  = userBubble;
            _dimelo.agentAttachmentBubbleImage = agentBubble;
        }


        _dimelo.userMessageBackgroundColor = [UIColor colorWithWhite:1.0 alpha:0.95f];
        _dimelo.userMessageTextColor = [UIColor blackColor];

        _dimelo.agentMessageBackgroundColor = [UIColor colorWithWhite:1.0 alpha:0.90f];
        _dimelo.agentMessageTextColor = [UIColor blackColor];
        _dimelo.agentNameColor = [UIColor colorWithWhite:1.0 alpha:0.66f];

        _dimelo.systemMessageBackgroundColor = [UIColor colorWithWhite:1.0 alpha:0.90f];
        _dimelo.systemMessageTextColor = [UIColor colorWithWhite:1.0 alpha:0.97f];

        _dimelo.loadMoreMessagesButtonTextColor = [UIColor whiteColor];
        _dimelo.dateTextColor = [UIColor colorWithWhite:1.0 alpha:0.7f];
    }

    self.tabBarController.tabBar.tintColor = self.view.backgroundColor;
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



//- (UIStatusBarStyle) preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

@end

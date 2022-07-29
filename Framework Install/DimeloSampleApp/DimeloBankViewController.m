//
//  DimeloBankViewController.m
//  Dimelo
//
//  Created by Oleg Andreev on 19.09.2014.
//  Copyright (c) 2014 Dimelo. All rights reserved.
//

#import "Dimelo/Dimelo.h"
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
        _dimelo.enableThreads = [[NSUserDefaults standardUserDefaults] boolForKey:@"rc_enable_threads"];
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
            _dimelo.systemMessageBubbleImage = [[[UIImage imageNamed: @"DimeloBankSystemBubble"] resizableImageWithCapInsets: UIEdgeInsetsMake(18, 36, 18, 19) resizingMode: UIImageResizingModeStretch] imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];

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
        _dimelo.dateTextColor = UIColor.redColor;
        _dimelo.dateFont = [UIFont boldSystemFontOfSize:18.0];
        _dimelo.quickRepliesPaddingInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocalizedDateFormatFromTemplate:@"yyyy-MM-dd"];
        _dimelo.dateFormatter = dateFormatter;
        _dimelo.messageFont = [UIFont boldSystemFontOfSize:20.0];
        _dimelo.agentTemplateBorderColor = UIColor.redColor;
        _dimelo.agentTemplateWithImageBodyBackgroundColor = UIColor.lightGrayColor;
        _dimelo.quickRepliesBorderWidth = 3.0;
        _dimelo.quickRepliesTextColor = UIColor.whiteColor;
        _dimelo.quickRepliesTappedTextColor = UIColor.redColor;
        _dimelo.quickRepliesBorderColor = UIColor.redColor;
        _dimelo.badgeFont = [UIFont boldSystemFontOfSize:17.0];
        _dimelo.badgeTextColor = UIColor.redColor;
        _dimelo.backToAllChatsFont = [UIFont boldSystemFontOfSize:17.0];
        _dimelo.threadsListSeparatorColor = UIColor.blackColor;
        _dimelo.backToAllChatsItemImage = [UIImage imageNamed:@"Bank"];
        _dimelo.lockedThreadImage = [UIImage imageNamed:@"Bank"];
        _dimelo.quickRepliesHorizontalSpacing = 8.0;
        _dimelo.hourTimeFont = [UIFont boldSystemFontOfSize:17.0];
        _dimelo.agentTimeFont = [UIFont boldSystemFontOfSize:17.0];
        _dimelo.agentTimeColor = UIColor.greenColor;
        _dimelo.hourTimeTextColor = UIColor.greenColor;
        _dimelo.agentNameColor = UIColor.redColor;
        _dimelo.agentStructuredMessageItemFont = [UIFont boldSystemFontOfSize:18.0];
        _dimelo.agentStructuredMessageUrlFont = [UIFont boldSystemFontOfSize:15.0];
        _dimelo.agentStructuredMessageSubTitleFont = [UIFont boldSystemFontOfSize:13.0];
        _dimelo.agentStructuredMessageTitleFont = [UIFont boldSystemFontOfSize:18.0];
        _dimelo.agentStructuredMessageTitleColor = UIColor.blueColor;
        _dimelo.agentStructuredMessageSubtitleColor = UIColor.redColor;
        _dimelo.agentStructuredMessageUrlColor = UIColor.brownColor;
        _dimelo.agentStructuredMessageItemColor = UIColor.brownColor;
        _dimelo.agentStructuredMessageItemTappedColor = UIColor.blueColor;
    }

    _dimelo.userIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey: @"rc_user_id"];

    self.tabBarController.tabBar.tintColor = self.view.tintColor;
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

-(void)onOpen:(Dimelo *)dimelo{
    NSLog(@"on open userIdentifier : %@, userName : %@  authenticationInfo :%@", dimelo.userIdentifier, dimelo.userName, dimelo.authenticationInfo);
}

-(void)onClose:(Dimelo *)dimelo{

    NSLog(@"on close userIdentifier : %@, userName : %@  authenticationInfo :%@", dimelo.userIdentifier, dimelo.userName, dimelo.authenticationInfo);
}
@end

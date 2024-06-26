//
//  DimeloViewController.m
//
//
//  Created by Oleg Andreev on 23.07.2014.
//  Copyright (c) 2014 Dimelo. All rights reserved.
//

#import "DimeloDefaultViewController.h"
#import "Dimelo/Dimelo.h"

@interface DimeloDefaultViewController ()

@end

@implementation DimeloDefaultViewController

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdateUnreadCount:) name:DimeloChatUnreadCountDidChangeNotification object:nil];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    Dimelo.sharedInstance.embeddedAsFragment = NO;
    self.tabBarController.tabBar.tintColor = self.view.tintColor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Start" image:[UIImage imageNamed:@"MainMenu"] selectedImage:[UIImage imageNamed:@"MainMenuSelected"]];
    self.sdkVersionLabel.text = [self.sdkVersionLabel.text stringByAppendingString:Dimelo.sharedInstance.sdkVersion];
}

- (void) didUpdateUnreadCount:(NSNotification*)notif
{
    Dimelo* dimelo = notif.object;
    
    self.unreadCountLabel.text = (dimelo.unreadCount > 0) ? [@(dimelo.unreadCount) stringValue] : @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

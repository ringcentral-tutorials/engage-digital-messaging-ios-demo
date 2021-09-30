//
//  RCConfigurationViewController.m
//  DimeloTestApp
//
//  Created by Wael on 21/10/2020.
//  Copyright © 2020 Dimelo. All rights reserved.
//

#import "RCConfigurationViewController.h"
#import "Dimelo/Dimelo.h"
#import "RcSourceTableViewCell.h"
#import "RcSourceModel.h"
#import "DimeloTestAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation RCConfigurationViewController {
    NSMutableArray* array;
    RcSourceModel* selectedSource;
    NSIndexPath* selectedIndexPath;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.userIdEditText.delegate = self;

    self.userIdEditText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User id" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSData* storedEncodedObject = [defaults objectForKey:@"rc_selected_source"];
    selectedSource = [NSKeyedUnarchiver unarchiveObjectWithData:storedEncodedObject];

    self.userIdEditText.layer.cornerRadius = 3.0f;
    self.userIdEditText.layer.masksToBounds = YES;
    self.userIdEditText.layer.borderColor = [[UIColor blackColor]CGColor];
    self.userIdEditText.layer.borderWidth = 0.5f;
    self.userIdEditText.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"rc_user_id"];
    self.enableThreadsSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"rc_enable_threads"];

    NSArray* jsonDict = [DimeloTestAppDelegate JSONFromFile];
    array = [[NSMutableArray alloc] init];

    for (NSDictionary* dict in jsonDict) {
        RcSourceModel* sourceModel = [[RcSourceModel alloc] initWithText:[dict objectForKey:@"name"] descript:[dict objectForKey:@"description"] domainName:[dict objectForKey:@"domainName"] apiSecret:[dict objectForKey:@"apiSecret"] hostname:[dict objectForKey:@"hostname"]];
        [array addObject:sourceModel];
    }

    NSIndexPath* indexPath;
    int selectedSourceIndex = [self getSelectedSourceIndex];

    if (!selectedSource) {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableViewSources selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    } else if (selectedSource.isSelected && selectedSourceIndex > -1) {
        indexPath = [NSIndexPath indexPathForRow:selectedSourceIndex inSection:0];
    }

    [self.tableViewSources selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self tableView:self.tableViewSources didSelectRowAtIndexPath:indexPath];
}

- (IBAction)startAction:(id)sender {
    NSString* userId = [self.userIdEditText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (userId.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"rc_user_id"];
        Dimelo.sharedInstance.userIdentifier = userId;
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"rc_user_id"];
        Dimelo.sharedInstance.userIdentifier = nil;
    }

    Dimelo.sharedInstance.enableThreads = [self.enableThreadsSwitch isOn];
    [[NSUserDefaults standardUserDefaults] setBool:[self.enableThreadsSwitch isOn] forKey:@"rc_enable_threads"];

    NSData* encodedObject = [NSKeyedArchiver archivedDataWithRootObject:selectedSource];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:@"rc_selected_source"];
    [defaults synchronize];

    exit(0);
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (int)array.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.contentView.layer.masksToBounds = true;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RcSourceTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    RcSourceModel* currentSourceModel = [array objectAtIndex:(NSUInteger)indexPath.row];
    cell.nameLabel.text = currentSourceModel.name;
    cell.descriptLabel.text = currentSourceModel.descript;

    [cell.selectImageView setImage:[UIImage imageNamed:selectedIndexPath == indexPath ? @"button_checked" : @"button_unchecked"]];

    UIView* selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = selectionColor;

    cell.containerView.clipsToBounds = NO;
    cell.containerView.layer.cornerRadius = 5;
    cell.containerView.layer.borderWidth = 0.5f;
    cell.containerView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    cell.containerView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    cell.containerView.layer.shadowOffset = CGSizeMake(0, 0.5);
    cell.containerView.layer.shadowOpacity = 0.7f;
    cell.containerView.layer.shadowRadius = 4.0;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedSource = [array objectAtIndex:(NSUInteger)indexPath.row];
    selectedSource.isSelected = YES;
    selectedIndexPath = indexPath;
    [self.tableViewSources reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.userIdEditText resignFirstResponder];
    return YES;
}

- (int)getSelectedSourceIndex {
    for (RcSourceModel* model in array) {
        if ([model isEqual:selectedSource]) {
            return (int)[array indexOfObject:model];
        }
    }

    return -1;
}
@end

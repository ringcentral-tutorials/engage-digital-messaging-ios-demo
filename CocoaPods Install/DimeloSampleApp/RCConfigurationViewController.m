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

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSData* storedEncodedObject = [defaults objectForKey:@"rc_selected_source"];
    selectedSource = [NSKeyedUnarchiver unarchiveObjectWithData:storedEncodedObject];

    [self configureTextField:self.userIdEditText placeHolder:NSLocalizedStringFromTable(@"user_identifier", @"Main", @"") key:@"rc_user_id"];
    [self configureTextField:self.usernameEditText placeHolder:NSLocalizedStringFromTable(@"username", @"Main", @"") key:@"rc_username"];
    [self configureTextField:self.companyEditText placeHolder:NSLocalizedStringFromTable(@"company", @"Main", @"") key:@"rc_company"];
    [self configureTextField:self.emailEditText placeHolder:NSLocalizedStringFromTable(@"email", @"Main", @"") key:@"rc_email"];
    [self configureTextField:self.firstnameEditText placeHolder:NSLocalizedStringFromTable(@"firstname", @"Main", @"") key:@"rc_firstname"];
    [self configureTextField:self.lastnameEditText placeHolder:NSLocalizedStringFromTable(@"lastname", @"Main", @"") key:@"rc_lastname"];
    [self configureTextField:self.homePhoneEditText placeHolder:NSLocalizedStringFromTable(@"home_phone", @"Main", @"") key:@"rc_home_phone"];
    [self configureTextField:self.mobilePhoneEditText placeHolder:NSLocalizedStringFromTable(@"mobile_phone", @"Main", @"") key:@"rc_mobile_phone"];

    [self configureLabel:self.userIdLabel placeHolder:NSLocalizedStringFromTable(@"user_identifier", @"Main", @"")];
    [self configureLabel:self.usernameLabel placeHolder:NSLocalizedStringFromTable(@"username", @"Main", @"")];
    [self configureLabel:self.companyLabel placeHolder:NSLocalizedStringFromTable(@"company", @"Main", @"")];
    [self configureLabel:self.emailLabel placeHolder:NSLocalizedStringFromTable(@"email", @"Main", @"")];
    [self configureLabel:self.firstnameLabel placeHolder:NSLocalizedStringFromTable(@"firstname", @"Main", @"")];
    [self configureLabel:self.lastnameLabel placeHolder:NSLocalizedStringFromTable(@"lastname", @"Main", @"")];
    [self configureLabel:self.homePhoneLabel placeHolder:NSLocalizedStringFromTable(@"home_phone", @"Main", @"")];
    [self configureLabel:self.mobilePhoneLabel placeHolder:NSLocalizedStringFromTable(@"mobile_phone", @"Main", @"")];

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

- (void)configureTextField:(UITextField *)textField placeHolder:(NSString *)placeHolder key:(NSString *)key {
    textField.delegate = self;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];

    textField.layer.cornerRadius = 3.0f;
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = [[UIColor blackColor]CGColor];
    textField.layer.borderWidth = 0.5f;
    textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (void)configureLabel:(UILabel *)label placeHolder:(NSString *)placeHolder {
    label.text = placeHolder;
}

- (void)configureFieldsIdentity:(UITextField *)textField key:(NSString *)key fieldIdentity:(NSString *)fieldIdentity {
    NSString *text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    fieldIdentity = text;

    if (text.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:text forKey:key];
        fieldIdentity = text;
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        fieldIdentity = nil;
    }
}

- (IBAction)startAction:(id)sender {
    [self configureFieldsIdentity:self.userIdEditText key:@"rc_user_id" fieldIdentity:Dimelo.sharedInstance.userIdentifier];
    [self configureFieldsIdentity:self.usernameEditText key:@"rc_username" fieldIdentity:Dimelo.sharedInstance.userName];
    [self configureFieldsIdentity:self.companyEditText key:@"rc_company" fieldIdentity:Dimelo.sharedInstance.company];
    [self configureFieldsIdentity:self.emailEditText key:@"rc_email" fieldIdentity:Dimelo.sharedInstance.email];
    [self configureFieldsIdentity:self.firstnameEditText key:@"rc_firstname" fieldIdentity:Dimelo.sharedInstance.firstname];
    [self configureFieldsIdentity:self.lastnameEditText key:@"rc_lastname" fieldIdentity:Dimelo.sharedInstance.lastname];
    [self configureFieldsIdentity:self.homePhoneEditText key:@"rc_home_phone" fieldIdentity:Dimelo.sharedInstance.homePhone];
    [self configureFieldsIdentity:self.mobilePhoneEditText key:@"rc_mobile_phone" fieldIdentity:Dimelo.sharedInstance.mobilePhone];

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

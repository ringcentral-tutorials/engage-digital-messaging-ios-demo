//
//  RcSourceModel.h
//  DimeloTestApp
//
//  Created by Wael on 27/09/2021.
//  Copyright © 2021 Dimelo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RcSourceModel : NSObject<NSCoding>

@property (nonatomic) NSString* name;
@property (nonatomic) NSString* descript;
@property (nonatomic) NSString* domainName;
@property (nonatomic) NSString* apiSecret;
@property (nonatomic) NSString* hostname;
@property (nonatomic) BOOL isSelected;

- (id)initWithText:(NSString *)name descript:(NSString *)descript domainName:(NSString *)domainName apiSecret:(NSString *)apiSecret hostname:(NSString *)hostname;
@end

//
//  RcSourceModel.m
//  DimeloTestApp
//
//  Created by Wael on 27/09/2021.
//  Copyright © 2021 Dimelo. All rights reserved.
//

#import "RcSourceModel.h"

@implementation RcSourceModel

- (id)initWithText:(NSString *)name descript:(NSString *)descript domainName:(NSString *)domainName apiSecret:(NSString *)apiSecret hostname:(NSString *)hostname {
    if (self = [self init]) {
        self.name = name;
        self.descript = descript;
        self.domainName = domainName;
        self.apiSecret = apiSecret;
        self.hostname = hostname;
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.descript forKey:@"descript"];
    [encoder encodeObject:self.domainName forKey:@"domainName"];
    [encoder encodeObject:self.apiSecret forKey:@"apiSecret"];
    [encoder encodeObject:self.hostname forKey:@"hostname"];
    [encoder encodeBool:self.isSelected forKey:@"isSelected"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.descript = [decoder decodeObjectForKey:@"descript"];
        self.domainName = [decoder decodeObjectForKey:@"domainName"];
        self.apiSecret = [decoder decodeObjectForKey:@"apiSecret"];
        self.hostname = [decoder decodeObjectForKey:@"hostname"];
        self.isSelected = [decoder decodeBoolForKey:@"isSelected"];
    }

    return self;
}

- (BOOL)isEqual:(RcSourceModel *)model {
    return [model.name isEqual:self.name] && [model.descript isEqual:self.descript] && [model.domainName isEqual:self.domainName] && [model.apiSecret isEqual:self.apiSecret] && [model.hostname isEqual:self.hostname];
}
@end

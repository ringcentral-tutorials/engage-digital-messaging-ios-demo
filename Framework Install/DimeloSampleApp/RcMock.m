#import "RcMock.h"
#import <objc/runtime.h>

@implementation RcMock

+ (void)initializeMock:(Class)klass {
    Method originalMethod = class_getInstanceMethod(klass, @selector(checkConfiguration:));

    IMP emptyImp = imp_implementationWithBlock(^(id self, BOOL runOnMainThread) {});
    
    method_setImplementation(originalMethod, emptyImp);
}

+ (Ivar)findVarNamed:(NSString *)ivarName inClass:(Class)klass {
    while (klass != nil) {
        Ivar ivar = class_getInstanceVariable(klass, [ivarName UTF8String]);
        if (ivar != NULL) return ivar;
        klass = class_getSuperclass(klass);
    }
    return NULL;
}

+ (void)refectSetValue:(id)value forFieldName:(NSString *)fieldName onObject:(id)object {
    Ivar ivar = [self findVarNamed:fieldName inClass:[object class]];

    NSAssert(ivar != NULL, @"Failed to find var '%@' in class '%@'", fieldName, NSStringFromClass([object class]));

    object_setIvar(object, ivar, value);
}

+ (void)mockFields:(id)object {
    [self refectSetValue:[NSProcessInfo.processInfo.environment objectForKey:@"rcTestProtocol"] forFieldName:@"_defaultProtocol" onObject:object];
    [self refectSetValue:[[NSProcessInfo.processInfo.environment objectForKey:@"rcTestDomainName"] stringByAppendingFormat:@":%@", [NSProcessInfo.processInfo.environment objectForKey:@"rcTestPort"]] forFieldName:@"_hostName" onObject:object];
}
@end

#import <Foundation/Foundation.h>

@interface RcMock : NSObject
+ (void)initializeMock:(Class)klass;
+ (void)mockFields:(id)object;
@end

#import "RcContentSizedTableView.h"

@implementation RcContentSizedTableView

-(CGSize)contentSize {
    [self invalidateIntrinsicContentSize];
    return [super contentSize];
}

-(CGSize)intrinsicContentSize {
    [self layoutIfNeeded];
    return CGSizeMake(UIViewNoIntrinsicMetric, [self contentSize].height + [self adjustedContentInset].top);
}
@end

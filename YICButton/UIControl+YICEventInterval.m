//
//  UIControl+YICEventInterval.m
//  YICButton
//
//  Created by YIC on 2020/7/16.
//  Copyright © 2020 YIC. All rights reserved.
//

#import "UIControl+YICEventInterval.h"
#import <objc/runtime.h>

static char * const yic_eventIntervalKey = "yic_eventIntervalKey";
static char * const eventUnavailableKey = "eventUnavailableKey";

@interface UIControl ()
@property (nonatomic, assign) BOOL eventUnavailable;
@end

@implementation UIControl (YICEventInterval)

+ (void)load {
    Method method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method qi_method = class_getInstanceMethod(self, @selector(qi_sendAction:to:forEvent:));
    method_exchangeImplementations(method, qi_method);
}

#pragma mark - Action functions

- (void)qi_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if (self.eventUnavailable == NO) {
        self.eventUnavailable = YES;
        [self qi_sendAction:action to:target forEvent:event];
        [self performSelector:@selector(setEventUnavailable:) withObject:@(NO) afterDelay:self.yic_eventInterval];
    }
}


#pragma mark - Setter & Getter functions
- (NSTimeInterval)yic_eventInterval {
    return [objc_getAssociatedObject(self, yic_eventIntervalKey) doubleValue];
}

- (void)setYic_eventInterval:(NSTimeInterval)yic_eventInterval {
    objc_setAssociatedObject(self, yic_eventIntervalKey, @(yic_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)eventUnavailable {
    
    return [objc_getAssociatedObject(self, eventUnavailableKey) boolValue];
}

- (void)setEventUnavailable:(BOOL)eventUnavailable {
    
    objc_setAssociatedObject(self, eventUnavailableKey, @(eventUnavailable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

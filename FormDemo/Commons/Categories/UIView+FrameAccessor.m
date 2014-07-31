//
//  UIView+FrameAccessor.m
//  FormDemo
//
//  Created by sasaki on 2014/07/18.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "UIView+FrameAccessor.h"

@implementation UIView (FrameAccessor)

#pragma mark - Origin

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame   = frame;
}

- (CGFloat)x
{
    return self.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect frame   = self.frame;
    frame.origin.x = x;
    self.frame     = frame;
}

- (CGFloat)y
{
    return self.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect frame   = self.frame;
    frame.origin.y = y;
    self.frame     = frame;
}

#pragma mark - Size

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size   = size;
    self.frame   = frame;
}

- (CGFloat)width
{
    return self.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame     = self.frame;
    frame.size.width = width;
    self.frame       = frame;
}

- (CGFloat)height
{
    return self.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame      = self.frame;
    frame.size.height = height;
    self.frame        = frame;
}

@end

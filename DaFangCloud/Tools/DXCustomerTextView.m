//
//  TXCustomerTextView.m
//  CustomerTextView
//
//  Created by dsc on 15/4/24.
//  Copyright (c) 2015年 XingFuTongIOSClient. All rights reserved.
//

#import "DXCustomerTextView.h"

@implementation DXCustomerTextView
{
    BOOL _shouldDrawPlaceholder;
}

#pragma mark - 重写父类方法
- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self drawPlaceholder];
    return;
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (![placeholder isEqual:_placeholder]) {
        _placeholder = placeholder;
        [self drawPlaceholder];
    }
    return;
}

-(void)setPlaceHolderFont:(UIFont *)placeHolderFont
{
    if (![placeHolderFont isEqual:_placeHolderFont]) {
        _placeHolderFont = placeHolderFont;
        [self drawPlaceholder];
    }
    return;
}

#pragma mark - 父类方法
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configureBase];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureBase];
        _placeHolderFont = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_shouldDrawPlaceholder) {
        [_placeholderTextColor set];
        [_placeholder drawInRect:CGRectMake(8.0f, 9.0f, self.frame.size.width - 16.0f,
                                            self.frame.size.height - 16.0f) withFont:_placeHolderFont];
    }
    return;
}

- (void)configureBase {
    [[NSNotificationCenter defaultCenter] addObserver:self
                            selector:@selector(textChanged:)
                                name:UITextViewTextDidChangeNotification
                              object:self];

    
    self.placeholderTextColor = [UIColor colorWithHexString:@"#0xaaaaaa"];
    _shouldDrawPlaceholder = NO;
    return;
}

- (void)drawPlaceholder {
    BOOL prev = _shouldDrawPlaceholder;
    _shouldDrawPlaceholder = self.placeholder && self.placeholderTextColor && self.text.length == 0;
    
    if (prev != _shouldDrawPlaceholder) {
        [self setNeedsDisplay];
    }
    return;
}

- (void)textChanged:(NSNotification *)notification {
    [self drawPlaceholder];
    return;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    return;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

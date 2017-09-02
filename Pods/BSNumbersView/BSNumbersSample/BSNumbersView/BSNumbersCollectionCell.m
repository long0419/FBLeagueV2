//
//  BSNumbersCollectionCell.m
//  BSNumbersSample
//
//  Created by 张亚东 on 16/4/6.
//  Copyright © 2016年 blurryssky. All rights reserved.
//

#import "BSNumbersCollectionCell.h"

@interface BSNumbersCollectionCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation BSNumbersCollectionCell

#pragma mark - Override
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateFrame];
}

#pragma mark - Private
- (void)setup {
    [self.contentView addSubview:self.label];
}

- (void)updateFrame {
    _label.frame = CGRectMake(_textHorizontalMargin, 0,
                              self.bounds.size.width - 2 * _textHorizontalMargin, self.bounds.size.height);
}

#pragma mark - Getter

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 0;
        _label.backgroundColor = [UIColor clearColor];
    }
    return _label;
}

#pragma mark - Setter
- (void)setTextHorizontalMargin:(CGFloat)textHorizontalMargin {
    if (_textHorizontalMargin != textHorizontalMargin) {
        _textHorizontalMargin = textHorizontalMargin;
        [self updateFrame];
    }
}

#pragma mark - public
- (void)setAttributedString:(NSAttributedString *)attributedString {
    _label.attributedText = attributedString;
}

@end

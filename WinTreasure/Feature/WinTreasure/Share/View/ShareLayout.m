//
//  ShareLayout.m
//  WinTreasure
//
//  Created by Apple on 16/6/8.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ShareLayout.h"

@implementation ShareLayout

- (instancetype)initWithModel:(ShareModel *)model {
    if (!model) {
        return nil;
    }
    self = [super init];
    _model = model;
    [self layout];
    return self;
}

- (void)layout {
    [self _layout];
}

- (void)_layout {
    _marginTop = 0;
    _profileHeight = 0;
    _titleHeight = 0;
    _periodHeight = 0;
    _productNameHeight = 0;
    _contentHeight = 0;
    _picHeight = 0;
    _marginBottom = 10;
    [self _layoutProfile];
    [self _layoutTitle];
    [self _layoutPeriod];
    [self _layoutProduct];
    [self _layoutContent];
    [self _layoutPics];
    _height = 0;
    _height += _marginTop;
    _height += _profileHeight;
    _height += _titleHeight;
    _height += _periodHeight;
    _height += _productNameHeight;
    _height += _contentHeight;
    _height += kContentViewMargin*4;
    _height += _picHeight;
    _height += _marginBottom;

}

- (void)_layoutProfile {
    _profileHeight += 39.0;
    NSString *nameStr = _model.username;
    if (nameStr.length == 0) {
        _nameTextLayout = nil;
        return;
    }
    
    NSMutableAttributedString *nameText = [[NSMutableAttributedString alloc] initWithString:nameStr];
    nameText.font = SYSTEM_FONT(14);
    nameText.color = kDefaultColor;
    nameText.lineBreakMode = NSLineBreakByTruncatingTail;
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kUserNameLabelWidth, 15)];
    container.maximumNumberOfRows = 1;
    container.size = CGSizeMake(kUserNameLabelWidth, HUGE);
    _nameTextLayout = [YYTextLayout layoutWithContainer:container text:nameText];
    
    NSString *timeStr = [NSString transToTime:_model.timeSpan];
    if (timeStr.length == 0) {
        _timeTextLayout = nil;
        return;
    }
    
    NSMutableAttributedString *timeText = [[NSMutableAttributedString alloc] initWithString:timeStr];
    timeText.font = SYSTEM_FONT(14);
    timeText.color = UIColorHex(999999);
    timeText.lineBreakMode = NSLineBreakByTruncatingTail;
    timeText.alignment = NSTextAlignmentRight;
    YYTextContainer *container2 = [YYTextContainer containerWithSize:CGSizeMake(kTimeLabelWidth, 15)];
    container2.maximumNumberOfRows = 1;
    container2.size = CGSizeMake(kTimeLabelWidth, HUGE);
    _timeTextLayout = [YYTextLayout layoutWithContainer:container2 text:timeText];

}

- (void)_layoutTitle {
    _titleHeight = 0;
    _titleTextLayout = nil;
    NSMutableAttributedString *attributeTitle = [[NSMutableAttributedString alloc]initWithString:_model.title];
    if (attributeTitle.length==0) {
        return;
    }
    attributeTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    attributeTitle.font = SYSTEM_FONT(16);
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kContentLabelWidth, 16)];
    container.maximumNumberOfRows = 1;
    container.size = CGSizeMake(kContentLabelWidth, HUGE);
    _titleTextLayout = [YYTextLayout layoutWithContainer:container text:attributeTitle];
    _titleHeight = 16.0;
}

- (void)_layoutPeriod {
    _periodHeight = 0;
    _periodTextLayout = nil;
    NSMutableAttributedString *attributeTitle = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"期号：%@",_model.productPeriod]];
    if (attributeTitle.length==0) {
        return;
    }
    attributeTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    attributeTitle.font = SYSTEM_FONT(16);
    attributeTitle.color = UIColorHex(999999);
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kContentLabelWidth, 16)];
    container.maximumNumberOfRows = 1;
    container.size = CGSizeMake(kContentLabelWidth, HUGE);
    _periodTextLayout = [YYTextLayout layoutWithContainer:container text:attributeTitle];
    _periodHeight = 16.0;
}

- (void)_layoutProduct {
    _productNameHeight = 0;
    _productNameTextLayout = nil;
    NSMutableAttributedString *attributeTitle = [[NSMutableAttributedString alloc]initWithString:_model.productName];
    if (attributeTitle.length==0) {
        return;
    }
    attributeTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    attributeTitle.font = SYSTEM_FONT(16);
    attributeTitle.color = UIColorHex(999999);
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kContentLabelWidth, 16)];
    container.maximumNumberOfRows = 1;
    container.size = CGSizeMake(kContentLabelWidth, HUGE);
    _productNameTextLayout = [YYTextLayout layoutWithContainer:container text:attributeTitle];
    _productNameHeight = 16.0;
}

- (void)_layoutContent {
    _contentHeight = 0;
    _contentTextLayout = nil;
    NSMutableAttributedString *attributeTitle = [[NSMutableAttributedString alloc]initWithString:_model.content];
    if (attributeTitle.length==0) {
        return;
    }
    attributeTitle.lineBreakMode = NSLineBreakByCharWrapping;
    attributeTitle.font = SYSTEM_FONT(14);
    attributeTitle.color = UIColorHex(666666);
    ShareContentLinePositionModifier *modifier = [ShareContentLinePositionModifier new];
    modifier.font = SYSTEM_FONT(14);
    modifier.paddingTop = 0;
    modifier.paddingBottom = 5;
    YYTextContainer *container = [YYTextContainer new];
    container.linePositionModifier = modifier;
    container.maximumNumberOfRows = 3;
    container.size = CGSizeMake(kContentLabelWidth, HUGE);
    _contentTextLayout = [YYTextLayout layoutWithContainer:container text:attributeTitle];
    if (!_contentTextLayout) {
        return;
    }
    _contentHeight = [modifier heightForLineCount:_contentTextLayout.rowCount];;
}

- (void)_layoutPics {
    if (_model.imageList.count == 0) {
        return;
    }
    CGSize picSize = CGSizeZero;
    CGFloat picHeight = 0;
    CGFloat len1_3 = (kContentLabelWidth + kContentImagePadding) / 3 - kContentImagePadding;
    len1_3 = kContentImageWidth;
    len1_3 = CGFloatPixelRound(len1_3);
    switch (_model.imageList.count) {
        case 1:case 2:case 3:
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3;
            break;
        case 4:case 5:case 6:
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3 * 2 + kContentImagePadding;
            break;
        default:
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3 * 3 + kContentImagePadding * 2;
            break;
    }
    _picHeight = picHeight;
    _picSize  = picSize;
}

@end

@implementation ShareContentLinePositionModifier

- (instancetype)init {
    self = [super init];
    
    if (kiOS9Later) {
        _lineHeightMultiple = 1.34;   // for PingFang SC
    } else {
        _lineHeightMultiple = 1.3125; // for Heiti SC
    }
    
    return self;
}

- (void)modifyLines:(NSArray *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    //CGFloat ascent = _font.ascender;
    CGFloat ascent = _font.pointSize ;
    
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    ShareContentLinePositionModifier *one = [self.class new];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount {
    if (lineCount == 0) return 0;
    //    CGFloat ascent = _font.ascender;
    //    CGFloat descent = -_font.descender;
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}

@end

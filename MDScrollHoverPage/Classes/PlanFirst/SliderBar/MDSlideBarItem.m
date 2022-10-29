//
//  MDSlideBarItem.h
//
//  Created by Leon0206 on 2020/2/20.
//

#import "MDSlideBarItem.h"

#define DEFAULT_TITLE_FONTSIZE 15
#define DEFAULT_TITLE_SELECTED_FONTSIZE 15
#define DEFAULT_TITLE_COLOR [UIColor whiteColor]
#define DEFAULT_TITLE_SELECTED_COLOR [UIColor orangeColor]

#define HORIZONTAL_MARGIN 10

@interface MDSlideBarItem ()

@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat selectedFontSize;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, assign) NSTextAlignment itemTextAlignment;

@end

@implementation MDSlideBarItem

#pragma mark - Lifecircle

- (instancetype) init
{
    if (self = [super init]) {
        _fontSize = DEFAULT_TITLE_FONTSIZE;
        _selectedFontSize = DEFAULT_TITLE_SELECTED_FONTSIZE;
        _color = DEFAULT_TITLE_COLOR;
        _selectedColor = DEFAULT_TITLE_SELECTED_COLOR;
        _itemTextAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat titleX = 0;
    if (_itemTextAlignment == NSTextAlignmentLeft) {
        titleX = 0;
    } else {
        titleX = (CGRectGetWidth(self.frame) - [self titleSize].width) * 0.5;
    }
    
    CGFloat titleY = (CGRectGetHeight(self.frame) - [self titleSize].height) * 0.5;
    
    CGRect titleRect = CGRectMake(titleX, titleY, [self titleSize].width, [self titleSize].height);
    NSDictionary *attributes = @{NSFontAttributeName : [self titleFont], NSForegroundColorAttributeName : [self titleColor]};
    [_title drawInRect:titleRect withAttributes:attributes];
}

#pragma mark - Custom Accessors

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsDisplay];
}

#pragma mark - Public

- (void)setItemTitle:(NSString *)title
{
    _title = title;
    [self setNeedsDisplay];
}

- (void)setItemTitleFont:(CGFloat)fontSize
{
    _fontSize = fontSize;
    [self setNeedsDisplay];
}

- (void)setItemSelectedTileFont:(CGFloat)fontSize
{
    _selectedFontSize = fontSize;
    [self setNeedsDisplay];
}

- (void)setItemTitleColor:(UIColor *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setItemSelectedTitleColor:(UIColor *)color
{
    _selectedColor = color;
    [self setNeedsDisplay];
}

- (void)setItemTextAlignment:(NSTextAlignment)itemTextAlignment
{
    _itemTextAlignment = itemTextAlignment;
    [self setNeedsLayout];
}

#pragma mark - Private

- (CGSize)titleSize
{
    NSDictionary *attributes = @{NSFontAttributeName : [self titleFont]};
    CGSize size = [_title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}

- (UIFont *)titleFont
{
    UIFont *font;
    if (_selected) {
        font = [UIFont boldSystemFontOfSize:_selectedFontSize];
    } else {
        font = [UIFont systemFontOfSize:_fontSize];
    }
    return font;
}

- (UIColor *)titleColor
{
    UIColor *color;
    if (_selected) {
        color = _selectedColor;
    } else {
        color = _color;
    }
    return color;
}

#pragma mark - Public Class Method

+ (CGFloat)widthForTitle:(NSString *)title
{
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:DEFAULT_TITLE_FONTSIZE]};
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceil(size.width) + HORIZONTAL_MARGIN * 2;
    return size.width;
}

#pragma mark - Responder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideBarItemSelected:)]) {
        [self.delegate slideBarItemSelected:self];
    }
}

@end

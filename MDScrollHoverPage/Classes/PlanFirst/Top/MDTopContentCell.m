//
//
//  MDTopContentCell.h
//
//  Created by Leon0206 on 2020/4/20.
//

#import "MDTopContentCell.h"
@interface MDTopContentCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@end


@implementation MDTopContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}


- (void)handleDataWith:(id)data
{
  
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel sizeToFit];
    self.nameLabel.frame = self.contentView.bounds;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightSemibold];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.text = @"上部区域";

    }
    return _nameLabel;
}

@end

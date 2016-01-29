//
//  NewsCell.m
//  Xinwen
//
//  Created by hyp on 16/1/22.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "NewsCell.h"
#import "News.h"
#import <UIImageView+AFNetworking.h>


@implementation NewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
        
    }
    return self;
}

- (void)createViews
{
    self.imageLeft = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 80, 60)];
    [self.contentView addSubview:self.imageLeft];
    
    self.labTitle = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, ScreenW - 90, 25)];
    [self.contentView addSubview:self.labTitle];
    
    self.labDigest = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, ScreenW - 130, 35)];
    self.labDigest.font = [UIFont systemFontOfSize:14.0];
    // 设置换行宽度
    self.labDigest.numberOfLines = 2;
    self.labDigest.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(self.imageLeft.frame) - 16;
    [self.contentView addSubview:self.labDigest];
    
    self.labReplay = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 40, 30, 40, 35)];
    self.labReplay.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.labReplay];

}

-(void)setNews:(News *)news
{
    _news = news;
    self.labTitle.text = news.title;
    self.labDigest.text = news.digest;
    self.labReplay.text = [NSString stringWithFormat:@"%d", news.replyCount];
    [self.imageLeft setImageWithURL: [ NSURL URLWithString:news.imgsrc]];
}

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

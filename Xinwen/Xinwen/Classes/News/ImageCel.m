//
//  ImageCel.m
//  Xinwen
//
//  Created by hyp on 16/1/25.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "ImageCel.h"
#import "News.h"
#import <UIImageView+AFNetworking.h>
#import <Masonry.h>

@implementation ImageCel

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews1];
    }
    return self;
}

- (void)createViews1
{
    self.labTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, ScreenW - 35, 25)];
    [self.contentView addSubview:self.labTitle];
    
    
    self.labReplay = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 35, 5, 35, 25)];
    self.labReplay.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.labReplay];
    
    
    self.imageLeft = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageLeft];
    
    self.imageMid = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageMid];
    
    self.imageRight = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageRight];
    
    [self.imageLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(30);
        make.left.equalTo(self.contentView.mas_left).with.offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-5);
        make.right.mas_equalTo(self.imageMid.mas_left).with.offset(-5);
        
        make.width.equalTo(self.imageMid.mas_width);
        make.height.mas_equalTo(@72);
        
    }];
    
    [self.imageMid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(30);
        make.left.equalTo(self.imageLeft.mas_right).with.offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-5);
        
        make.width.equalTo(self.imageLeft.mas_width);
        make.height.mas_equalTo(@72);
    }];

    [self.imageRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(30);
        make.left.equalTo(self.imageMid.mas_right).with.offset(5);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-5);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-5);
        
        make.width.equalTo(self.imageMid.mas_width);
        make.height.mas_equalTo(@72);
        
    }];
}

-(void)setNews:(News *)news
{
    _news = news;
    self.labTitle.text = news.title;
    self.labReplay.text = [NSString stringWithFormat:@"%d", news.replyCount];
    [self.imageLeft setImageWithURL: [NSURL URLWithString:news.imgsrc]];
    
    
    if (news.imgextra.count == 2) {
        NSString *urlStr = [[news.imgextra objectAtIndex:0] objectForKey:@"imgsrc"];
        NSURL *url = [NSURL URLWithString:urlStr];
        [self.imageMid setImageWithURL:url];
        
        NSString *urlStr1 = [[news.imgextra objectAtIndex:1] objectForKey:@"imgsrc"];
        NSURL *url1 = [NSURL URLWithString:urlStr1];
        [self.imageRight setImageWithURL:url1];
    }
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

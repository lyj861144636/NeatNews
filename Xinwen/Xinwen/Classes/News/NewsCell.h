//
//  NewsCell.h
//  Xinwen
//
//  Created by hyp on 16/1/22.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;

@interface NewsCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageLeft;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDigest;
@property (nonatomic, strong) UILabel *labReplay;

@property (nonatomic, strong) News *news;

@end

//
//  ImageCel.h
//  Xinwen
//
//  Created by hyp on 16/1/25.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;

@interface ImageCel : UITableViewCell



@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labReplay;


@property (nonatomic, strong) UIImageView *imageLeft;

@property (nonatomic, strong) UIImageView *imageMid;

@property (nonatomic, strong) UIImageView *imageRight;

@property (nonatomic, strong) News *news;


@end

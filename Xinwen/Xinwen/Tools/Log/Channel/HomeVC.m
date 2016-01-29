//
//  HomeVC.m
//  Xinwen
//
//  Created by hyp on 16/1/25.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "HomeVC.h"
#import "Channel.h"
#import "TopView.h"
#import "ChannelLabel.h"
#import "ChannelCell.h"



@interface HomeVC () <UICollectionViewDataSource, UICollectionViewDelegate,ChannelLabelDelegate>
{
    TopView *_topView;
}

@property (nonatomic, strong) NSArray *channelList;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UIScrollView *scroll;
/**
 *  当前选中的索引
 */
@property (nonatomic, assign) NSInteger currentIndex;


@end



@implementation HomeVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    _topView = [[TopView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 30) arr:self.channelList];
//    [self.view addSubview:_topView];
//}
    // 设置频道
    [self setupChannel];

    
     self.layout = [[UICollectionViewFlowLayout alloc] init];
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 104, ScreenW, ScreenH - 104) collectionViewLayout:self.layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[ChannelCell class] forCellWithReuseIdentifier:@"cellsss"];
    [self.view addSubview:self.collectionView];
    
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    self.layout.itemSize = self.collectionView.bounds.size;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
}


- (void)setupChannel {
    
    // *** 取消 scrollView 的自动缩进
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 40)];
    self.scroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scroll];
    
    // 遍历频道数组，添加 label
    CGFloat margin = 8.0;
    CGFloat x = margin;
    CGFloat h = self.scroll.bounds.size.height;
    
    
    NSInteger index = 0;
    for (Channel *channel in self.channelList) {
        
        // 已经计算好了 width
        ChannelLabel *l = [ChannelLabel channelLabelWithTitle:channel.tname];
        
        // 设置位置
        l.frame = CGRectMake(x, 0, l.bounds.size.width, h);
        
        // 设置代理
        l.delegate = self;
        
        // 设置 tag
        l.tag = index++;
        
        // 递增 x
        x += l.bounds.size.width;
        
        [self.scroll addSubview:l];
    }
    
    // 设置 contentSize
    self.scroll.contentSize = CGSizeMake(x + margin, h);
    
    // 当前选中第0项
    self.currentIndex = 0;
    // 设置第0个label的scale
    ChannelLabel *l = self.scroll.subviews[0];
    l.scale = 1;
    
}

-(NSArray *)channelList
{
    if (_channelList == nil) {
        _channelList = [Channel channelList];
    }
    return _channelList;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.channelList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellsss";
    ChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    

    cell.urlStr = [self.channelList[indexPath.item] urls];
    
    NSLog(@"～～～～～～%@", self.childViewControllers);
    
    if (![self.childViewControllers containsObject:cell.vc]) {
        [self addChildViewController:cell.vc];
    }
    
    
    return cell;
}



#pragma mark - ScrollView 的代理方法
// 只要一滚动就会被调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"%s", __FUNCTION__);
    
    // 1. 当前选中的标签
    ChannelLabel *currentLabel = self.scroll.subviews[self.currentIndex];
    //    NSLog(@"当前的 %@", currentLabel.text);
    
    // 2. 下一个标签
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    //    NSLog(@"%@", indexPaths);
    // 遍历数组，确定第二个标签
    ChannelLabel *nextLabel = nil;
    for (NSIndexPath *path in indexPaths) {
        if (path.item != self.currentIndex) {
            nextLabel = self.scroll.subviews[path.item];
            break;
        }
    }
    NSLog(@"从 %@ 到 %@", currentLabel.text, nextLabel.text);
    
    // 3. 判断是否有下一个标签
    if (nextLabel == nil) {
        return;
    }
    
    // 4. `比例` 0~1
    float nextScale = ABS((float)self.collectionView.contentOffset.x / self.collectionView.bounds.size.width - self.currentIndex);
    float currentScale = 1 - nextScale;
    
    NSLog(@"%f %f", currentScale, nextScale);
    // 设置比例
    currentLabel.scale = currentScale;
    nextLabel.scale = nextScale;
    
    // 5. 强制更新索引 － 可以解决快速拖拽的问题
    self.currentIndex = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 更新当前选中的索引
    self.currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    ChannelLabel *la = self.scroll.subviews[self.currentIndex];
    CGFloat offset = la.center.x - self.scroll.bounds.size.width * 0.5;
    CGFloat maxOffset = self.scroll.contentSize.width - self.scroll.bounds.size.width;
    
    if (offset < 0) {
        offset = 0;
    } else if (offset > maxOffset) {
        offset = maxOffset;
    }
    
    [self.scroll setContentOffset:CGPointMake(offset, 0) animated:YES];
}

#pragma mark - ChannelLabel 代理方法
- (void)channelLabelDidSelected:(ChannelLabel *)label {
    NSLog(@"%@", label);
    
    self.currentIndex = label.tag;
    
    // 滚动到指定位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    
    // 直接滚动，索引不会执行
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}


@end

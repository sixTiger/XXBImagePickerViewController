//
//  XXBPhotoGroupTabVC.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoGroupTabVC.h"
#import "XXBPhotoGroupModle.h"
#import "XXBPhotoGroupTVCell.h"
#import "XXBPhotoCollectionVC.h"
#import "XXBPhotoAlasetModle.h"

@interface XXBPhotoGroupTabVC ()<XXBPhotoCollectionVCDelegate>
{
    NSInteger _photoInRow;
}
@property(nonatomic , strong)XXBPhotoCollectionVC *photoCollectionVC;
@property(nonatomic , assign)BOOL havePush;
@end

@implementation XXBPhotoGroupTabVC
- (instancetype)init
{
    if (self = [super init])
    {
        self.havePush = NO;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"照片";
    self.tableView.rowHeight = 60;
    [self setupItems];
}
- (void)showAllPhotos
{
    XXBPhotoGroupModle *photoGroupModle = [self shouldShowPhotoGroupModle];
    if (self.havePush)
    {
        self.photoCollectionVC.photoALAssets = photoGroupModle.photoALAssets;
        self.photoCollectionVC.title = photoGroupModle.photoGroupName;
        [self.photoCollectionVC.collectionView reloadData];
    }
    else
    {
        self.havePush = YES;
        self.photoCollectionVC.photoALAssets = photoGroupModle.photoALAssets;
        self.photoCollectionVC.title = photoGroupModle.photoGroupName;
        for (XXBPhotoAlasetModle *photoAlaset in self.selectPhotoALAssets)
        {
            photoAlaset.select = NO;
        }
        [self.selectPhotoALAssets removeAllObjects];
        [self.navigationController pushViewController:self.photoCollectionVC animated:NO];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.photoCollectionVC scrollToButtom];
    });
}
- (XXBPhotoGroupModle *)shouldShowPhotoGroupModle
{
    NSInteger count = self.photoGroupArray.count;
    for (int  i = 0; i < count; i++)
    {
        XXBPhotoGroupModle *photoGroupModle = self.photoGroupArray[i];
        if ([photoGroupModle.photoGroupName isEqualToString:@"所有照片"] || [photoGroupModle.photoGroupName isEqualToString:@"相机胶卷"])
        {
            return  photoGroupModle;
        }
    }
    return self.photoGroupArray[0];
}
- (void)setupItems
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleSelectPhotos)];
}
#pragma mark - 相关的代理方法的处理
- (void)cancleSelectPhotos
{
    if ([self.photoGroupTabVCDelegate respondsToSelector:@selector(photoGroupTabVCCancleSelect:)])
    {
        [self.photoGroupTabVCDelegate photoGroupTabVCCancleSelect:self];
    }
}
- (void)photoCollectionVCDidselectPhotos:(XXBPhotoCollectionVC *)photoCollectionVC
{
    if ([self.photoGroupTabVCDelegate respondsToSelector:@selector(photoGroupTabVCDidSelectPhotos:)])
    {
        [self.photoGroupTabVCDelegate photoGroupTabVCDidSelectPhotos:self];
    }
}
#pragma mark - tableView相关方法的处理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photoGroupArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XXBPhotoGroupTVCell *cell = [XXBPhotoGroupTVCell photoGroupTVCellWithTableView:tableView];
    XXBPhotoGroupModle *photoGroupModle = self.photoGroupArray[indexPath.row];
    cell.photoGroupModle = photoGroupModle;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.photoCollectionVC.photoALAssets = [self.photoGroupArray[indexPath.row] photoALAssets];
    self.photoCollectionVC.title = [self.photoGroupArray[indexPath.row] photoGroupName];
    for (XXBPhotoAlasetModle *photoAlaset in self.selectPhotoALAssets)
    {
        photoAlaset.select = NO;
    }
    [self.selectPhotoALAssets removeAllObjects];
    [self.navigationController pushViewController:self.photoCollectionVC animated:YES];
    
    [self.photoCollectionVC scrollToButtom];
    
}
#pragma mark - 
- (void)setShowPage:(BOOL)showPage
{
    _showPage = showPage;
    self.photoCollectionVC.showPage = _showPage;
}
- (void)setPhotoCount:(NSInteger)photoCount
{
    _photoCount = photoCount;
    self.photoCollectionVC.photoCount = _photoCount;
}
#pragma mark - 懒加载
- (void)setPhotoInRow:(NSInteger)photoInRow
{
    _photoInRow = photoInRow;
    _photoCollectionVC = nil;
}

- (NSInteger)photoInRow
{
    if (_photoInRow == 0) {
        _photoInRow = 4;
    }
    return _photoInRow;
}

- (XXBPhotoCollectionVC *)photoCollectionVC
{
    if (_photoCollectionVC == nil)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat screenWidth = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        CGFloat itemWidth = (screenWidth - self.photoInRow -1)/(CGFloat)self.photoInRow;
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        
        _photoCollectionVC  = [[XXBPhotoCollectionVC alloc] initWithCollectionViewLayout:layout];
        _photoCollectionVC.selectPhotoALAssets = self.selectPhotoALAssets;
        _photoCollectionVC.photoCollectionDelegate = self;
    }
    return _photoCollectionVC;
}
@end

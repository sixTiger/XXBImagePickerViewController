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
#import "XXBDeviceHelp.h"

@interface XXBPhotoGroupTabVC ()<XXBPhotoCollectionVCDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _photoInRow;
}
@property(nonatomic , strong)XXBPhotoCollectionVC   *photoCollectionVC;
@property(nonatomic , assign)BOOL                   havePush;
@property(nonatomic , weak)UILabel                  *messageLabel;
@end

@implementation XXBPhotoGroupTabVC

- (instancetype)init
{
    if (self = [super init])
    {
        self.havePush = NO;
        self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
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
    
    XXBPhotoGroupModle *photoGroupModle = [self.photoGroupArray firstObject];
    if (self.havePush)
    {
        self.photoCollectionVC.photoALAssets = photoGroupModle.photoALAssets;
        self.photoCollectionVC.title = photoGroupModle.photoGroupName;
        [self.photoCollectionVC.collectionView reloadData];
    }
    else
    {
        self.havePush = YES;
        if (!self.allowFromPhotos)
        {
            for (XXBPhotoAlasetModle *photoAlaset in self.selectPhotoALAssets)
            {
                photoAlaset.select = NO;
            }
            [self.selectPhotoALAssets removeAllObjects];
        }
        self.photoCollectionVC.photoALAssets = photoGroupModle.photoALAssets;
        self.photoCollectionVC.title = photoGroupModle.photoGroupName;
        [self.navigationController pushViewController:self.photoCollectionVC animated:NO];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.photoCollectionVC scrollToButtom];
    });
}

- (void)setupItems
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleSelectPhotos)];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.photoGroupArray.count <= 0)
    {
        self.tableView.hidden = YES;
        self.messageLabel.hidden = NO;
        self.messageLabel.text  = @"您的iPhone没有照片";
        return 0;
    }
    else
    {
        self.tableView.hidden = NO;
        self.messageLabel.hidden = YES;
    }
    return 1;
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
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if (!self.allowFromPhotos)
    {
        for (XXBPhotoAlasetModle *photoAlaset in self.selectPhotoALAssets)
        {
            photoAlaset.select = NO;
        }
        [self.selectPhotoALAssets removeAllObjects];
    }
    self.photoCollectionVC.photoALAssets = [self.photoGroupArray[indexPath.row] photoALAssets];
    self.photoCollectionVC.title = [self.photoGroupArray[indexPath.row] photoGroupName];
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

- (void)dealloc
{
    
    
}
#pragma mark - 懒加载
- (void)setPhotoInRow:(NSInteger)photoInRow
{
    _photoInRow = photoInRow;
    _photoCollectionVC = nil;
}

- (void)setAllowPhoto:(BOOL)allowPhoto
{
    _allowPhoto = allowPhoto;
    self.tableView.hidden = !_allowPhoto;
    self.messageLabel.hidden = allowPhoto;
    self.messageLabel.text  = @"请在iPhone的“设置-隐私-照片”选项中，允许应用访问你的手机相册";
}

- (NSInteger)photoInRow
{
    if (_photoInRow == 0)
    {
        if ([XXBDeviceHelp isIpad])
        {
            _photoInRow = 6;
        }
        else
        {
            _photoInRow = 4;
        }
    }
    return _photoInRow;
}

- (void)setSelectPhotoALAssets:(NSMutableArray *)selectPhotoALAssets
{
    _selectPhotoALAssets = selectPhotoALAssets;
    self.photoCollectionVC.selectPhotoALAssets = _selectPhotoALAssets;
}

- (XXBPhotoCollectionVC *)photoCollectionVC
{
    if (_photoCollectionVC == nil)
    {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat screenWidth = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        layout.minimumInteritemSpacing = 4;
        layout.minimumLineSpacing = 4;
        CGFloat itemWidth = (screenWidth - layout.minimumInteritemSpacing)/(CGFloat)self.photoInRow - layout.minimumInteritemSpacing;
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        layout.sectionInset = UIEdgeInsetsMake(layout.minimumInteritemSpacing, layout.minimumInteritemSpacing, layout.minimumLineSpacing, layout.minimumInteritemSpacing);
        layout.footerReferenceSize = CGSizeMake(300.0f, 50.0f);
        _photoCollectionVC  = [[XXBPhotoCollectionVC alloc] initWithCollectionViewLayout:layout];
        _photoCollectionVC.selectPhotoALAssets = self.selectPhotoALAssets;
        _photoCollectionVC.photoCollectionDelegate = self;
    }
    return _photoCollectionVC;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *tableViewRight = [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        NSLayoutConstraint *tableViewLeft = [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *tableViewBottom = [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *tableViewTop = [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        [self.view addConstraints:@[tableViewLeft, tableViewRight,tableViewTop,tableViewBottom]];
        tableView.hidden = YES;
        _tableView = tableView;
    }
    return _tableView;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil)
    {
        UILabel *messageLabel = [UILabel new];
        _messageLabel = messageLabel;
        [self.view addSubview:_messageLabel];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *messageLabelRight = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20];
        NSLayoutConstraint *messageLabelLeft = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
        NSLayoutConstraint *messageLabelTop = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:104];
        [self.view addConstraints:@[messageLabelLeft, messageLabelRight,messageLabelTop]];
    }
    return _messageLabel;
}
@end

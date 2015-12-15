//
//  ViewController.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "ViewController.h"
#import "XXBImagePickerController.h"
#import "XXBHelpTools.h"
#import "XXBPhotoAlasetModel.h"
#import "MBProgressHUD+XXB.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,XXBImagePickerControllerDelegate>
@property(nonatomic , weak)UICollectionView                 *collectionView;
@property(nonatomic , strong)NSMutableArray                 *photoArray;
@property(nonatomic , strong) NSMutableArray                *selectPhotoModelArray;
@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNav];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    imageView.autoresizingMask = (1 << 6) -1;
    imageView.image = [UIImage imageNamed:@"bg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
}
- (void)setNav
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"openPhoto" style:UIBarButtonItemStylePlain target:self action:@selector(openPhoto)];
}
- (void)openPhoto
{
    // 创建一个照片选择器
    XXBImagePickerController  *imagePickController = [[XXBImagePickerController alloc] initWithChooseMediaType:XXBMediaTypeVideos];
    // 设置做多可选的照片数
    imagePickController.photoCount = 100;
    // 是都展示左上角的数字标签
    imagePickController.showPage = YES;
    //  是否默认打开全部相册
    imagePickController.showAllPhoto = YES;
    //  设置代理
    imagePickController.imagePickerDelegate = self;
    //  返回照片的排序方式
    imagePickController.photoSortType = XXBPhotoSortTypeSystemOrder;
#warning 执行这一行代码之后和直接init得效果一样了。
      imagePickController.allowFromPhotos = YES;
    [self presentViewController:imagePickController animated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerCancleselect:(XXBImagePickerController *)imagePickController
{
    [imagePickController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerController:(XXBImagePickerController *)imagePickController didselectPhotos:(NSArray *)selectPhotos
{
    self.selectPhotoModelArray = [selectPhotos mutableCopy];
    [MBProgressHUD showMessage:@"正在加载照片" toView:self.collectionView];
    [self.photoArray removeAllObjects];
    [imagePickController dismissViewControllerAnimated:YES completion:^{
        for (int i = 0; i < selectPhotos.count; i ++)
        {
            //不知第一张或者最后一张
            [self.photoArray addObject: [[XXBHelpTools sharedXXBHelpTools] thumbnailForAsset:[selectPhotos[i] photoAlaset] maxPixelSize:1024 * 2]];
        }
        [MBProgressHUD hideAllHUDsForView:self.collectionView animated:YES];
        [self.collectionView reloadData];
        
        [self.view bringSubviewToFront:self.collectionView];
    }];
}


#pragma mark - 返回的图片的链接的处理
- (UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height - 104);
        layout.minimumInteritemSpacing = 20;
        layout.minimumLineSpacing = 10;
        layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(84, 10, 20, 10);
        UICollectionView *collectionView  = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        collectionView.autoresizingMask = (1 << 6) -1;
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
        imageView.image = [UIImage imageNamed:@"bg"];
        collectionView.backgroundView =imageView;
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
        [self.view bringSubviewToFront:collectionView];
    }
    return _collectionView;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.bounds];
    cell.backgroundView = imageView;
    imageView.image = self.photoArray[indexPath.row];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count;
}
- (NSMutableArray *)photoArray
{
    if (_photoArray == nil)
    {
        _photoArray = [NSMutableArray array];
    }
    return _photoArray;
}
- (NSMutableArray *)selectPhotoModelArray
{
    if (_selectPhotoModelArray == nil) {
        _selectPhotoModelArray = @[].mutableCopy;
    }
    return _selectPhotoModelArray;
}
@end

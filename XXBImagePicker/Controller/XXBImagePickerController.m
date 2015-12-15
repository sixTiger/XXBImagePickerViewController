//
//  XXBImagePickerController.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBImagePickerController.h"
#import "XXBPhotoGroupTabVC.h"
#import "XXBPhotoGroupModel.h"
#import "XXBPhotoAlasetModel.h"

@interface XXBImagePickerController ()<XXBPhotoGroupTabVCDelegate>
{
    NSMutableArray *_selectPhotoALAssets;
}
/**
 *  展示组的相册tableViewController
 */
@property(nonatomic , strong)XXBPhotoGroupTabVC *photoTableVC;
/**
 *  图片库资源
 */
@property(nonatomic , strong)ALAssetsLibrary    *library ;
/**
 *  图片group
 */
@property(nonatomic , strong)NSMutableArray     *photoGroupArray;
@property(nonatomic , strong)NSArray            *oldSelectPhotoAlasetModel;
/**
 *  选择媒体的类型 默认是照片
 */
@property(nonatomic, assign) XXBMediaType       chooseMediaType;
@end

@implementation XXBImagePickerController
+ (void)initialize
{  // 取出appearance对象
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 设置背景
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19];
    [navBar setTitleTextAttributes:textAttrs];
    //返回箭头的颜色
    navBar.tintColor = [UIColor blackColor];
}

+ (instancetype)initWithSelectPhotoALAssets:(NSArray *)selectPhotoALAssets
{
    return [[self alloc] initWithSelectPhotoALAssets:selectPhotoALAssets];
}

- (instancetype)initWithSelectPhotoALAssets:(NSArray *)selectPhotoALAssets
{
    if (self = [self init])
    {
        _oldSelectPhotoAlasetModel = selectPhotoALAssets;
    }
    return self;
}


- (instancetype)initWithChooseMediaType:(XXBMediaType)mediaType
{
    if (self = [super initWithRootViewController:self.photoTableVC])
    {
        self.showAllPhoto = NO;
        self.photoCount = NSIntegerMax;
        self.chooseMediaType = mediaType;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithChooseMediaType:XXBMediaTypePhotos];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self p_getAllMedias];
}
#pragma mark - 代理方法的处理
- (void)photoGroupTabVCCancleSelect:(XXBPhotoGroupTabVC *)photoGroupTabVC
{
    if ([self.imagePickerDelegate respondsToSelector:@selector(imagePickerControllerCancleselect:)])
    {
        [self.imagePickerDelegate imagePickerControllerCancleselect:self];
    }
}

- (void)photoGroupTabVCDidSelectPhotos:(XXBPhotoGroupTabVC *)photoGroupTabVC
{
    switch (self.photoSortType)
    {
        case XXBPhotoSortTypeSelectOrder:
        {
            [self.selectPhotoALAssets sortUsingComparator:^NSComparisonResult(XXBPhotoAlasetModel *photo1, XXBPhotoAlasetModel *photo2) {
                return photo1.index > photo2.index;
            }];
            break;
        }
        case XXBPhotoSortTypeSelectDesc:
        {
            [self.selectPhotoALAssets sortUsingComparator:^NSComparisonResult(XXBPhotoAlasetModel *photo1, XXBPhotoAlasetModel *photo2) {
                return photo1.index < photo2.index;
            }];
            break;
        }
        case XXBPhotoSortTypeSystemOrder:
        {
            [self.selectPhotoALAssets sortUsingComparator:^NSComparisonResult(XXBPhotoAlasetModel *photo1, XXBPhotoAlasetModel *photo2) {
                return photo1.indexPath.row > photo2.indexPath.row;
            }];
            break;
        }
        case XXBPhotoSortTypeSystemDesc:
        {
            [self.selectPhotoALAssets sortUsingComparator:^NSComparisonResult(XXBPhotoAlasetModel *photo1, XXBPhotoAlasetModel *photo2) {
                return photo1.indexPath.row < photo2.indexPath.row;
            }];
            break;
        }
        default:
            break;
    }
    if ([self.imagePickerDelegate respondsToSelector:@selector(imagePickerController:didselectPhotos:)])
    {
        [self.imagePickerDelegate imagePickerController:self didselectPhotos:[self.selectPhotoALAssets copy]];
    }
}
#pragma mark - 获取图片库的所有资源
/**
 * 获取所有的图片资源
 */
- (void)p_getAllMedias
{
    ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror){
        self.photoTableVC.allowPhoto = NO;
    };
    ALAssetsGroupEnumerationResultsBlock groupEnumerAtion = ^(ALAsset *result, NSUInteger index, BOOL *stop){
        if (result!=NULL)
        {
            //            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
            /**
             *  取出对应的photoGroupModel模型
             */
            XXBPhotoGroupModel *photoGroupModel = [self.photoGroupArray firstObject];
            XXBPhotoAlasetModel *photoAlaetModel = [[XXBPhotoAlasetModel alloc] init];
            photoAlaetModel.photoAlaset = result;
            if ([result.description isEqualToString:@"ALAsset - Type:Photo, URLs:assets-library://asset/asset.JPG?id=106E99A1-4F6A-45A2-B320-B0AD4A8E8473&ext=JPG"])
            {
                NSLog(@"+++++++++%@",result);
            }
            /**
             *  判断是否选中
             */
            if ([self.oldSelectPhotoAlasetModel containsObject:photoAlaetModel])
            {
                photoAlaetModel.select = YES;
                NSInteger index = [self.oldSelectPhotoAlasetModel indexOfObject:photoAlaetModel] + 1;
                photoAlaetModel.index = index;
                photoAlaetModel.showPage = index;
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(index -1) inSection:0];
                photoAlaetModel.indexPath = indexPath;
                [self.selectPhotoALAssets addObject:photoAlaetModel];
            }
            [photoGroupModel.photoALAssets addObject:photoAlaetModel];
        }
    };
    /**
     *  获取对应的组
     */
    ALAssetsLibraryGroupsEnumerationResultsBlock libraryGroupsEnumeration = ^(ALAssetsGroup* group, BOOL* stop){
        ALAssetsFilter *onlyPhotosFilter ;
        switch (self.chooseMediaType) {
            case XXBMediaTypePhotos:
            {
                onlyPhotosFilter = [ALAssetsFilter allPhotos];
                break;
            }
            case XXBMediaTypeVideos:
            {
                onlyPhotosFilter = [ALAssetsFilter allVideos];
                break;
            }
            case XXBMediaTypeAll:
            {
                onlyPhotosFilter = [ALAssetsFilter allAssets];
                break;
            }
            default:
                break;
        }
        [group setAssetsFilter:onlyPhotosFilter];
        if ([group numberOfAssets] > 0)
        {
            /**
             *  有一个新的group的模型来存放相关的信息
             */
            XXBPhotoGroupModel *groupModel = [[XXBPhotoGroupModel alloc] init];
            if (self.photoGroupArray.count > 0)
            {
                [self.photoGroupArray insertObject:groupModel atIndex:0];
            }
            else
            {
                [self.photoGroupArray addObject:groupModel];
            }
            /**
             *  获取photoGroup的组名
             */
            
            groupModel.photoGroupName = [group valueForProperty:ALAssetsGroupPropertyName];
            /**
             *  获取缩略图
             */
            groupModel.photoGroupIcon = [UIImage imageWithCGImage:[group posterImage]];
            /**
             *  便利组
             */
            [group enumerateAssetsUsingBlock:groupEnumerAtion];
        }
        else
        {
            [self.photoTableVC.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            if(self.showAllPhoto)
            {
                [self.photoTableVC performSelectorOnMainThread:@selector(showAllPhotos) withObject:nil waitUntilDone:NO];
            }
        }
    };
    _library = [self defaultAssetsLibrary];
    [_library enumerateGroupsWithTypes:ALAssetsGroupAll
                            usingBlock:libraryGroupsEnumeration
                          failureBlock:failureblock];
}

#pragma - 一些逻辑处理
- (void)setShowPage:(BOOL)showPage
{
    _showPage = showPage;
    self.photoTableVC.showPage = _showPage;
}

- (void)setPhotoCount:(NSInteger)photoCount
{
    _photoCount = photoCount;
    self.photoTableVC.photoCount = _photoCount;
}
#pragma mark - 懒加载
- (void)setAllowFromPhotos:(BOOL)allowFromPhotos
{
    _allowFromPhotos = allowFromPhotos;
    self.photoTableVC.allowFromPhotos = _allowFromPhotos;
}

- (void)setPhotoInRow:(NSInteger)photoInRow
{
    _photoInRow = photoInRow;
    self.photoTableVC.photoInRow = photoInRow;
}

- (void)setChooseMediaType:(XXBMediaType)chooseMediaType
{
    _chooseMediaType = chooseMediaType;
    self.photoTableVC.chooseMediaType = chooseMediaType;
}

- (XXBPhotoGroupTabVC *)photoTableVC
{
    if (_photoTableVC == nil)
    {
        _photoTableVC = [[XXBPhotoGroupTabVC alloc] init];
        _photoTableVC.allowFromPhotos = YES;
        _photoTableVC.selectPhotoALAssets = self.selectPhotoALAssets;
        _photoTableVC.photoGroupTabVCDelegate = self;
        _photoTableVC.photoGroupArray = self.photoGroupArray;
        _photoTableVC.showAllPhoto = self.showAllPhoto;
    }
    return _photoTableVC;
}

- (NSMutableArray *)selectPhotoALAssets
{
    if (_selectPhotoALAssets == nil) {
        _selectPhotoALAssets = [NSMutableArray array];
    }
    return _selectPhotoALAssets;
}

- (void)setSelectPhotoALAssets:(NSMutableArray *)selectPhotoALAssets
{
    _selectPhotoALAssets = selectPhotoALAssets;
}

- (NSMutableArray *)photoGroupArray
{
    if (_photoGroupArray == nil) {
        _photoGroupArray = [NSMutableArray array];
    }
    return _photoGroupArray;
}

- (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t onceToken;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&onceToken,
                  ^{
                      library = [[ALAssetsLibrary alloc] init];
                  });
    return library;
}
@end

//
//  SignUpController.m
//  keeping
//
//  Created by kaidan on 16/6/15.
//  Copyright © 2016年 kaidan. All rights reserved.
//
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SignUpController.h"
#import "SignUpCell.h"
#import "KSDatePicker.h"
#import "photoView.h"
#import "photoViewCell.h"

#define KOriginalPhotoImagePath   \
[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"OriginalPhotoImages"]

@interface SignUpController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSArray* titles;

@property(nonatomic,strong)NSDictionary* month;

@property(nonatomic,strong)NSString* date;

@property(nonatomic,strong)NSMutableArray* imagesList;

@property(nonatomic,strong)photoView* photo;

@end
static NSString* signUpcell = @"cell";
@implementation SignUpController

-(NSMutableArray *)imagesList{
    if (!_imagesList) {
        _imagesList = [NSMutableArray array];
    }
    return _imagesList;
}

-(NSDictionary *)month{
    if (!_month) {
        _month = @{@"01":@"January",
                   @"02":@"February",
                   @"03":@"March",
                   @"04":@"April",
                   @"05":@"May",
                   @"06":@"June",
                   @"07":@"July",
                   @"08":@"August",
                   @"09":@"September",
                   @"10":@"October",
                   @"11":@"November",
                   @"12":@"December"};
    }
    return _month;
}

-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"Name",@"Email",@"Password",@"Birthday"];
    }
    return _titles;
}

-(instancetype)init{
    if (self == [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    CGFloat width = (kSCREEN_SIZE.width - 8)/ 4;
    
    UICollectionViewFlowLayout* flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(width, width);
    flow.sectionInset = UIEdgeInsetsMake(2, 1, 2, 1);
    
    self.photo = [[photoView alloc]initWithFrame:self.view.bounds collectionViewLayout:flow];
    [self.photo registerNib:[UINib nibWithNibName:@"photoViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.photo.alpha = 0;
    self.photo.delegate = self;
    self.photo.dataSource = self;
    [self.view insertSubview:self.photo atIndex:9999];
    
    
    self.date = [NSString string];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [[self.signUpButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.checkButton.backgroundColor = [UIColor colorWithRed:101/255.0 green:99/255.0 blue:164/255.0 alpha:1];
    [self.tableView registerNib:[UINib nibWithNibName:@"SignUpCell" bundle:nil] forCellReuseIdentifier:signUpcell];
    
    [[self.closeButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.addPhoto.layer.cornerRadius = 50;
    
    [[self.addPhoto rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Open Photo" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"Open" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"open");
            
            [self getAllPhotosFromSystemPhotosLibrary];
            
            self.photo.alpha = 1;
            
            CATransition* transition = [CATransition animation];
            transition.type = @"push";
            transition.duration = 0.8;
            
            [self.view.layer addAnimation:transition forKey:nil];
            
        }];
        UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    [[self.checkButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        
    }];
}

#pragma mark - 代理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SignUpCell* cell = [tableView dequeueReusableCellWithIdentifier:signUpcell forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SignUpCell" owner:nil options:nil]lastObject];
    }
    
    cell.title.text = self.titles[indexPath.row];
    cell.textField.tag = 100 + indexPath.row;
    
    if (indexPath.row == 3) {
        cell.textField.alpha = 0;
        if (self.date.length > 0) {
            cell.textField.text = self.date;
            cell.textField.alpha = 1;
        }
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    if (indexPath.row == 3) {
        
        UITextField* textField = [self.tableView viewWithTag:(100 + indexPath.row)];
        [textField resignFirstResponder];
        KSDatePicker* date = [[KSDatePicker alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
        [date show];
        
        @weakify(self);

        date.appearance.resultCallBack = ^(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType)
        {
            if (buttonType == KSDatePickerButtonCommit) {
                @strongify(self);
                textField.alpha = 1;
                NSLog(@"%@",[self getCustemDateWithDate:currentDate]);
                textField.text = [self getCustemDateWithDate:currentDate];
                self.date = textField.text;
            }
            
        };
    }else if (indexPath.row == 2){
        UITextField* textField = [self.tableView viewWithTag:(100 + indexPath.row)];
        textField.secureTextEntry = YES;
    }
}
/**
 *  取得自定义的时间字符串
 */
-(NSString*)getCustemDateWithDate:(NSDate*)date{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"MM";
    NSString* dateStr = [formatter stringFromDate:date];
    
    NSString* key = [dateStr substringWithRange:NSMakeRange(0, 2)];
    
    NSString* month = [self.month objectForKey:key];
    
    formatter.dateFormat = @"dd,yyyy";
    return [NSString stringWithFormat:@"%@ %@",month,[formatter stringFromDate:date]];
}

#pragma mark - UICollectionView代理

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesList.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    photoViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"photoViewCell" owner:nil options:nil]lastObject];
    }
    
    cell.imgView.image = self.imagesList[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中那个cell---%@--",self.imagesList[indexPath.row]);
    
    self.photo.alpha = 0;
    
    CATransition* transition = [CATransition animation];
    transition.type = @"push";
    transition.duration = 0.8;
    
    [self.view.layer addAnimation:transition forKey:nil];
    
}

#pragma mark ======获取到系统相册的所有图片=======

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    
    return destDateString;
    
}

//获取相册里的所有图片
- (void)getAllPhotosFromSystemPhotosLibrary{

    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];//生成整个photolibrary的实例
    
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {//获取所有group
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            //从group里面
            NSString* assetType = [result valueForProperty:ALAssetPropertyType];
            
            if ([assetType isEqualToString:ALAssetTypePhoto]) {
                //NSLog(@"Photo");
                NSDate *date= [result valueForProperty:ALAssetPropertyDate];
                UIImage *image = [UIImage imageWithCGImage:[result thumbnail]];
                NSString *fileName = [[result defaultRepresentation] filename];
                NSURL *url = [[result defaultRepresentation] url];
                NSDictionary *dict = [[result defaultRepresentation]metadata];
                
                //int64_t fileSize = [[result defaultRepresentation] size];
                /*
                 2016-06-27 13:55:17.024 Share_First[2941:1062832] Photo
                 2016-06-27 13:55:17.029 Share_First[2941:1062832] date = 2011-03-13 00:17:25 +0000
                 2016-06-27 13:55:17.030 Share_First[2941:1062832] fileName = IMG_0001.JPG
                 2016-06-27 13:55:17.030 Share_First[2941:1062832] url = assets-library://asset/asset.JPG?id=106E99A1-4F6A-45A2-B320-B0AD4A8E8473&ext=JPG
                 2016-06-27 13:55:17.030 Share_First[2941:1062832] fileSize = 1896240
                 */
                //NSLog(@"元数据=%@",dict);
                //NSLog(@"date = %@",date);//照片拍摄时间
                //NSLog(@"fileName = %@",fileName);//照片名称
                //NSLog(@"url = %@",url);//照片文件URL(非网络URL 浏览器上输入这个URL找不到这张图片 我试了)
                //NSLog(@"fileSize = %lld",fileSize);//照片文件size 具体单位不知道是什么 肯定不是MshareImageView
                
                //latitude:纬度
                //longitude:经度
                
                NSString *Longitude = dict[@"{GPS}"][@"Longitude"];
                NSString *Latitude  = dict[@"{GPS}"][@"Latitude"];
                
                if (Longitude==nil||Latitude==nil) {
                    Longitude = @"";
                    Latitude  = @"";
                }
                
//                NSLog(@"longitude= %@ Latitude = %@",Longitude,Latitude);
                
                [self.imagesList addObject:image];
                
                //读取完照片之后写入APP沙河cache目录  这个方法我在网上找到的
                
                [self imageWithUrl:url withFileName:fileName];
                
                //回到主线程更新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSLog(@"%ld",self.imagesList.count);
                    [self.photo reloadData];
                });
            }
        }];
    } failureBlock:^(NSError *error) {
        NSLog(@"Enumerate the asset groups failed.");
    }];
    
    
}

// 将原始图片的URL转化为NSData数据,写入沙盒
- (void)imageWithUrl:(NSURL *)url withFileName:(NSString *)fileName
{
    // 进这个方法的时候也应该加判断,如果已经转化了的就不要调用这个方法了
    // 如何判断已经转化了,通过是否存在文件路径
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    // 创建存放原始图的文件夹--->OriginalPhotoImages
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:KOriginalPhotoImagePath]) {
        [fileManager createDirectoryAtPath:KOriginalPhotoImagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (url) {
            // 主要方法
            [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
                ALAssetRepresentation *rep = [asset defaultRepresentation];
                Byte *buffer = (Byte*)malloc((unsigned long)rep.size);
                NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:((unsigned long)rep.size) error:nil];
                NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
                NSString * imagePath = [KOriginalPhotoImagePath stringByAppendingPathComponent:fileName];
                [data writeToFile:imagePath atomically:YES];
                
                
            } failureBlock:nil];
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

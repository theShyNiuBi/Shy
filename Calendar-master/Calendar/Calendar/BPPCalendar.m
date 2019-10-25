//
//  BPPCalendar.m
//  Animation
//
//  Created by Onway on 2017/4/7.
//  Copyright © 2017年 Onway. All rights reserved.
//

#import "BPPCalendar.h"
#import "BPPCalendarModel.h"
#import "BPPCalendarCell.h"


@interface BPPCalendar () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) BPPCalendarModel *calendarModel;
@property (nonatomic, strong) NSArray *weekArray;
@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) NSArray *monthArray;
@property (nonatomic, strong) UICollectionView *calendarCollectView;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) NSMutableDictionary *mutDict;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *allChooseBtn;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation BPPCalendar

- (UILabel *)titlelabel {
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 - 60, 10, 120, 30)];
        _titlelabel.font = [UIFont fontWithName:@"PingFangSC" size: 14];
        _titlelabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _titlelabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titlelabel;
}

-(NSArray *)monthArray{
    
    if (!_monthArray) {
        
        _monthArray = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
    }
    return _monthArray;
}

-(UIButton *)cancelBtn{
    
    if (!_cancelBtn) {
        
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,self.titlelabel.frame.origin.y+4, 35, 21)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC" size: 15]];
        [_cancelBtn setTitleColor: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}

-(UIButton *)allChooseBtn{
    
    if (!_allChooseBtn) {
        
        _allChooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width-50,self.titlelabel.frame.origin.y+4, 35, 21)];
        [_allChooseBtn setTitle:@"全部" forState:UIControlStateNormal];
        [_allChooseBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC" size: 15]];
        [_allChooseBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:132/255.0 blue:21/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    return _allChooseBtn;
}

-(UIView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cancelBtn.frame)+11, self.bounds.size.width, 1)];
        [_lineView setBackgroundColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0]];
    }
    return _lineView;
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
//        [self initDataSourse];
//        [self stepUI];
//    }
//    return self;
//}

-(instancetype)initWithFrame:(CGRect)frame andType:(BOOL)type{
    
    self = [super initWithFrame:frame];
      if (self) {
          self.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
          self.isDay = type;
          
//          if (self.isDay) {
//
              [self initDataSourse];
//          }
          
          [self stepUI];
      }
      return self;
}

//初始化数据
- (void)initDataSourse {
    __weak typeof(self) weakSelf = self;
    if (self.isDay) {
        _weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];

    }
   _calendarModel = [[BPPCalendarModel alloc] init];
    
    
    self.calendarModel.block = ^(NSUInteger year, NSUInteger month) {
        weakSelf.titlelabel.text = [NSString stringWithFormat:@"%lu年%ld月",(unsigned long)year,month];
    };
    _dayArray = [_calendarModel setDayArr];
    self.index = _calendarModel.index;
    _mutDict = [NSMutableDictionary new];
}

//布局
- (void)stepUI {
    
    [self addSubview:self.titlelabel];
    
    if (self.isDay) {
        
        [self addSubview:self.cancelBtn];
    }
    
    [self addSubview:self.allChooseBtn];
    [self addSubview:self.lineView];
    
    CGFloat width =self.isDay?self.bounds.size.width/7.0:self.bounds.size.width/6.0;
    //
    UIButton *lastBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 - 60 - 21, 10, 20, 30)];
//    [lastBtn setTitle:@"上一月" forState:UIControlStateNormal];
    [lastBtn setImage:[UIImage imageNamed:@"left_choose_icon"] forState:UIControlStateNormal];
    [lastBtn addTarget:self action:@selector(lastMonthClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lastBtn];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 + 60
                                                                   , 10, 20, 30)];
//    [nextBtn setTitle:@"下一月" forState:UIControlStateNormal];
    [nextBtn setImage:[UIImage imageNamed:@"right_choose_icon"] forState:UIControlStateNormal];

    [nextBtn addTarget:self action:@selector(nextMonthClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextBtn];
    
    for (int i = 0; i < [_weekArray count]; i ++) {
        UIButton *weekBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 50, width, width)];
        [weekBtn setTitle:_weekArray[i] forState:UIControlStateNormal];
        [weekBtn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
        [weekBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size: 14]];
        [self addSubview:weekBtn];
    }
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    
    _calendarCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,self.isDay?width+50:width-10, self.bounds.size.width, self.bounds.size.height - width) collectionViewLayout:flowlayout];
    _calendarCollectView.delegate = self;
    _calendarCollectView.dataSource = self;
    [_calendarCollectView registerClass:[BPPCalendarCell class] forCellWithReuseIdentifier:@"cell"];
//    _calendarCollectView.backgroundColor = [UIColor yellowColor];
    _calendarCollectView.backgroundColor =[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
//    self.calendarCollectView.alwaysBounceVertical=YES;
    [self addSubview:_calendarCollectView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.isDay?[_dayArray count]:[self.monthArray count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.isDay?CGSizeMake(self.bounds.size.width/7.0, self.bounds.size.width/7.0):CGSizeMake(self.bounds.size.width/6.0, self.bounds.size.width/6.0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BPPCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    if (self.isDay) {
        
        NSDictionary *dict = self.dayArray[indexPath.row];
        
         NSString *mark =dict[@"mark"];
         
         if ([mark isEqualToString:@"lastOrNext"]) {
             
             cell.textLabel.textColor = [UIColor grayColor];
         }
         else{
             
             cell.textLabel.textColor = [UIColor blackColor];
         }
         
         cell.textLabel.text = dict[@"day"];
//         NSString *ymdTitle = [NSString stringWithFormat:@"%@%@日",self.titlelabel.text,dict[@"day"]];
//         NSString *ymdString = [NSString stringWithFormat:@"%@%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"year"], [[NSUserDefaults standardUserDefaults] objectForKey:@"month"],  [[NSUserDefaults standardUserDefaults] objectForKey:@"day"]];
//
//         if ([ymdTitle isEqualToString:ymdString]) {
//
//                 cell.textLabel.textColor = [UIColor whiteColor];
//                 cell.textLabel.layer.cornerRadius = cell.textLabel.frame.size.height/2.0;
//                 cell.textLabel.clipsToBounds = YES;
//                 cell.textLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:132/255.0 blue:21/255.0 alpha:1.0];
//
//             }else {
                 
         cell.textLabel.layer.cornerRadius = cell.textLabel.frame.size.height/2.0;
        
         cell.textLabel.clipsToBounds = YES;
         
         if ([self.mutDict valueForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
             
             cell.textLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:132/255.0 blue:21/255.0 alpha:1.0];
             cell.textLabel.textColor = [UIColor whiteColor];

             
         }else {
             
             cell.textLabel.backgroundColor = [UIColor clearColor];
         }
//             }

         
    }else{
        
        NSString *mark =self.monthArray[indexPath.row];
        
        cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
                
        cell.textLabel.text = mark;
        
//        NSArray *array = [self.titlelabel.text componentsSeparatedByString:@"年"];
//
//        NSString *ymdTitle =  [NSString stringWithFormat:@"%@年%@",array[0],mark];
//
//        NSString *ymdString = [[NSUserDefaults standardUserDefaults]objectForKey:@"todays"];
//
//        if ([ymdTitle isEqualToString:ymdString]) {
//
//            cell.textLabel.textColor = [UIColor whiteColor];
//            cell.textLabel.layer.cornerRadius = cell.textLabel.frame.size.height/2.0;
//            cell.textLabel.clipsToBounds = YES;
//            cell.textLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:132/255.0 blue:21/255.0 alpha:1.0];
//
//        }else {
            
        cell.textLabel.layer.cornerRadius = cell.textLabel.frame.size.height/2.0;
        
        cell.textLabel.clipsToBounds = YES;
        
        if ([self.mutDict valueForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
            
            cell.textLabel.backgroundColor =  [UIColor colorWithRed:255/255.0 green:132/255.0 blue:21/255.0 alpha:1.0];
            
            cell.textLabel.textColor = [UIColor whiteColor];

            
        }else {
            
            cell.textLabel.backgroundColor = [UIColor clearColor];
        }
//        }
    }
 
    return cell;
}

- (void)lastMonthClick {
    
    [self.mutDict removeAllObjects];
    self.dayArray = [self.calendarModel lastMonthDataArr];
    [self.calendarCollectView reloadData];
}

- (void)nextMonthClick {
    [self.mutDict removeAllObjects];
    self.dayArray = [self.calendarModel nextMonthDataArr];
    [self.calendarCollectView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    BPPCalendarCell *cell = (BPPCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    [self.mutDict removeAllObjects];
    //给这个cell进行标注 后面显示就是点击状态
    [self.mutDict setValue:@"value" forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
    [self.calendarCollectView reloadData];
    
    //我将数据分为三部分处理，第一，获取本月的天数范围，第二，获取上个月与本月第一天遗留的天数，第三，获取到本月最后一天yu
}


@end

//
//  ViewController.m
//  CopyAndMutableCopy
//
//  Created by 王永顺 on 2018/5/9.
//  Copyright © 2018年 EasonWang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     
     No1：可变对象的copy和mutableCopy方法都是深拷贝（区别完全深拷贝与单层深拷贝） 。
     
     No2：不可变对象的copy方法是浅拷贝，mutableCopy方法是深拷贝。//不安全
     
     No3：copy方法返回的对象都是不可变对象。
     */
    
    //不可变的NSString
//    [self imMutableNSStringTest];
    
    //可变对象NSMutableString
//    [self mutableNSStringTest];
    
    //不可变对象NSArray
//    [self immutableNSArrayTest];
    
    //可变对象NSMutableArray
//    [self NSMutableArrayTest];
    
    //单层copy分析
//    [self singleNSMutableArrayTest];
    
    //深拷贝分析
    [self deplyFullCopy];

}


#pragma mark - 不可变的NSString
- (void) imMutableNSStringTest
{
    NSString *str1 = @"Eason";
    
    NSString *str2 = [str1 copy];
    //    NSMutableString *str2 = [str1 copy];
    //copy返回的是不可变对象，str2不能被修改，因此会发生崩溃
    //[str2 appendString:@"test"];
    
    NSMutableString *str3 = [str1 mutableCopy];
    [str3 appendString:@"modify"];
    
    NSLog(@"str1:%p - %@ \r\n",str1,str1);//str1:0x107db9068 - Eason
    NSLog(@"str2:%p - %@ \r\n",str2,str2);//str2:0x107db9068 - Eason
    NSLog(@"str3:%p - %@ \r\n",str3,str3);//str3:0x604000240450 - Easonmodify
    
    
    /**
     结论:
     copy:         浅拷贝 ----- 拷贝指针
     mutableCopy : 深拷贝 ----- 拷贝内容
     */
}

#pragma mark - 可变对象NSMutableString
- (void) mutableNSStringTest
{
    NSMutableString *mstr1 = [NSMutableString stringWithString:@"test002"];
    
    NSMutableString *mstr2 = [mstr1 copy];
    //copy返回的是不可变对象，mstr2不能被修改，因此会发生崩溃
    //[str2 appendString:@"test"];
    
    NSMutableString *mstr3 = [mstr1 mutableCopy];
    [mstr3 appendString:@"modify"];
    
    NSLog(@"mstr1:%p - %@ \r\n",mstr1,mstr1);//mstr1:0x60c0002533b0 - test002
    NSLog(@"mstr2:%p - %@ \r\n",mstr2,mstr2);//mstr2:0xa323030747365747 - test002
    NSLog(@"mstr3:%p - %@ \r\n",mstr3,mstr3);//mstr3:0x60c000253200 - test002modify

    
    /**
     结论:
     copy:         深拷贝 ----- 拷贝指针
     mutableCopy : 深拷贝 ----- 拷贝内容
     */
    
}

#pragma mark - 不可变对象NSArray
- (void) immutableNSArrayTest
{
    NSArray *arry1 = [[NSArray alloc] initWithObjects:@"Eason", @"Wang",nil];
    
    NSArray *arry2 = [arry1 copy];
    NSArray *arry3 = [arry1 mutableCopy];
    
    NSLog(@"arry1:%p - %@ \r\n",arry1,arry1);//0x60c000024020
    NSLog(@"arry2:%p - %@ \r\n",arry2,arry2);//0x60c000024020
    NSLog(@"arry3:%p - %@ \r\n",arry3,arry3);//0x60c000245670
    
    /**
     结论:
     copy:         浅拷贝 ----- 拷贝指针
     mutableCopy : 深拷贝 ----- 拷贝内容
     */
}

#pragma mark - 可变对象NSMutableArray
- (void) NSMutableArrayTest
{
    NSMutableArray *marry1 = [[NSMutableArray alloc] initWithObjects:@"Eason", @"Wang",nil];
    
    NSMutableArray *marry2 = [marry1 copy];
    
    //copy返回的是不可变对象，marry2不能被修改，因此会崩溃
    //[marry2 addObject:@"value3"];
    
    NSMutableArray *marry3 = [marry1 mutableCopy];
    
    NSLog(@"marry1:%p - %@ \r\n",marry1,marry1);//0x60800024d0b0
    NSLog(@"marry2:%p - %@ \r\n",marry2,marry2);//0x608000237300
    NSLog(@"marry3:%p - %@ \r\n",marry3,marry3);//0x60800024d500
    
    
    /**
     结论:
     copy:         深拷贝 ----- 拷贝指针
     mutableCopy : 深拷贝 ----- 拷贝内容
     */
}

/**
 
 特别注意的是：对于集合类的可变对象来说，深拷贝并非严格意义上的深复制，只能算是单层深复制，即虽然新开辟了内存地址，但是存放在内存上的值（也就是数组里的元素仍然是原数组元素值，并没有另外复制一份），这就叫做单层深复制。
 */

#pragma mark - 单层copy分析
- (void)singleNSMutableArrayTest
{
    NSMutableArray *marry1 = [[NSMutableArray alloc] init];
    
    NSMutableString *mstr1 = [[NSMutableString alloc]initWithString:@"Eason"];
    NSMutableString *mstr2 = [[NSMutableString alloc]initWithString:@"Wang"];
    
    [marry1 addObject:mstr1];
    [marry1 addObject:mstr2];
    
    NSMutableArray *marry2 = [marry1 copy];
    NSMutableArray *marry3 = [marry1 mutableCopy];
    
    NSLog(@"marry1:%p - %@ \r\n",marry1,marry1);//0x60c000246cf0
    NSLog(@"marry2:%p - %@ \r\n",marry2,marry2);//0x60c000034f00
    NSLog(@"marry3:%p - %@ \r\n",marry3,marry3);//0x60c000246f00
    NSLog(@"数组元素地址:value1:%p - value2:%p \r\n",marry1[0],marry1[1]);//value1:0x60c000247050 - value2:0x60c000246c90
    NSLog(@"数组元素地址:value1:%p - value2:%p \r\n",marry2[0],marry2[1]);//value1:0x60c000247050 - value2:0x60c000246c90
    NSLog(@"数组元素地址:value1:%p - value2:%p \r\n",marry3[0],marry3[1]);//value1:0x60c000247050 - value2:0x60c000246c90
    
    NSLog(@"\r\n------------------修改原值后------------------------\r\n");
    [mstr1 appendFormat:@"aaa"];
    
    NSLog(@"marry1:%p - %@ \r\n",marry1,marry1);//0x60c000246cf0
    NSLog(@"marry2:%p - %@ \r\n",marry2,marry2);//0x60c000034f00
    NSLog(@"marry3:%p - %@ \r\n",marry3,marry3);//0x60c000246f00
    NSLog(@"数组元素地址:value1:%p - value2:%p \r\n",marry1[0],marry1[1]);//value1:0x60c000247050 - value2:0x60c000246c90
    NSLog(@"数组元素地址:value1:%p - value2:%p \r\n",marry2[0],marry2[1]);//value1:0x60c000247050 - value2:0x60c000246c90
    NSLog(@"数组元素地址:value1:%p - value2:%p \r\n",marry3[0],marry3[1]);//value1:0x60c000247050 - value2:0x60c000246c90
    
    
    /**
     分析：在修改原值之前，marry1、marry2、marr3 地址都不一样，很明显copy和mutableCopy都是深拷贝，但是从修改原值后的打印结果来看，这里的深拷贝只是单层深拷贝：新开辟了内存地址，但是数组中的值还是指向原数组的，这样才能在修改原值后，marry2 marr3中的值都修改了。另外，从打印的数组元素地址可以很明显的看出来，修改前后marry1、marry、marr3的数组元素地址都是一模一样的，更加佐证了这一点。
     */
}

#pragma mark - 深拷贝
- (void) deplyFullCopy
{
    NSMutableArray *marry1 = [[NSMutableArray alloc] init];
    
    NSMutableString *mstr1 = [[NSMutableString alloc]initWithString:@"Eason"];
    NSMutableString *mstr2 = [[NSMutableString alloc]initWithString:@"Wang"];
    
    [marry1 addObject:mstr1];
    [marry1 addObject:mstr2];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:marry1];
    NSArray *marray2 = [NSKeyedUnarchiver unarchiveTopLevelObjectWithData:data error:nil];
    
    NSLog(@"marry1:%p - %@ \r\n",marry1,marry1);//0x60400005b390
    NSLog(@"marry2:%p - %@ \r\n",marray2,marray2);//0x60400005b6f0
    NSLog(@"数组元素地址:value1:%p - value2:%p \r\n",marry1[0],marry1[1]);//value1:0x60400005b630 - value2:0x60400005b3f0
    NSLog(@"数组元素地址:value1:%p - value2:%p \r\n",marray2[0],marray2[1]);//value1:0x60400005b5d0 - value2:0x60400005b720
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

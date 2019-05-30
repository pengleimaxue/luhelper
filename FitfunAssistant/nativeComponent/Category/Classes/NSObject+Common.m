////
//  NSObject+Common.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/15.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "NSObject+Common.h"

@implementation NSObject (Common)

- (NSArray *)jsonDataToModelWithDataSouce:(NSArray <NSDictionary *>*)dataSouce
                                modelName:(NSString *)modelName {
    if (![dataSouce isKindOfClass: [NSArray class]]) {
        return @[];
    }
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
    Class modelClass = NSClassFromString(modelName);
    [dataSouce enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id  model = [[modelClass alloc] init];
        [model setValuesForKeysWithDictionary:obj];
        [dataArray addObject:model];
    }];
    return [NSArray arrayWithArray:dataArray];
}

- (NSDictionary *)emotionsDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"em_001" forKey:@"[:1]"];
    [dic setObject:@"em_002" forKey:@"[:2]"];
    [dic setObject:@"em_003" forKey:@"[:3]"];
    [dic setObject:@"em_004" forKey:@"[:4]"];
    [dic setObject:@"em_005" forKey:@"[:5]"];
    [dic setObject:@"em_006" forKey:@"[:6]"];
    [dic setObject:@"em_007" forKey:@"[:7]"];
    [dic setObject:@"em_008" forKey:@"[:8]"];
    [dic setObject:@"em_009" forKey:@"[:9]"];
    [dic setObject:@"em_010" forKey:@"[:10]"];
    [dic setObject:@"em_011" forKey:@"[:11]"];
    [dic setObject:@"em_012" forKey:@"[:12]"];
    [dic setObject:@"em_013" forKey:@"[:13]"];
    [dic setObject:@"em_014" forKey:@"[:14]"];
    [dic setObject:@"em_015" forKey:@"[:15]"];
    [dic setObject:@"em_016" forKey:@"[:16]"];
    [dic setObject:@"em_017" forKey:@"[:17]"];
    [dic setObject:@"em_018" forKey:@"[:18]"];
    [dic setObject:@"em_019" forKey:@"[:19]"];
    [dic setObject:@"em_020" forKey:@"[:20]"];
    [dic setObject:@"em_021" forKey:@"[:21]"];
    [dic setObject:@"em_022" forKey:@"[:22]"];
    [dic setObject:@"em_023" forKey:@"[:23]"];
    [dic setObject:@"em_024" forKey:@"[:24]"];
    [dic setObject:@"em_025" forKey:@"[:25]"];
    [dic setObject:@"em_026" forKey:@"[:26]"];
    [dic setObject:@"em_027" forKey:@"[:27]"];
    [dic setObject:@"em_028" forKey:@"[:28]"];
    [dic setObject:@"em_029" forKey:@"[:29]"];
    [dic setObject:@"em_030" forKey:@"[:30]"];
    [dic setObject:@"em_031" forKey:@"[:31]"];
    [dic setObject:@"em_032" forKey:@"[:32]"];
    [dic setObject:@"em_033" forKey:@"[:33]"];
    [dic setObject:@"em_034" forKey:@"[:34]"];
    [dic setObject:@"em_035" forKey:@"[:35]"];
    [dic setObject:@"em_036" forKey:@"[:36]"];
    [dic setObject:@"em_037" forKey:@"[:37]"];
    [dic setObject:@"em_038" forKey:@"[:38]"];
    [dic setObject:@"em_039" forKey:@"[:39]"];
    [dic setObject:@"em_040" forKey:@"[:40]"];
    [dic setObject:@"em_041" forKey:@"[:41]"];
    [dic setObject:@"em_042" forKey:@"[:42]"];
    [dic setObject:@"em_043" forKey:@"[:43]"];
    [dic setObject:@"em_044" forKey:@"[:44]"];
    [dic setObject:@"em_045" forKey:@"[:45]"];
    [dic setObject:@"em_046" forKey:@"[:46]"];
    [dic setObject:@"em_047" forKey:@"[:47]"];
    [dic setObject:@"em_048" forKey:@"[:48]"];
    [dic setObject:@"em_049" forKey:@"[:49]"];
    [dic setObject:@"em_050" forKey:@"[:50]"];
    [dic setObject:@"em_051" forKey:@"[:51]"];
    [dic setObject:@"em_052" forKey:@"[:52]"];
    [dic setObject:@"em_053" forKey:@"[:53]"];
    [dic setObject:@"em_054" forKey:@"[:54]"];
    [dic setObject:@"em_055" forKey:@"[:55]"];
    [dic setObject:@"em_056" forKey:@"[:56]"];
    [dic setObject:@"em_057" forKey:@"[:57]"];
    [dic setObject:@"em_058" forKey:@"[:58]"];
    [dic setObject:@"em_059" forKey:@"[:59]"];
    [dic setObject:@"em_060" forKey:@"[:60]"];
    [dic setObject:@"em_061" forKey:@"[:61]"];
    [dic setObject:@"em_062" forKey:@"[:62]"];
    [dic setObject:@"em_063" forKey:@"[:63]"];
    [dic setObject:@"em_064" forKey:@"[:64]"];
    [dic setObject:@"em_065" forKey:@"[:65]"];
    [dic setObject:@"em_066" forKey:@"[:66]"];
    [dic setObject:@"em_067" forKey:@"[:67]"];
    [dic setObject:@"em_068" forKey:@"[:68]"];
    [dic setObject:@"em_069" forKey:@"[:69]"];
    [dic setObject:@"em_070" forKey:@"[:70]"];
    [dic setObject:@"em_071" forKey:@"[:71]"];
    [dic setObject:@"em_072" forKey:@"[:72]"];
    [dic setObject:@"em_073" forKey:@"[:73]"];
    [dic setObject:@"em_074" forKey:@"[:74]"];
    [dic setObject:@"em_075" forKey:@"[:75]"];
    [dic setObject:@"em_076" forKey:@"[:76]"];
    [dic setObject:@"em_077" forKey:@"[:77]"];
    [dic setObject:@"em_078" forKey:@"[:78]"];
    [dic setObject:@"em_079" forKey:@"[:79]"];
    [dic setObject:@"em_080" forKey:@"[:80]"];
    [dic setObject:@"em_081" forKey:@"[:81]"];
    
    return dic;
}
@end

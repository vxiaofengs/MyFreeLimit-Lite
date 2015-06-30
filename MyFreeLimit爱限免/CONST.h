
//
//  Header.h
//  LimitFree
//
//  Created by DuHaiFeng on 13-12-24.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#ifndef LimitFree_Header_h
#define LimitFree_Header_h

//限免接口

#define LIMIT_URL_MAIN @"http://iappfree.candou.com:8080/free/applications/limited?page=%d&number=%d"

#define LIMIT_URL(page,number) [NSString stringWithFormat:@"http://iappfree.candou.com:8080/free/applications/limited?page=%d&number=%d",page,number]
#define LIMIT_TYPE 1

//降价接口
#define REDUCE_URL_MAIN @"http://1000phone.net:8088/app/iAppFree/api/reduce.php?page=%d&number=%d"

#define REDUCE_URL(page,number) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/reduce.php?page=%d&number=%d",page,number]
#define REDUCE_TYPE 2

//免费接口
#define FREE_URL_MAIN @"http://1000phone.net:8088/app/iAppFree/api/free.php?page=%d&number=%d"

#define FREE_URL(page,number) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/free.php?page=%d&number=%d",page,number]
#define FREE_TYPE 3

//专题接口,待定
#define SUBJECT_URL_MAIN @"http://1000phone.net:8088/app/iAppFree/api/special.php?page=%d&number=%d"
#define SPECIAL_URL(page) [NSString stringWithFormat:@"http://iappfree.candou.com:8080/free/special?page=%d&limit=5",page]
#define SUBJECT_TYPE 4
//热榜接口

#define HOT_URL_MAIN @"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=%d&number=%d"

#define HOT_URL(page,number) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=%d&number=%d",page,number]
#define HOT_TYPE 5

//详情接口
#define DETAIL_URL(appid) [NSString stringWithFormat:@"http://iappfree.candou.com:8080/free/applications/%@",appid]
#endif

//附近的人
#define RECOMMENT_URL @"http://iappfree.candou.com:8080/free/applications/recommend?longitude=116.344539&latitude=40.034346"

//#define CATEGORY_URL @"http://1000phone.net:8080/app/iAppFree/api/appcate.php"

#define CATEGORY_URL @"http://open.candou.com/app/count"

//专题接口地址
#define SUBJECT_URL @"http://iappfree.candou.com:8080/free/special"

//搜索接口
//搜索
#define SEARCH_GENERAL(type,page,text) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/%@.php?page=%d&number=10&search=%@",type,page,text]



#define Limit_SEARCH(page,text) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/limited.php?page=%d&number=10&search=%@",page,text]
#define SALE_SEARCH(page,text) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/reduce.php?page=%d&number=10&search=%@",page,text]
#define FREE_SEARCH(page,text) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/free.php?page=%d&number=10&search=%@",page,text]
#define HOT_SEARCH(page,text) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=%d&number=10&search=%@",page,text]
//搜索公用接口
#define SEARCH_URL(text,num,name) [NSString stringWithFormat:@"http://open.candou.com/search/app/word/%@/app/iphone/rank/0/start/%d/%@/10",text,num,name]




//分类API
#define APPCATE @"http://1000phone.net:8088/app/iAppFree/api/appcate.php"

//分类限免费接口:
#define APPCATE_LIMIT @"http://1000phone.net:8088/app/iAppFree/api/limited.php?page=1&number=20&cate_id=6014"
//分类降价接口:
#define APPCATE_SALE @"http://1000phone.net:8088/app/iAppFree/api/reduce.php?page=1&number=20&cate_id=6014"
//分类免费接口:
#define APPCATE_FREE @"http://1000phone.net:8088/app/iAppFree/api/free.php?page=1&number=20&cate_id=6014"
//分类热榜接口:
#define APPCATE_HOT @"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=1&number=20&cate_id=6014"
//分类公用接口:
#define APPCATE_ALL(page,appid) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/limited.php?page=%d&number=10&cate_id=%@",page,appid]
//参数page，表示显示第几页结果。
//cate_id表示分组id


//自定义分类检索接口
#define APPCATE_ALL_CUSTOM(type,page,appid) [NSString stringWithFormat:@"http://1000phone.net:8088/app/iAppFree/api/%@.php?page=%d&number=10&cate_id=%@",type,page,appid]


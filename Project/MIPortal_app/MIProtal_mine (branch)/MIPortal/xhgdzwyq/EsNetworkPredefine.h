//
//  EsNetworkPredefine.h
//  xhgdzwyq
//
//  Created by Eshore on 13-11-12.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#ifndef xhgdzwyq_EsNetworkPredefine_h
#define xhgdzwyq_EsNetworkPredefine_h

#define IURL @"http://app.xhzwyq.com:7101/news/iface.htm"

#define NETWORK_OK  @"00"   //成功
#define NETWORK_ERR @"01"   //失败
#define NETWORK_PARA_EMPTY  @"02"   //输入参数为空
#define NETWORK_NOTEXIST    @"03"   //查询的结果集不存在
#define NETWORK_CALLERR     @"04"   //调用出现异常
#define NETWORK_ERR_NET     @"05"   //网络故障
#define NETWORK_TIMEOUT_RSP @"06"   //系统响应超时
#define NETWORK_TIMEOUT_STAMP   @"10"    //时间戳超时
#define NETWORK_NOPHONENUM  @"11"   //该号码暂没开通订阅服务
#define NETWORK_WRONGTOKE   @"12"   //token验证错误
#define NETWORK_TIMEOUT_TOKEN   @"13"   //Token 已过时
#define NETWORK_RSTEMPTY    @"14"   //结果为空
#define NETWORK_VERIFYERR   @"15"   //验证码验证失败或失效
#define NETWORK_ERR_SYS     @"99"   //系统异常

#endif

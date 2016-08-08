//
//  WeiBoNetWorkTool.swift
//  新浪微博项目
//
//  Created by 王炯 on 16/7/22.
//  Copyright © 2016年 王炯. All rights reserved.
//

import UIKit


class WeiBoNetWorkTool: AFHTTPSessionManager
{

    //Swift单例的写法
    static let sharedTools:WeiBoNetWorkTool = {
       
        let tool = WeiBoNetWorkTool()
        
        //指定反序列化的格式
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tool
    }()
    
    //添加GET方法
    func GetWebData(urlString:String,parameters:AnyObject?,successCallBack:(response: AnyObject?) -> (),errorCallBack:(error: NSError) -> ())
    {
        //获取网络信息
        //尾随闭包的写法
        self.GET(urlString, parameters: parameters, progress:nil, success: { (_, result) in
            
            successCallBack(response: result)
            
            })
        { (_, error) in
            
            errorCallBack(error: error)
        }
    }
    
    //添加POST方法
    func PostWebData(urlString:String,parameters:AnyObject?,successCallBack:(response: AnyObject?) -> (),errorCallBack:(error: NSError) -> ())
    {
        self.POST(urlString, parameters: parameters, progress: nil, success: { (_,result) in
            
            successCallBack(response: result)
            
            
        }) { (_, error) in
            
            errorCallBack(error: error)
            
            
        }
    }
    
    
    
    
    
}


extension WeiBoNetWorkTool
{
    
    //在扩展中声明一个指定方法请求accessToken获取授权
    func POSTAccessToken(code:String,success: (response: AnyObject?)->(), failure: (error: NSError)->())
    {
        //url网址信息
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        
        //参数信息
        let param:[String:String] = ["client_id":"3367173614",
                                     "client_secret":"69843d1efabf2074f7ad2c53db30896b",
                                     "grant_type":"authorization_code",
                                     "code":code,
                                     "redirect_uri":"http://www.baidu.com"]
        //发送POST请求
        self.PostWebData(urlString, parameters: param, successCallBack: success, errorCallBack: failure)
        
    }
    
    //在扩展中声明一个指定方法根据token获取用户的基本信息
    func GETUserInfo(model:TokenModel,success: (response: AnyObject?)->(), failure: (error: NSError)->())
    {
        //url网址信息
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        guard let token = model.access_token,uid = model.uid else
        {
            return
        }
        
        let param:[String:AnyObject] = ["access_token":token,
                                        "uid":uid,
                                        ]
        
        //发送GET请求
        self.GetWebData(urlString, parameters: param, successCallBack: success, errorCallBack: failure)
        
    }
    
}

extension WeiBoNetWorkTool
{
    //在扩展中声明一个指定方法获取首页数据
    //传入maxID和sinceID信息用来实现刷新数据的功能
    func GETHomeData(sinceId: Int64, maxId: Int64,model:TokenModel,success: (response: AnyObject?)->(), failure: (error: NSError)->())
    {
        //(1)urlString
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        guard let token = model.access_token else
        {
            return
        }
        
        //(2)参数(token是唯一必选,传入maxID和sinceID用于实现刷新数据功能)
        let param = ["access_token":token,
                     "since_id":"\(sinceId)",
                     "max_id":"\(maxId)"] as [String:AnyObject]
        /*
         since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
         max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        */
        
        
        //发送GET请求
        self.GetWebData(urlString, parameters: param, successCallBack: success, errorCallBack: failure)
    }


}
/*
extension WeiBoNetWorkTool
{
    /**
     发送图片微博
     
     - parameter status:    需要发送的文本
     - parameter imageList: 需要发送的图片数组
     - parameter success:   发送成功之后的回调
     - parameter failure:   发送失败之后的回调
     */
    func composeUpload(status: String, imageList: [UIImage], success: (response: AnyObject?)->(), failure: (error: NSError)->())
    {
        
        //(1)请求的urlString
        let urlString = "https://upload.api.weibo.com/2/statuses/upload.json"
        //(2)参数
        let param = ["access_token":AuthViewModel.AuthViewModelTools.accessToken ?? "",
                     "status":status]
        
        //(3)发送请求:POST请求
        //利用AFN的另一个POST方法
        self.POST(urlString, parameters: param, constructingBodyWithBlock: { (formdata) in
            
            
            
            
            
            // 发送多张图片
            for i in 0..<imageList.count {
                
                //图片数据转换成NSData形式的数据流
                let data = UIImagePNGRepresentation(imageList[i])!
                
                
                /*
                 - 01参数: 客户端需要提交的二进制文件
                 - 02参数: 服务器端给客户端提供的名字 服务器才知道你传的是什么模块里面的图片
                 - 03参数: 服务器端保存文件的文件夹  客户端 可以随意传
                 - 04参数: 代表客户端提交的二进制文件格式 一般可以使用该类型 application/octet-stream 忽略格式
                 */
                formdata.appendPartWithFileData(data, name: "pic", fileName: "oooo", mimeType: "application/octet-stream")
            }
            
            
            
            
            
            },progress: nil, success: { (_, resopnse) in
                
                success(response: resopnse)
                
            }) { (_, error) in
                
                failure(error: error)
        }
    }
}
*/


# Swift版百思不得姐

##模块分类

1. 精华模块
2. 新帖
3. 关注
4. 我的
5. 登录注册
6. 发帖
7. 推荐关注
8. 推荐列表


##功能实现
1. 项目框架的搭建，采用的是经典的TabBarController + NavigationController + 子控制器的方法

```
    private func setupChildVcs() {
    
        setupChildVc(vc: EssenseController(),title:"精华",image:"tabBar_essence_icon",selectedImage:"tabBar_essence_click_icon")
        setupChildVc(vc: NewViewController(),title:"新帖",image:"tabBar_new_icon",selectedImage:"tabBar_new_click_icon")
        setupChildVc(vc: FriendThrendController(),title:"关注",image:"tabBar_friendTrends_icon",selectedImage:"tabBar_friendTrends_click_icon")
        setupChildVc(vc: ProfileController(),title:"我",image:"tabBar_me_icon",selectedImage:"tabBar_me_click_icon")

    }
    
        private func setupChildVc(vc:UIViewController,title:String,image:String,selectedImage:String) {
    
        let nav = NavigationController(rootViewController: vc)
        
        addChildViewController(nav)
        
        nav.tabBarItem.title = title
        
        nav.tabBarItem.image = UIImage(named: image)
        
        nav.tabBarItem.selectedImage = UIImage(named: selectedImage)
        
        
    }
```

在列表页中采用的是控制器中添加子控制器的方法，因为是初次尝试swift项目，这里没有采用tableView的复用，具体代码如下:

```
    func setupChildVcs()  {
        automaticallyAdjustsScrollViewInsets = false
        let all = TopViewController()
        all.type = 1
        all.a = a
        addChildViewController(all)
        let video = TopViewController()
        video.type = 41
        video.a = a
        addChildViewController(video)
        let voice = TopViewController()
        voice.type = 31
        voice.a = a
        addChildViewController(voice)
        let picture = TopViewController()
        picture.type = 10
        picture.a = a
        addChildViewController(picture)
        let words = TopViewController()
        words.type = 29
        words.a = a 
        addChildViewController(words)
        
        
    }
```

注：这里的TopViewController是父类，所有的网络数据请求及页面布局都是在父类里面完成，子类只是各自管理自己的特殊地方


2. 点击加号进入发帖界面，界面动画显示，采用的是POP第三方库，做的炫酷动画，有兴趣的同学可以去研究一下这个

代码实现逻辑很简单：

```
            let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
            animation?.fromValue = NSValue.init(cgRect: CGRect(x: buttonX, y: CGFloat(buttonH) - ConstTool.instance.kScreenH, width: CGFloat(buttonW), height: CGFloat(buttonH)))
            animation?.toValue = NSValue.init(cgRect: CGRect(x: buttonX, y: CGFloat(buttonEndY), width: CGFloat(buttonW), height: CGFloat(buttonH)))
            animation?.springBounciness = 5
            animation?.springSpeed = 15
            animation?.beginTime = CACurrentMediaTime() + CFTimeInterval(0.1 * CGFloat(i))
            button.pop_add(animation, forKey: nil)

```
3. 登录/注册界面采用的是xib形式，个人感觉xib用起来老舒服了，省去了好多代码

4. 推荐关注界面采用的同样是xib形式，是两个tableView加到一个控制器view上，分别对其进行了控制，这里要提到的一点是，这里采用了将tableView与控制器分离的方式，采用了MVVM的模式对数据及界面进行管理，控制器代码非常的少。

首先我做了一个RecommedManager类去管理tableView的布局(代理方法都在这个类中实现)

另外定义了一个RecommendViewModel类，这个类用来管理数据的下载和解析，控制器只需要将tableView传递给RecommendViewModel，之后由这个类来关联数据和view的交互

```
    func getRecommendCategoryDataFromNet() {
        
        SVProgressHUD.show()
        
        var parameters = [String:Any]()
        
        parameters["a"] = "category"
        parameters["c"] = "subscribe"
        let manager = AFHTTPSessionManager()
        
         manager.get("http://api.budejie.com/api/api_open.php", parameters: parameters, progress: {(progress) in
        
        }, success: { (task, responseObj)  in
        SVProgressHUD.dismiss()
            if responseObj != nil {
                
                let response = responseObj as! [String:Any]
                
                self.categoryArray = CategoryModel.mj_objectArray(withKeyValuesArray: response["list"])
                
                self.categoryView.reloadData()
                
                let indexPath = NSIndexPath(row: 0, section: 0)
                
                self.categoryView.selectRow(at: indexPath as IndexPath, animated: false, scrollPosition: .top)
                let model = self.categoryArray[0] as! CategoryModel
                
                self.getRecommendCategoryListDataFromNetWithCategoryId(ID: model.ID)
                
            }
            
        }, failure: {(task, error )  in
        
            SVProgressHUD.showError(withStatus: "分类数据加载失败")
        })
        
    }

```

self.categoryView.reloadData() 数据返回之后，调用这个就可以刷新列表了，是不是很方便呢

对于MVVM的模式，我用的并不是很熟练，只能说减轻了控制器的代码，而且并不是正统纯粹的MVVM，如果有精通MVVM或者理解的深刻的大神，请多多指教

最后，本次项目只是简略实现了百思不得姐的部分内容，登录，注册，点赞，收藏，分享，评论等功能暂时还没有做，后续如果可能，笔者会更新demo，对于swift,笔者是首次尝试来改写项目，就是照着OC代码去改成swift样式，有些地方还需要优化，放到这里，大家相互学习吧

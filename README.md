# FSUnionAdSDK


# 版本更新说明

- **SDK版本**：1.0.1.50
- 支持 CocoaPods


# 开发环境

- **开发工具** ：Xcode15.4
- **部署目标** ：iOS 12.0及以上版本
- **SDK版本** ：官网最新版本
- **支持架构** ：arm64


# 使用CocoaPods

CocoaPods是专门为iOS工程提供第三方依赖库的管理工具，它自动化并简化了在项目中使用第三方库的过程，通过CocoaPods，您可以更快速便捷的获取最新版本的SDK。

您可以通过以下命令进行CocoaPods的安装：

```shell
gem install cocoapods
```

## Podfile

为了您能集成FSUnionAdSDK到Xcode工程中，请在Podfile文件中指定它

```ruby
target 'Your APP Xcode Project' do
    pod 'FSUnionAdSDK'
end
```

然后执行

```shell
pod install
```

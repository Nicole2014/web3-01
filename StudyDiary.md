# 001 002 003 004 文件内容
001 002 solidity文件的基本语法，数据结构，函数写法，一些关键字的作用  
003 合约之间调用方式  
004 一个简单逻辑的合约 1.创建一个收款函数//2.记录投资人并且查看//3.锁定期内达到目标值，生产商可以提款//4.锁定期内没有达到目标值，投资人可以在锁定期以后退款  

#### 细节整理：
好的，以下是对您提供的关于智能合约开发内容的整理和翻译，保持中文表述：

# 合约（Contracts）：

## 数据结构：
mapping：键值存储机制。  
数组（[]）：存储相同类型元素的列表。  
struct：类似于其他编程语言中的类。  
基本类型：string（字符串）、int（有符号整数）、uint（无符号整数）、bool（布尔值）、bytes（用于存储字节序列，bytes32最大为32字节）。注意，bytes和bytes后跟数字不是同一种类型，而uint和uint数组（如果长度和元素类型相同）则属于同一类别。  
address：表示以太坊账户地址。
## 存储模式：
storage：永久存储。  
memory：临时存储，用于函数参数，运行时可修改。  
calldata：临时存储，用于函数参数，运行时不可修改。  
stack：用于计算过程中的临时数据。  
codes：通常指合约的字节码，但在此上下文中不特别作为存储模式提及。  
logs：用于记录事件。  
## 函数：
开放度：internal（内部）、external（外部）、public（公共）、private（私有）。  
返回值：使用returns(类型)指定。  
能收钱：在函数声明末尾加payable，表示该函数可以接受以太币。  
操作范围：view（只读）、pure（不修改状态，只进行计算）。  
## 引入其他合约：
可以直接引入同一文件系统下的合约。  
可以引入GitHub上的合约。  
可以通过包管理引入。  
示例：import {HelloWorld} from "./test1.sol"; 或 import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
## 预言机（Oracle）：
通过import引入预言机接口。  
获取预言机地址，例如：dataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);  
使用预言机获取数据，例如：function getChainlinkDataFeedLatestAnswer() public view returns (int) { (int answer,) = dataFeed.latestRoundData(); return answer; }  
可以访问预言机官网（如Chainlink Docs）获取相关信息和示例代码。  
## 修饰符（modifier）：
用于封装逻辑，类似于其他编程语言中的切面。  
示例：onlyOwner，用于限制只有合约所有者可以调用某些函数。  
使用时跟在方法后面，例如：function transferOwnership(address newOwner) public onlyOwner { owner = newOwner; }  
修饰符内部使用_表示被修饰函数体的执行位置。  
## 时间戳的使用：
使用block.timestamp获取当前区块的时间戳。  
可以用于实现锁定期等功能。  
## 一些上下文中的值：
this：表示合约本身，可以使用address(this).balance获取合约的余额。  
msg.sender：调用函数的账户地址。  
msg.value：随交易发送的以太币数量。  
## 转账的三种方式：
transfer：只能转账，如果失败会抛出异常。  
send：只能转账，返回一个布尔值表示是否成功。  
call：推荐使用，不仅可以转账，还可以执行其他操作，并返回执行结果和自定义消息。  
## 典型漏洞：
提款或退款后，未清空mapping对应键的值，导致重复提取。  
希望这个整理能够帮助您更好地理解智能合约开发中的相关概念和用法。  
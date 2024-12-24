// comment :this is my first smart contract
// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.26;
contract HelloWorld {
    // //布尔值
    // bool boolVar_2 = true;
    // bool boolVar_1 = false;
    
    // //无符号数字
    // uint256 unitVar = 255555555555555;
    // //有符号数字
    // int8 intVar = -1;

    
    // bytes16 bytesVar = "Hello World";//存字符串 bytes最大32 //bytes byte数字不是一种类型
  
    
    // //地址
    // address addrVar = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

      string strVar = "Hello World";//动态分配空间  

    //函数  可见度标识符 internal  external private public
    //view 仅读取
    function sayHello() public view returns(string memory){
        return addinfo(strVar);
    } 
    //修改
    function setHelloWorld(string memory newString) public{
        strVar = newString;
    }
    //计算  pure不修改 只运算
    function addinfo(string memory helloWorldStr) internal pure returns(string memory){
      return string.concat(helloWorldStr,"from jy's contract");
    }
    //存储模式  只针对存储结构
    //1 storage 永久
    //2 memory 暂时性 用于函数入参 运行时可修改
    //3 calldata 暂时性 用于函数入参 运行时不可修改
    //4 stack 
    //5 codes
    // 6 logs
//unit bytes32  int 不需要加存储模式的标识




    

}
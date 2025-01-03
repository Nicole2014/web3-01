// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
import { HelloWorld } from "./test1.sol";
// import { HelloWorld } from "网络地址：//./test1.sol";
//1直接引入统一文件系统下合约
//2引入github上的合约
//3通过包引入
contract HelloWorldFactory {
    HelloWorld hw;
    HelloWorld[] hws;
    function createHelloWorld() public{
        hw = new HelloWorld();
        hws.push(hw);
    } 
    function getHelloWorldByIndex (uint256 _index)public view returns (HelloWorld){
        return hws[_index];
    } 

    function callSayHelloFromFactory(uint256 _index,uint256 _id)
    public view returns(string memory){
        return hws[_index].sayHello(_id);
    }   
    function callSetHelloWorldFromFactory(uint256 _index,string memory newString,
    uint256 _id) public {
        hws[_index].setHelloWorld(newString,_id);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.26;
//struct 结构体
//array：数组
//mapping：映射
contract HelloWorld{
    string strVar = "hello world";
    struct Info{
        string phrase;
        uint256 id;
        address addr;
    }
    Info[] infos;
    mapping(uint256 id=>Info info) infoMapping;
    function sayHello(uint256 _id) public view returns(string memory){
        if(infoMapping[_id].addr == address(0x0)){
            return addinfo(strVar);
        }else{
            return infoMapping[_id].phrase;
        }
        // for(uint256 i=0 ;i<infos.length;i++){
        //  if(infos[i].id ==_id){
        //       return addinfo(infos[i].phrase);
        //     }
        // }
        // return addinfo(strVar);
    }
    function addinfo(string memory helloWorldStr) internal pure returns(string memory){
      return string.concat(helloWorldStr,"from jy's contract");
    }
        //修改
    function setHelloWorld(string memory newString,uint256 _id) public{
        Info memory info = Info(newString, _id,msg.sender);
        infoMapping[_id] = info;
        // infos.push(info);
    }

    



}
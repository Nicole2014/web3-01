// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

//1.创建一个收款函数
//2.记录投资人并且查看
//3.锁定期内达到目标值，生产商可以提款
//4.锁定期内没有达到目标值，投资人可以在锁定期以后退款
contract FundMe{
    
    mapping (address=>uint256)public fundersToAmount;
    // uint256 MINIMUM_VALUE=1*10**18;//wei   
    uint256 MINIMUM_VALUE=100*10**18;//USD
    //USD 预言机
    AggregatorV3Interface internal dataFeed;
    uint256 constant TARGET = 1000 * 10 **18;
    address owner;
    //时间锁 unixtimestamp.com
    uint256 deploymentTimestamp;
    uint256 lockTime;
    constructor(uint256 _lockTime){
        //sepolia
        dataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        owner = msg.sender;
        deploymentTimestamp = block.timestamp;
        lockTime = _lockTime;

    }


    function fund()external payable {
        require(msg.value>=MINIMUM_VALUE,"Send more ETH");//revert
        require(block.timestamp < deploymentTimestamp + lockTime,"window is closed"); 
        //address     
        fundersToAmount[msg.sender] = msg.value;  
    


    }

    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    function convertEthToUsd(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = uint256(getChainlinkDataFeedLatestAnswer());
        return ethAmount * ethPrice / (10**8);

    }

    function transgerOwnership(address newOwner) public onlyOwner{
        // require(msg.sender==owner,"this function can only be called by owner");
        owner = newOwner;
    }
    //3 取款
    function getFund() external  windowClosed onlyOwner{
       require(convertEthToUsd(address(this).balance) >= TARGET,"target is not reached");
        // require(msg.sender==owner,"this function can only be called by owner");
        // //transfer 纯转账  如果失败 交易回滚 只损失gas费
        // payable (msg.sender).transfer(address(this).balance);
        // //send 纯转账  可返回布尔值
        // bool success = payable (msg.sender).send(address(this).balance);
        // require(success,"tx failed");
        //call 转账加调用函数 写数据等  推荐只用这一种就行了 返回值 和布尔值
        bool success;
        (success,) = payable(msg.sender).call{value: address(this).balance}('');
        require(success,"transfer tx failed");
        fundersToAmount[msg.sender]!=0;//记得清零！！！
    }
    //4 退款
    function refund() external windowClosed {
        require(convertEthToUsd(address(this).balance) < TARGET,"target is  reached");
        require(fundersToAmount[msg.sender]!=0,"ni mei juan guo kuan"); 
        bool success;
        (success,) = payable(msg.sender).call{value: fundersToAmount[msg.sender]}('');
        require(success,"transfer tx failed");
        fundersToAmount[msg.sender]=0;//记得清零！！！
    }

//修改器
    modifier windowClosed(){
        // _; 其他代码在前面执行
        require(block.timestamp>=deploymentTimestamp + lockTime,"window is not closed");
        _;//其他代码在后面执行
    }
    modifier onlyOwner(){
        require(msg.sender==owner,"this function can only be called by owner");
        _;
    }





}

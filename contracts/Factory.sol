//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "hardhat/console.sol";

import "./Exchange.sol";

contract Factory {

    mapping(address => address) tokenToExchange;

    //returns: address of the paired ERC20
    function createExchange(address _token) public returns (address) {

        //new Exchange로 새로운 Exchange 컨트랙트 배포.
        //new로 호출 시 내부적으로 'create' OPcode => EVM creates new contract.
        //cf) uniswap v2 'create2' => can get specific address by giving salt, etc.
        //Exchange 컨트랙트는 현재 디렉토리에 우리가 만든 것.
        Exchange exchange = new Exchange(_token);
        tokenToExchange[_token] = address(exchange);

        return address(exchange);
    }


    function getExchange(address _token) public view returns (address) {
        return tokenToExchange[_token];
    }
}
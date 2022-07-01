// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;
import "../../contracts/strategies/clearpool/IdleClearpoolStrategy.sol";
import "./TestIdleCDOBase.sol";

contract TestIdleClearpoolStrategy is TestIdleCDOBase {
  using stdStorage for StdStorage;

  function _deployStrategy(address _owner) internal override returns (
    address _strategy,
    address _underlying
  ) {
    address cpToken = 0xCb288b6d30738db7E3998159d192615769794B5b;
    _underlying = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    strategy = new IdleClearpoolStrategy();
    _strategy = address(strategy);
    stdstore
      .target(_strategy)
      .sig(strategy.token.selector)
      .checked_write(address(0));
    IdleClearpoolStrategy(_strategy).initialize(cpToken, _underlying, _owner);
  }

  function _postDeploy(address _cdo, address _owner) internal override {
    vm.prank(_owner);
    IdleClearpoolStrategy(address(strategy)).setWhitelistedCDO(address(_cdo));
  }
}
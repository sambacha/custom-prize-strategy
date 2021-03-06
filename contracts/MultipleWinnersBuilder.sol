// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.7.0;
pragma experimental ABIEncoderV2;

import "./MultipleWinnersProxyFactory.sol";

/* solium-disable security/no-block-members */
contract MultipleWinnersBuilder {

  MultipleWinnersProxyFactory public multipleWinnersProxyFactory;

  constructor (
    MultipleWinnersProxyFactory _multipleWinnersProxyFactory
  ) public {
    require(address(_multipleWinnersProxyFactory) != address(0), "MultipleWinnersBuilder/multipleWinnersProxyFactory-not-zero");
    multipleWinnersProxyFactory = _multipleWinnersProxyFactory;
  }

  function createMultipleWinners(
    PeriodicPrizeStrategy prizeStrategy, uint256 numberOfWinners
  ) external returns (MultipleWinners) {
    MultipleWinners mw = multipleWinnersProxyFactory.create();

    address[] memory externalErc20s;

    mw.initialize(
      prizeStrategy.getTrustedForwarder(),
      prizeStrategy.prizePeriodStartedAt(),
      prizeStrategy.prizePeriodSeconds(),
      prizeStrategy.prizePool(),
      address(prizeStrategy.ticket()),
      address(prizeStrategy.sponsorship()),
      prizeStrategy.rng(),
      externalErc20s,
      numberOfWinners
    );

    return mw;
  }
}

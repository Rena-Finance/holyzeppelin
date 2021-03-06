// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;

import "hardhat/console.sol";

import "../../../security/Context.sol";
import "../ERC20.sol";
import "../../../math/SafeMath.sol";

/**
 * @dev Extension of {ERC20} that allows token holders to destroy both their own
 * tokens and those that they have an allowance for, in a way that can be
 * recognized off-chain (via event analysis).
 */
abstract contract ERC20Burnable is ERC20 {

    using SafeMath for uint256;

    /**
     * @dev Destroys `amount` tokens from the caller.
     *
     * See {ERC20-_burn}.
     */
    function burn(uint256 amount) public virtual {
        _burn(Context._msgSender(), amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, deducting from the caller's
     * allowance.
     *
     * See {ERC20-_burn} and {ERC20-allowance}.
     *
     * Requirements:
     *
     * - the caller must have allowance for ``accounts``'s tokens of at least
     * `amount`.
     */
    function burnFrom( address account_, uint256 amount_ ) public virtual {
        _burnFrom( account_, amount_ );
    }

    function _burnFrom( address account_, uint256 amount_ ) public virtual {
        uint256 decreasedAllowance_ = allowance( account_, Context._msgSender() ).sub( amount_, "ERC20: burn amount exceeds allowance");

        _approve( account_, Context._msgSender(), decreasedAllowance_ );
        _burn( account_, amount_ );
    }
}
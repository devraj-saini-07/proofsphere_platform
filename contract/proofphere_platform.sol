
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ProofSphere Platform
 * @dev Simple proof registry smart contract for storing and verifying data hashes.
 */
contract Project {
    
    struct Proof {
        address creator;
        uint256 timestamp;
        bool exists;
    }

    // Mapping of data hash → Proof data
    mapping(bytes32 => Proof) private proofs;

    // Event emitted when a new proof is registered
    event ProofRegistered(bytes32 indexed dataHash, address indexed creator, uint256 timestamp);

    /**
     * @notice Register a digital proof by submitting the hash of a file or data.
     * @param dataHash The hash (bytes32) of the data to be stored.
     */
    function registerProof(bytes32 dataHash) external {
        require(!proofs[dataHash].exists, "Proof already exists.");

        proofs[dataHash] = Proof({
            creator: msg.sender,
            timestamp: block.timestamp,
            exists: true
        });

        emit ProofRegistered(dataHash, msg.sender, block.timestamp);
    }

    /**
     * @notice Verify whether a given data hash is registered.
     * @param dataHash The hash to verify.
     * @return creator Address of the registrant.
     * @return timestamp Time of registration.
     * @return exists Boolean confirmation.
     */
    function verifyProof(bytes32 dataHash)
        external
        view
        returns (address creator, uint256 timestamp, bool exists)
    {
        Proof memory proof = proofs[dataHash];
        return (proof.creator, proof.timestamp, proof.exists);
    }

    /**
     * @notice Checks if a hash has been registered without returning full details.
     * @param dataHash The hash to check.
     * @return Boolean indicating proof existence.
     */
    function proofExists(bytes32 dataHash) external view returns (bool) {
        return proofs[dataHash].exists;
    }
}


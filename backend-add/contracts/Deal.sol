// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/// @title ArtworksDataDAO - Decentralized platform for managing artworks data on the Filecoin network
/// @notice Allows artists, collectors, and enthusiasts to manage, incentivize, and invest in artworks
contract ArtWorksMinter is
    ERC721,
    ERC721Enumerable,
    ERC721URIStorage,
    ERC721Burnable,
    Ownable
{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    struct Artwork {
        address artist;
        string title;
        string description;
        uint256 price;
        
    }

    mapping(uint256 => Artwork) public artworks;

    event ArtworkAdded(uint256 indexed id, address artist, string title);
    event ArtworkSold(uint256 indexed id, address buyer, uint256 price);

    constructor() ERC721("ArtWorksMinter", "ADDM") {}

    /// @dev Adds a new artwork to the DAO
    /// @param _title Title of the artwork
    /// @param _description Description of the artwork
    /// @param _price Price of the artwork

    function mintArtwork(
        address to,
        string memory _title,
        string memory _description,
        uint256 memory _price,
        string memory uri
    )
        external
        onlyOwner
    {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        // totalArtworks++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        artworks[tokenId] = Artwork(
            msg.sender,
            _title,
            _description,
            _price
        );
        emit ArtworkAdded(tokenId, msg.sender, _title);
    }

    /// @dev Allows a buyer to purchase an artwork
    /// @param _id ID of the artwork to purchase

    function buyArtwork(uint256 _id) external payable {
        require(_id <= totalArtworks, "Invalid artwork ID");
        Artwork storage artwork = artworks[_id];
        require(msg.value >= artwork.price, "Insufficient funds");

        // Transfer funds to the artist
        payable(artwork.artist).transfer(artwork.price);

        // Emit event for the artwork sale
        emit ArtworkSold(_id, msg.sender, artwork.price);
    }

    /// @dev Retrieves the details of an artwork by its ID
    /// @param _id ID of the artwork
    /// @return artist Address of the artist
    /// @return title Title of the artwork
    /// @return description Description of the artwork
    /// @return price Price of the artwork

    function getArtwork(
        uint256 _id
    )
        external
        view
        returns (
            address artist,
            string memory title,
            string memory description,
            uint256 price
        )
    {
        require(_id <= totalArtworks, "Invalid artwork ID");
        Artwork storage artwork = artworks[_id];
        return (
            artwork.artist,
            artwork.title,
            artwork.description,
            artwork.price
        );
    }

    /// @dev Retrieves the total number of artworks stored in the contract
    /// @return totalArtworks Total number of artworks

    function getTotalArtworks() external view returns (uint256) {
        return totalArtworks;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(
        uint256 tokenId
    ) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}

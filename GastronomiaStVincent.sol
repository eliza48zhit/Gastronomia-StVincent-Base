// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaStVincent
 * @dev Registro historico con Likes, Dislikes e Identificador de Metodo de Coccion.
 * Nota: Codigo ASCII puro para evitar errores de compilacion (ParserError).
 */
contract GastronomiaStVincent {

    struct Plato {
        string nombre;
        string descripcion;
        string metodoCoccion; // Ej: Asado, Hervido, Frito, Al Vapor
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con Roasted Breadfruit and Fried Jackfish
        registrarPlato(
            "Roasted Breadfruit and Fried Jackfish", 
            "Fruta del pan asada al fuego de lena servida con pescado Jack frito y salsa local.",
            "Asado"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _metodoCoccion
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            metodoCoccion: _metodoCoccion,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory metodoCoccion,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.metodoCoccion, p.likes, p.dislikes);
    }
}

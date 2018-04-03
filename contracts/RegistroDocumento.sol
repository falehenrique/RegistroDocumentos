pragma solidity ^0.4.18;

contract Dono {
    address public _enderecoDono;

    function Dono() public {
        _enderecoDono = msg.sender;
    }

    modifier apenasDono() {
        require(msg.sender == _enderecoDono);
        _;
    }

    function mudarDono(address _novoDono) public apenasDono {
        require(_novoDono != address(0));
        _enderecoDono = _novoDono;
    }

}
contract RegistroDocumento is Dono {

    // sha256 => Documento
    mapping(string => Documento) _documentos;
    uint256 public _contadorDocumentos;

    struct Documento {
        string email;
        uint256 timestamp;
    }
    
    // Obrigado
    function () public payable {
    }    
    
    function registrar(string _emailDono, string _documentoSHA) public {
        require(!existeRegistro(_documentoSHA));

        Documento memory doc = Documento(_emailDono, now);
        _documentos[_documentoSHA] = doc;
        _contadorDocumentos = _contadorDocumentos + 1;
    }    
    
    function existeRegistro(string _documentoSHA) public view returns (bool) {
        return _documentos[_documentoSHA].timestamp != 0;
    }    
    
    function consultarTimestamp(string _documentoSHA) public view returns(uint256, string) {
        Documento memory doc = _documentos[_documentoSHA];
        return (doc.timestamp, doc.email);
    }
    
    function saque() external apenasDono {
        _enderecoDono.transfer(address(this).balance);
    }
}
// class API{
//   static const hostConnect = 'http://192.168.0.101/API/conexion.php';
//   static const consultalogin = 'http://192.168.0.101/API/consultalogin.php';
//   static const consultasalones = 'http://192.168.0.101/API/consultasalones.php';
//   static const consultadisponibilidades = 'http://192.168.0.101/API/consultadisponibilidades.php';
//   static const updateperfil = 'http://192.168.0.101/API/updateperfil.php';
//   static const consultareservas = 'http://192.168.0.101/API/consultareservas.php';
//   static const updatereservas = 'http://192.168.0.101/API/updatereservas.php';
//   static const insertarreservas = 'http://192.168.0.101/API/insertarreservas.php';
//   static const updatedisponibilidadreservar = 'http://192.168.0.101/API/updatedisponibilidadreservar.php';
//   static const updatedisponibilidadcancelar = 'http://192.168.0.101/API/updatedisponibilidadcancelar.php';
//   static const updatevisitas = 'http://192.168.0.101/API/updatevisitas.php';
//   static const obtenerdatosprediccion = 'http://192.168.0.101/API/obtenerdatosprediccion.php';
// }

class API {
  // Instancia única de la clase
  static API? _instancia;

  // URLs
  final String hostConnect = 'https://reservatech.azurewebsites.net//conexion.php';
  final String consultalogin = 'https://reservatech.azurewebsites.net//consultalogin.php';
  final String consultasalones = 'https://reservatech.azurewebsites.net//consultasalones.php';
  final String consultadisponibilidades = 'https://reservatech.azurewebsites.net//consultadisponibilidades.php';
  final String updateperfil = 'https://reservatech.azurewebsites.net//updateperfil.php';
  final String consultareservas = 'https://reservatech.azurewebsites.net//consultareservas.php';
  final String updatereservas = 'https://reservatech.azurewebsites.net//updatereservas.php';
  final String insertarreservas = 'https://reservatech.azurewebsites.net//insertarreservas.php';
  final String updatedisponibilidadreservar = 'https://reservatech.azurewebsites.net//updatedisponibilidadreservar.php';
  final String updatedisponibilidadcancelar = 'https://reservatech.azurewebsites.net//updatedisponibilidadcancelar.php';
  final String updatevisitas = 'https://reservatech.azurewebsites.net//updatevisitas.php';
  final String obtenerdatosprediccion = 'https://reservatech.azurewebsites.net//obtenerdatosprediccion.php';

  // Constructor privado para evitar instanciación directa
  API._();

  // Método estático para obtener la instancia única
  static API obtenerInstancia() {
    _instancia ??= API._();
    return _instancia!;
  }
}
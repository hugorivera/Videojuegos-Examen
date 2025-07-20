Proyecto iOS - Videojuegos
Hugo Rivera

Es una aplicación desarrollada en SwiftUI con el patron de arquitectura MVVM.

Proyecto realizado como parte de un examen técnico para un proceso de reclutamiento.

Arquitectura
Se eligió el patrón MVVM ya que, el proyecto es pequeño este tipo de patrón facilita
la organizacion del código y permite realizar futuras modificaciones.

Consumo de APIs
Para consumir la información de videojuegos se utilizó Alamofire integrandolo con Async/Await

Manejo de imágenes
Se utilizó AsyncImage para mostrar las imágenes de detalle, y para mejorar la experiancia de usuario en la lista se integró Kingfisher, que nos ayuda a utilizar caché.

Persistencia local
Los datos obtenidos desde la API se estan almacenando en Core Data, con esto nos permite hacer el filtrado, la actualización de los datos y la eliminación lógica.

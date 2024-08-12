# HeOut - Flutter Shopping App

HeOut es una aplicación de compras desarrollada en Flutter, que permite a los usuarios explorar productos, ver detalles, agregar productos a un carrito de compras y realizar pagos simulados.

## Características

- **Exploración de Productos**: Los usuarios pueden explorar productos desde diferentes categorías.
- **Búsqueda**: La aplicación cuenta con una barra de búsqueda para encontrar productos específicos.
- **Carrito de Compras**: Los usuarios pueden agregar productos al carrito y proceder a la compra.
- **Detalles del Producto**: Visualización detallada de cada producto, incluyendo su imagen, descripción y precio.
- **Interfaz de Pago**: Simulación de un proceso de pago para completar una compra.

## Tecnologías Utilizadas

- **Flutter**: Framework principal para el desarrollo de la aplicación.
- **Hive**: Base de datos local para gestionar la persistencia de los datos de los usuarios.
- **HTTP**: Para realizar solicitudes API a una tienda en línea.
- **Dart**: Lenguaje de programación utilizado en Flutter.

## Estructura del Proyecto

El proyecto está organizado en las siguientes pantallas y archivos principales:

- **main.dart**: Punto de entrada de la aplicación.
- **api_service.dart**: Gestión de las solicitudes a la API externa para obtener productos y categorías.
- **welcome_screen.dart**: Pantalla principal que muestra productos y permite navegar a las categorías y el carrito.
- **categories_screen.dart**: Pantalla para explorar las diferentes categorías de productos.
- **product_details_screen.dart**: Pantalla que muestra los detalles de un producto seleccionado.
- **cart_screen.dart**: Pantalla que muestra los productos agregados al carrito y permite simular el proceso de pago.
- **checkout_screen.dart**: Pantalla de simulación de pago donde el usuario ingresa los detalles de la tarjeta.
- **user.dart**: Modelo de usuario utilizado para almacenar datos localmente con Hive.

## Instalación

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/tuusuario/heout.git
   cd heout

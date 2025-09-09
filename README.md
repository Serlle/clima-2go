# Weather App con Rails 🌤️

Aplicación de prueba en **Ruby on Rails** que consulta el clima actual a partir de un **código postal de México**, usando la API de [OpenWeather](https://openweathermap.org/current).

---

### 🚀 Requerimientos
- Ruby 3.x
- Rails 7.x
- Bundler
- Cuenta gratuita en [OpenWeather](https://home.openweathermap.org/) para obtener tu API key

---

### ⚙️ Instalación
1. Clonar el repositorio:
```
git clone git@github.com:Serlle/clima-2go.git
cd weather-app
````

2. Instalar dependencias:
```
bundle install
```
3. Crear archivo `.env` en la raíz:
```
OPENWEATHER_API_KEY=tu_api_key_aqui
```
4. Ejecutar migraciones (si fueran necesarias):
```
rails db:migrate
```
---

### ▶️ Uso

1. Iniciar servidor:
```
bin/rails s
```
2. Abrir en el navegador:
```
http://localhost:3000
```
3. Ingresar un código postal válido de México (ejemplo: `28000` para Colima).

---

### 📦 Funcionalidad

* Formulario para ingresar código postal.
* Validación de ZIP (5 dígitos).
* Llamada a API de OpenWeather.
* Muestra:
  * Código postal y colonia/ciudad.
  * Latitud y longitud.
  * Descripción del clima (en español).
  * Temperatura actual y sensación térmica.
  * Hora de amanecer y atardecer.
  * Zona horaria (offset UTC).
---

### 🧩 Estructura del Proyecto

* `app/controllers/weather_controller.rb`: lógica principal.
* `app/services/open_weather_client.rb`: integración con la API.
* `app/views/weather/`: vistas para formulario y resultados.

---

### 🔮 Próximas Mejoras

* Guardar búsquedas en base de datos.
* Tests automáticos con Minitest.
* Diseño con ReactJS.
* Soporte para más países.

---

### 🙏 Agradecimientos

Muchas gracias por la oportunidad y por revisar este proyecto.
Quedo al pendiente de cualquier comentario.
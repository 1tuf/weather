class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩️';
    } else if (condition < 400) {
      return '🌧️';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '⛄';
    } else if (condition < 800) {
      return '☁️';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'it\'s 🍦 time';
    } else if (temp > 20) {
      return 'time for shorts and 👚';
    } else if (temp < 10) {
      return 'you\'ll need 👘 and 🧤';
    } else {
      return 'Bring a 🧥';
    }
  }
}

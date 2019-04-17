# LOCATOR

1. Для добавления рандомных домов нужно выполнить `rake houses:add` c указанием Вашего токена Yandex.Geocoder API (https://tech.yandex.ru/maps/geocoder/):
```
YANDEX_GEOCODER_TOKEN=#{your_token} rake houses:add
```
2. Дальше запустить приложение с указанием вашего токена Yandex.Geocoder API :
```
YANDEX_GEOCODER_TOKEN=#{your_token} rails s
```
3. После этого можно кликать по карте на главной странице. Каждый клик отобразит все дома из пункта 1 в радиусе 4км.

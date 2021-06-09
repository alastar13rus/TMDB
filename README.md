# TMDB
Мобильное приложение для сайта themoviedb.org
[![CI](https://github.com/alastar13rus/TMDB/actions/workflows/CI.yml/badge.svg)](https://github.com/alastar13rus/TMDB/actions/workflows/CI.yml)
![GitHub last commit](https://img.shields.io/github/last-commit/alastar13rus/TMDB?style=plastic)
![Swift](https://img.shields.io/badge/Swift-5.3-green)


## Описание
Тестовое приложение для поиска информации о фильмах, сериалах, актерах.

## Что хотел показать в приложении:
* Умение разбить код согласно архитерктуре MVVM + Coordinator
* Работа с сетью (URLSession)
* Работа с БД (CoreData)
* Многопоточность (GCD)
* Rx для общения между слоями View и ViewModel
* Способность объединить разный контент в одной таблице. Секции с ячейками разного типа. Коллекции в ячейках таблицы. Использование для этого библиотеки RxDataSources.
* Бесконечная прокрутка.
* AutoLayout. Формирование UI-интерфейса полностью с помощью кода (без использования Storyboard и *.xib-файлов)
* Соответствие принципам SOLID: использование протоколов и расширений, а также внедрение зависимостей при инициализации объектов. Использование протоколов, а не конкретных классов в качестве зависимостей при объявлении класса.
* Использование DI-контейнера Swinject для соответствия принципу DependencyInversion
* CI (Github Actions)
* Unit-тесты

## Что пока не реализовано:
* Автономная работа приложения (без сети)
* Обработка ошибок
* Расширение функционала (не затронуты жанры, производственные студии)
* Изменение UI-интерфейса (мало анимаций)
* Подготовка Mock'ов для тестов 
* Больший Test Coverage

## Используемые библиотеки
1. RxSwift
2. RxCocoa
3. RxDataSources
4. Swinject
5. YoutubePlayerView

## Архитектура
MVVM + Coordinator (+Rx)

## Возможности
Для сетевых запросов используется API TMDb v.3

*  Подборки фильмов и сериалов:
    * топ рейтинга
    * популярные
    * свежие
    * ожидаемые
    
* Фильмы:
    * детальная информация
    * постеры и трейлеры
    * список актеров и создателей
    * поиск фильма по названию
    
* Сериалы:
    * детальная информация
    * постеры и трейлеры
    * список актеров и создателей
    * список сезонов
    * список эпизодов каждого сезона
    * поиск сериала по названию
    
* Актеры / Создатели:
    * детальная информация
    * список фильмов, в которых принимал участие как актер
    * список фильмов, в создании которых принимал участие
    * список сериалов, в которых принимал участие как актер
    * список сериалов, в создании которых принимал участие

* Поиск
	* мультипоиск по фильмам / сериалам / людям
	* поиск фильма / сериала по году релиза
	* поиск фильма / сериала по жанру
    
* Списки избранного (списки хранятся локально в БД CoreData):
    * избранные фильмы
    * избранные сериалы
    * избранные актеры

## Видео и скриншоты

### Таб "Поиск"
[!Поиск](https://user-images.githubusercontent.com/31746929/121350253-1b17ed00-c933-11eb-8e0e-77c29fd65137.mp4)

### Таб "Избранное"

[!Избранное](https://user-images.githubusercontent.com/31746929/121350471-692cf080-c933-11eb-845b-78c0b29ae9b0.mp4)

### Таб "Фильмы"

[!Фильмы](https://user-images.githubusercontent.com/31746929/121350321-31be4400-c933-11eb-8ea2-30f8b19ac474.mp4)

### Таб "Сериалы"

[!Сериалы](https://user-images.githubusercontent.com/31746929/121350420-55818a00-c933-11eb-8d87-17de1bd07903.mp4)

### Актеры

[!Актеры](https://user-images.githubusercontent.com/31746929/121350488-6df1a480-c933-11eb-996e-ab6fad8b8bf8.mp4)

First Header | Second Header | Second Header
------------ | ------------- | -------------
![6](https://user-images.githubusercontent.com/31746929/121351024-fec88000-c933-11eb-9db6-601b83524586.png) | ![7](https://user-images.githubusercontent.com/31746929/121351032-00924380-c934-11eb-98b2-47208112c176.png) | ![2](https://user-images.githubusercontent.com/31746929/121351006-fb34f900-c933-11eb-8597-f2c00fd52106.png)
![3](https://user-images.githubusercontent.com/31746929/121351010-fbcd8f80-c933-11eb-9165-244f3a98484c.png) | ![4](https://user-images.githubusercontent.com/31746929/121351014-fc662600-c933-11eb-9bc4-9c8ea448b51e.png) | ![5](https://user-images.githubusercontent.com/31746929/121351019-fcfebc80-c933-11eb-9492-5032deb6e948.png)
![9](https://user-images.githubusercontent.com/31746929/121351045-0425ca80-c934-11eb-8c7d-ce3a4b781971.png) | ![8](https://user-images.githubusercontent.com/31746929/121351039-02f49d80-c934-11eb-9d95-bb789a3154cc.png) | ![1](https://user-images.githubusercontent.com/31746929/121350998-fa03cc00-c933-11eb-8f42-b38d40f84d59.png)


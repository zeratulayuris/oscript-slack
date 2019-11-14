Перем WebhookURL;

// Конструктор объекта ОтправительSlack.
//
Процедура ПриСозданииОбъекта(АдресВебХука)
	WebhookURL = АдресВебХука;
КонецПроцедуры

#Область ПрограммныйИнтерфейс
Функция АдресВебХука(Значение) Экспорт
	WebhookURL = Значение;
	Возврат ЭтотОбъект;
КонецФункции

Процедура Отправить(Сообщение) Экспорт

	JSON = Сообщение.КонвертироватьВJSON();
	
	Соединение = Новый HTTPСоединение(WebhookURL, , , , Новый ИнтернетПрокси(Истина));

	Запрос = Новый HTTPЗапрос;
	Запрос.АдресРесурса = WebhookURL;
	Запрос.Заголовки.Вставить("Content-Type", "application/json");
	Запрос.УстановитьТелоИзСтроки(JSON);

	Ответ = Соединение.ВызватьHTTPМетод("POST", Запрос);
	Если Ответ.КодСостояния > 299 Тогда
		СтрокаОшибки = СтрШаблон("Не удалось отправить сообщение: %1", Ответ.ПолучитьТелоКакСтроку());
		ВызватьИсключение СтрокаОшибки;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
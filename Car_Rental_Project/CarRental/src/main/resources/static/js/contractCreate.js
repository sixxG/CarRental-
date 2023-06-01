const loader = document.getElementById('loader');

// Показать спиннер
function showLoader() {
    loader.style.display = 'block';
}

// Скрыть спиннер
function hideLoader() {
    loader.style.display = 'none';
}



const rentalForm = document.getElementById('rental-form');
const errorMessage = document.getElementById('error-message');

rentalForm.addEventListener('submit', function (event) {
    event.preventDefault();
    const dateStart = new Date(document.getElementById('Date_Start').value) || "";
    const dateEnd = new Date(document.getElementById('Date_End').value) || "";
    const diffInDays = Math.round((dateEnd - dateStart) / (1000 * 60 * 60 * 24)) || null;
    if (diffInDays < 1 || diffInDays === null) {
        errorMessage.style.display = 'block';
        errorMessage.textContent = 'Дата окончания аренды должна быть не менее чем на 1 день больше даты начала аренды.';
    } else {
        rentalForm.submit();
    }
});

//Учет цены доставки/возврата автомобиля
let deliveryPriceList = [
    {name: 'ForTakeInBusStation', price: 0},
    {name: 'ForReturnToBusStation', price: 0},
    {name: 'ForTakeInOwnVersion', price: 0},
    {name: 'ForReturnToOwnVersion', price: 0}
];

function changeDeliveryPriceList(name, price) {
    for (let i = 0; i < deliveryPriceList.length; i++) {
        if (deliveryPriceList[i].name === name) {
            deliveryPriceList[i].price = price;
        }
    }
    console.log(deliveryPriceList);
}

function cleanDeliveryPriceListByType(type) {
    if (type === "return") {
        deliveryPriceList[1].price = 0;
        deliveryPriceList[3].price = 0;
    } else if (type === "take") {
        deliveryPriceList[0].price = 0;
        deliveryPriceList[2].price = 0;
    }
    console.log(deliveryPriceList);
}
//Учет цены доставки/возврата автомобиля

function changePlaceReturn() {
    let toPlace = document.getElementById('placeReturnYourselfOption').value;
    document.getElementById('mapForDeliveryCar').setAttribute("href",
        'https://yandex.ru/maps/?rtext=56.141136,40.372616~' + toPlace);

    axios.get('https://www.mapquestapi.com/directions/v2/route', {
        params: {
            key: 'cjlAEQkMSLijqu8uGq6Bci4Xg6R3jGEn',
            from: 'Владимир,проспект Строителей,7',
            to: toPlace
        }
    })
        .then(response => {
            const distance = response.data.route.distance;
            const dinstanceFromOffice = Math.ceil(distance * 1.609344);
            const priceDelivery = Math.ceil(dinstanceFromOffice * 20)
            console.log("Расстояние: " + dinstanceFromOffice + "km");
            console.log("Цена: " + priceDelivery + "руб.");


            document.getElementById('priceForDelivery').style.display = "block";
            if (priceDelivery < 300) {
                document.getElementById('priceForDelivery').textContent = "Цена: 300 руб." + "Расстояние: " + dinstanceFromOffice + "km";
                //устанавливаем цену доставки в прайс-лист
                this.changeDeliveryPriceList("ForReturnToOwnVersion", 300);
            } else {
                document.getElementById('priceForDelivery').textContent = "Цена: " + priceDelivery + "руб. Расстояние: " + dinstanceFromOffice + "km";
                //устанавливаем цену доставки в прайс-лист
                this.changeDeliveryPriceList("ForReturnToOwnVersion", priceDelivery);
            }
            calculateDeliveryPrice();
        })
        .catch(error => {
            console.log(error);
        });
}

function changePlaceReceipt() {
    let fromPlace = document.getElementById('placeReceiptYourselfOption').value;
    document.getElementById('mapForDeliveryCarReceipt').setAttribute("href",
    'https://yandex.ru/maps/?rtext=56.141136,40.372616~' + fromPlace);

    axios.get('https://www.mapquestapi.com/directions/v2/route', {
        params: {
            key: 'cjlAEQkMSLijqu8uGq6Bci4Xg6R3jGEn',
            from: 'Владимир,проспект Строителей,7',
            to: fromPlace
        }
    })
        .then(response => {
            const distance = response.data.route.distance;
            const dinstanceFromOffice = Math.ceil(distance * 1.609344);
            const priceDelivery = Math.ceil(dinstanceFromOffice * 20)
            console.log("Расстояние: " + dinstanceFromOffice + "km");
            console.log("Цена: " + priceDelivery + "руб.");


            document.getElementById('priceForDeliveryTake').style.display = "block";
            if (priceDelivery < 300) {
                document.getElementById('priceForDeliveryTake').textContent = "Цена: 300 руб." + "Расстояние: " + dinstanceFromOffice + "km";
                //document.getElementById('DeliveryPrice').value = 300;
                //устанавливаем цену доставки в прайс-лист
                this.changeDeliveryPriceList("ForTakeInOwnVersion", 300);
            } else {
                document.getElementById('priceForDeliveryTake').textContent = "Цена: " + priceDelivery + "руб. Расстояние: " + dinstanceFromOffice + "km";
                // document.getElementById('DeliveryPrice').value = priceDelivery;
                //устанавливаем цену доставки в прайс-лист
                this.changeDeliveryPriceList("ForTakeInOwnVersion", priceDelivery);
            }
            calculateDeliveryPrice();
        })
        .catch(error => {
            console.log(error);
        });
}

function calculateResultPrice() {
    let priceForDelivery = 0;
    for (let i = 0; i < deliveryPriceList.length; i++) {
        priceForDelivery += deliveryPriceList[i].price;
    }
    const rentalPrice = document.getElementById('Price');

    const total = priceForDelivery + (parseInt(rentalPrice.value) || 0);

    document.getElementById('ResultPrice').textContent = total;
}

function calculateResultPriceToPriceRent() {
    let priceForDelivery = 0;
    for (let i = 0; i < deliveryPriceList.length; i++) {
        priceForDelivery += deliveryPriceList[i].price;
    }
    const rentalPrice = document.getElementById('Price');

    const total = priceForDelivery + (parseInt(rentalPrice.value) || 0);
    rentalPrice.setAttribute('value', isNaN(total) ? 0 : total);
}

function calculateDeliveryPrice() {
    const deliveryPrice = document.getElementById('DeliveryPrice');
    let priceForDelivery = 0;
    for (let i = 0; i < deliveryPriceList.length; i++) {
        priceForDelivery += deliveryPriceList[i].price;
    }

    deliveryPrice.setAttribute('value', isNaN(priceForDelivery) ? 0 : priceForDelivery);
}

function toggleInputFieldReceipt() {
    const selectReceipt = document.querySelector('[name="placeReceipt"]');
    const inputFieldReceipt = document.getElementById('inputFieldReceipt');
    const priceForTake = document.getElementById('priceForTake');
    const selectedOption = selectReceipt.options[selectReceipt.selectedIndex].value;

    document.getElementById('placeReceiptYourselfOption').value = '';
    inputFieldReceipt.style.display = 'none';

    document.getElementById('mapForDeliveryCarReceipt').style.display = 'none';
    document.getElementById('priceForDeliveryTake').textContent = "";

    //Очищаем прайс-лист для возврата
    this.cleanDeliveryPriceListByType("take");

    if (selectedOption === 'Свой вариант') {
        inputFieldReceipt.style.display = 'block';
        priceForTake.value = 0;
        priceForTake.textContent = "Стоимость доставки/возврата авто по вашему адресу будет рассчитана по следующей схеме: " +
            "минимальная стоимость 300руб. или 20руб. за 1км";
        document.getElementById('mapForDeliveryCarReceipt').style.display = 'block';
    } else if (selectedOption === 'Автовокзал') {
        priceForTake.textContent = "Стоимость возврата авто на Автовокзал: 500руб.";
        priceForTake.value = 500;
        priceForTake.style.display = 'block';
        //устанавливаем цену доставки в прайс-лист
        changeDeliveryPriceList("ForTakeInBusStation", 500);
    } else {
        priceForTake.value = 0;
        priceForTake.textContent = "";
    }
    calculateDeliveryPrice();
}

function toggleInputFieldReturn() {
    const selectReturn = document.querySelector('[name="placeReturn"]');
    const inputFieldReturn = document.getElementById('inputFieldReturn');
    const priceForReturn = document.getElementById('priceForReturn');
    const selectedOption = selectReturn.options[selectReturn.selectedIndex].value;

    document.getElementById('placeReturnYourselfOption').value = '';
    inputFieldReturn.style.display = 'none';

    document.getElementById('mapForDeliveryCar').style.display = 'none';
    document.getElementById('priceForDelivery').style.display = "block";
    document.getElementById('priceForDelivery').textContent = "";

    //Очищаем прайс-лист для возврата
    this.cleanDeliveryPriceListByType("return");

    if (selectedOption === 'Свой вариант') {
        inputFieldReturn.style.display = 'block';

        priceForReturn.value = 0;
        priceForReturn.textContent = "Стоимость доставки/возврата авто по вашему адресу будет рассчитана по следующей схеме: " +
            "минимальная стоимость 300руб. или 20руб. за 1км";
        document.getElementById('mapForDeliveryCar').style.display = 'block';
    } else if (selectedOption === 'Автовокзал') {
        priceForReturn.textContent = "Стоимость возврата авто на Автовокзал: 500руб.";
        priceForReturn.value = 500;
        priceForReturn.style.display = 'block';

        //устанавливаем цену доставки в прайс-лист
        changeDeliveryPriceList("ForReturnToBusStation", 500);
    } else {
        priceForReturn.value = 0;
        priceForReturn.textContent = "";
    }
    calculateDeliveryPrice();
}

($('#Date_End')).on("change keyup paste", function () {
    var dateStart = $('#Date_Start').val();
    var dateEnd = $('#Date_End').val();

    var Start = Date.parse(dateStart);
    var End = Date.parse(dateEnd);

    var timeRental = (End - Start) / (1000 * 60 * 60 * 24);
    var price = $('#PricePerDay').val();

    document.getElementById("Price").setAttribute('value', timeRental * price, 0);

    document.getElementById("rentalTime").value = roundNumber(timeRental, 1) + '.суток';

    document.getElementById('Registrator').checked = false;
    document.getElementById('AutoBox').checked = false;
    document.getElementById('child').value = 0;
});

($('#Date_Start')).on("change keyup paste", function () {
    var dateStart = $('#Date_Start').val();
    var dateEnd = $('#Date_End').val();

    var Start = Date.parse(dateStart);
    var End = Date.parse(dateEnd);

    var timeRental = (End - Start) / (1000 * 60 * 60 * 24);
    var price = $('#PricePerDay').val();

    document.getElementById("Price").setAttribute('value', roundNumber(timeRental * price, 0));

    document.getElementById("rentalTime").value = roundNumber(timeRental, 1) + '.суток';

    document.getElementById('Registrator').checked = false;
    document.getElementById('AutoBox').checked = false;
    document.getElementById('child').value = 0;
})

function codeAddress() {
    var dateStart = $('#Date_Start').val();
    var dateEnd = $('#Date_End').val();

    var Start = Date.parse(dateStart);
    var End = Date.parse(dateEnd);

    var timeRental = (End - Start) / (1000 * 60 * 60 * 24);
    var price = $('#PricePerDay').val();

    document.getElementById("Price").setAttribute('value', roundNumber(timeRental * price, 0));
    document.getElementById("rentalTime").value = roundNumber(timeRental, 1) + '.суток';

    document.getElementById('Registrator').checked = false;
    document.getElementById('AutoBox').checked = false;
    document.getElementById('child').value = 0;
}

window.onload = codeAddress;

function roundNumber(number, digits) {
    var multiple = Math.pow(10, digits);
    var rndedNum = Math.round(number * multiple) / multiple;
    return parseFloat(rndedNum);
}

function PlusPriceFORCheckBox(nameInput) {

    var dateStart = $('#Date_Start').val();
    var dateEnd = $('#Date_End').val();

    var Start = Date.parse(dateStart);
    var End = Date.parse(dateEnd);

    var Input = document.getElementById(nameInput);
    console.log(Input)
    var name = this.getAttribute('data-name');


    var timeRental = (End - Start) / (1000 * 60 * 60 * 24);
    var price = $('#PricePerDay').val();

    var priceDo = $('#Price').val();
    var priceDOInt = Number.parseInt(priceDo);
    var priceUslugi = $('#' + name).val();
    var priceUslugiInt = Number.parseInt(priceUslugi);

    var priceRental = roundNumber(timeRental * price, 0);

    if (document.getElementById(name).checked && dateEnd != "") {
        document.getElementById("Price").setAttribute('value', roundNumber((priceDOInt + (timeRental * priceUslugiInt)), 0));

        this.nextElementSibling.value = roundNumber(timeRental * priceUslugiInt, 0);
        document.getElementById('notDateEnd').innerHTML = "";

    } else if (dateEnd != "") {
        document.getElementById(name).checked = false;
        this.nextElementSibling.value = "";
        document.getElementById("Price").setAttribute('value', roundNumber((priceDOInt - (timeRental * priceUslugiInt)), 0));
    } else {
        console.log("not нажат");
        document.getElementById(name).checked = false;
        document.getElementById('notDateEnd').innerHTML = "Выберите дату завершения аренды!";
        document.getElementById("Price").setAttribute('value', roundNumber(priceDOInt - (timeRental * priceUslugiInt), 0));
        this.nextElementSibling.value = "";
    }
}

function PlusPriceFORChiledChes() {
    var dateStart = $('#Date_Start').val();
    var dateEnd = $('#Date_End').val();
    var Start = Date.parse(dateStart);
    var End = Date.parse(dateEnd);

    var timeRental = (End - Start) / (1000 * 60 * 60 * 24);

    var priceDo = $('#Price').val();
    var priceDOInt = getNowPrice();

    console.log("Функция расчёта цены аренды: " + getNowPrice());

    console.log(priceDOInt);
    var rng = document.getElementById('child');
    var rngValue = Number.parseInt(rng.value);
    console.log(rngValue);
    var priceUslugi = Number.parseInt(rngValue * 100 * timeRental);
    if (rngValue != 0 && dateEnd != "") {
        console.log("нажат");
        console.log("priceUslugi:" + (rngValue * 100));
        document.getElementById("Price").setAttribute('value', priceUslugi + priceDOInt);
        console.log("Price dop. uslugi : " + (rngValue * 100));
    } else if (dateEnd == "") {
        console.log("not нажат");
        document.getElementById('notDateEnd').innerHTML = "Выберите дату завершения аренды!";
        document.getElementById('child').value = 0;
        this.nextElementSibling.value = this.value;
    } else if (dateEnd != "") {
        document.getElementById("Price").setAttribute('value', priceDOInt - priceUslugi);
    }
}

function getNowPrice() {
    var dateStart = $('#Date_Start').val();
    var dateEnd = $('#Date_End').val();

    var Start = Date.parse(dateStart);
    var End = Date.parse(dateEnd);

    var timeRental = (End - Start) / (1000 * 60 * 60 * 24);
    var price = $('#PricePerDay').val();

    var priceUslugi1 = $('#Registrator').val();
    var priceUslugi2 = $('#AutoBox').val();

    priceUslugi1Int = 0;
    priceUslugi2Int = 0;

    if (document.getElementById("Registrator").checked) {
        priceUslugi1Int = roundNumber(timeRental * Number.parseInt(priceUslugi1), 0);
    }

    if (document.getElementById("AutoBox").checked) {
        priceUslugi2Int = roundNumber(timeRental * Number.parseInt(priceUslugi2), 0);
    }


    priceNow = roundNumber(timeRental * price, 0);
    priceNow = priceNow + priceUslugi1Int + priceUslugi2Int;
    return priceNow;
}

$('#Registrator').on('change', PlusPriceFORCheckBox);
$('#AutoBox').on('change', PlusPriceFORCheckBox);
$('#child').on('change', PlusPriceFORChiledChes);

function AddAdditionsOptions() {
    var checkBox1 = document.getElementById("Registrator").checked;
    var checkBox2 = document.getElementById("AutoBox").checked;
    var child = document.getElementById("child").value;

    var additionnalOptions = document.getElementById("Additional_Options").value;
    var input = document.getElementById("Additional_Options");

    if (checkBox1) {
        input.setAttribute('value', additionnalOptions + "Видеорегистратор;");
        additionnalOptions = document.getElementById("Additional_Options").value;
        /* console.log(additionnalOptions);*/
    }
    if (checkBox2) {

        input.setAttribute('value', additionnalOptions + "\ Автобокс;");
        additionnalOptions = document.getElementById("Additional_Options").value;
        /*            console.log(additionnalOptions);*/
    }
    if (child != 0) {
        input.setAttribute('value', additionnalOptions + "\ Детское-кресло;" + child);
        // additionnalOptions = document.getElementById("Additional_Options").value;
    }

}

// Показать спиннер при отправке запроса
axios.interceptors.request.use(config => {
    showLoader();
    return config;
});

// Скрыть спиннер при получении ответа
axios.interceptors.response.use(response => {
    hideLoader();
    return response;
}, error => {
    hideLoader();
    throw error;
});
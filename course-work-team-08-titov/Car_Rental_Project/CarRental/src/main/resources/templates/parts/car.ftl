<#macro search>
    <!-- Start search -->
    <form method="get" action="/findCar">
        <div style="display: flex; width: 100%;">

            <div style="padding: 0; display: inline-block; text-align: left; width: 50%;">
                <label>
                    <input type="number" class="inputPrice" placeholder="Цена от" id="PriceOT" name="PriceOT" value=""/>
                    <input type="number" class="inputPrice" placeholder="Цена до" id="PriceDO" name="PriceDO" value=""/>
                </label>
            </div>

            <div style="padding: 0; display: inline-block; text-align: center; width: 90%;">
                <input class="inputCar" id="ListBrand" name="ListBrand" list="BrandsList" placeholder="Марка авто"/>
                <datalist id="BrandsList">
<#--                    <option value="">Марка авто</option>-->
                    <#list carsBrand as carBrand>
                        <option value="${carBrand}">${carBrand}</option>
                    </#list>
                </datalist>
<#--                <select class="inputCar" id="ListBrand" name="ListBrand">-->
<#--                    <option value="">Марка авто</option>-->
<#--                    <#list carsBrand as carBrand>-->
<#--                        <option value="${carBrand}">${carBrand}</option>-->
<#--                    </#list>-->
<#--                </select>-->

                <select class="inputCar" id="ListTypeTransmition" name="ListTypeTransmition"><option value="">Тип КП</option>
                    <option value="Механическая">Механическая</option>
                    <option value="Автоматическая">Автоматическая</option>
                    <option value="Робот">Робот</option>
                </select>

            </div>


            <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                <input type="submit" value="Найти автомобиль" style="font-size: 24px; background: #46F046; padding: 10px; border-radius: 15px; border: 2px solid #46F046" />
            </div>

        </div>

        <p>
            <a class="betsSearch btn btn-info" type="button" data-toggle="collapse" href="#bestSearch">
                Все фильтры
            </a>
            <button type="reset" class="betsSearch btn btn-danger">Очистить</button>
        </p>

        <div class="collapse requestBody" id="bestSearch">
            <div class="form-row">
                <div class="col-md-4">
                    <label for="inputDrive">Привод</label>
                    <select id="inputDrive" name="typeDrive" class="form-control">
                        <option selected = "">Привод</option>
                        <option>Передний</option>
                        <option>Задний</option>
                        <option>Полный</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="inputBody">Кузов</label>
                    <select id="inputBody" name="typeBody" class="form-control">
                        <option selected = "">Кузов</option>
                        <option>Купе</option>
                        <option>Универсал</option>
                        <option>Кабриолет</option>
                        <option>Седан</option>
                        <option>Лимузин</option>
                        <option>Внедорожник</option>
                        <option>Хетчбэк</option>
                        <option>Пикап</option>
                        <option>Минивэн</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label for="inputPower">Мощность от</label>
                    <input type="number" name="power" id="inputPower" class="form-control"/>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-2">
                    <label for="inputYear">Год выпуска от</label>
                    <input type="number" name="year" id="inputYear" class="form-control"/>
                </div>
                <div class="col-md-2">
                    <label for="inputMileage">Пробег до</label>
                    <input type="number" name="mileage" id="inputMileage" class="form-control"/>
                </div>
            </div>
        </div>

    </form>
    <!-- End search -->

    <script>
        const urlParam = new URLSearchParams(window.location.search);

        console.log(urlParam);

        const PriceOT = urlParam.get('PriceOT');
        const PriceDO = urlParam.get('PriceDO');
        const ListBrand = urlParam.get('ListBrand');
        const ListTypeTransmition = urlParam.get('ListTypeTransmition');

        const typeDrive = urlParam.get('typeDrive');
        const typeBody = urlParam.get('typeBody');
        const power = urlParam.get('power');
        const year = urlParam.get('year');
        const mileage = urlParam.get('mileage');

        document.getElementById("inputDrive").value = typeDrive;
        document.getElementById("inputBody").value = typeBody;
        document.getElementById("inputPower").value = power;
        document.getElementById("inputYear").value = year;
        document.getElementById("inputMileage").value = mileage;

        document.getElementById("PriceOT").value = PriceOT;
        document.getElementById("PriceDO").value = PriceDO;

        if (ListBrand === null) {
            document.getElementById("ListBrand").value = "";
        } else {
            document.getElementById("ListBrand").value = ListBrand;
        }

        if (ListTypeTransmition === null) {
            document.getElementById("ListTypeTransmition").value = "";
        } else {
            document.getElementById("ListTypeTransmition").value = ListTypeTransmition;
        }
    </script>
</#macro>

<#macro classes>
    <!--Car classes-->
    <div style="display: flex; width: 100%; justify-content:center; margin-top: 2%;">

<#--        <a class="carLink" href="/carbyclass?carClass=Эконом&numberPage=0&amp;;">-->
        <a class="carLink" href="/carbyclass?carClass=Эконом&amp;">
            <div>
                <img src="/static/img/carClass/economy.png" alt="economy" loading="lazy" class="car-image" style="width: 130px; height: 80px;"/>
            </div>
            <div>
                <div class="type" id="Эконом" style="font-weight: 600;">Эконом</div>
                <div style="color: #000000; text-align: center">1000 ₽ - 2999 ₽</div>
            </div>
        </a>

<#--        <a href="/carbyclass?carClass=Комфорт&numberPage=0&amp;;" class="carLink">-->
        <a href="/carbyclass?carClass=Комфорт&amp;" class="carLink">
            <div>
                <img src="/static/img/carClass/comfort.png" alt="comfort" loading="lazy" class="car-image" style="width: 130px; height: 80px;"/>
            </div>
            <div>
                <div class="type" id="Комфорт" style="font-weight: 600;">Комфорт</div>
                <div style="color: #000000; text-align: center">3000 ₽ - 4999 ₽</div>
            </div>
        </a>

        <a href="/carbyclass?carClass=Бизнес&amp;" class="carLink">
<#--        <a href="/carbyclass?carClass=Бизнес&numberPage=0&amp;;" class="carLink">-->
            <div>
                <img src="/static/img/carClass/business.png" alt="business" loading="lazy" class="car-image" style="width: 130px; height: 80px;"/>
            </div>
            <div>
                <div class="type" id="Бизнес" style="font-weight: 600;">Бизнес</div>
                <div style="color: #000000; text-align: center">от 5000 ₽</div>
            </div>
        </a>

<#--        <a href="/carbyclass?carClass=Premium&numberPage=0&amp;;" class="carLink">-->
        <a href="/carbyclass?carClass=Premium&amp;" class="carLink">
            <div>
                <img src="/static/img/carClass/premium.png" alt="premium" loading="lazy" class="car-image" style="width: 130px; height: 80px;"/>
            </div>
            <div>
                <div class="type" id="Premium" style="font-weight: 600;">Premium</div>
                <div style="color: #000000; text-align: center">от 9000 ₽</div>
            </div>
        </a>

<#--        <a href="/carbyclass?carClass=Внедорожники&numberPage=0&amp;;" class="carLink">-->
        <a href="/carbyclass?carClass=Внедорожники&amp;" class="carLink">
            <div>
                <img src="/static/img/carClass/suvs.png" alt="suvs" loading="lazy" class="car-image" style="width: 130px; height: 80px;"/>
            </div>
            <div>
                <div class="type" id="Внедорожники" style="font-weight: 600;">Внедорожники</div>
                <div style="color: #000000; text-align: center">от 1600 ₽</div>
            </div>
        </a>

<#--        <a href="/carbyclass?carClass=Минивэны&numberPage=0&amp;;" class="carLink">-->
        <a href="/carbyclass?carClass=Минивэны&amp;" class="carLink">
            <div>
                <img src="/static/img/carClass/minivans.png" alt="minivans" loading="lazy" class="car-image" style="width: 130px; height: 80px;"/>
            </div>
            <div>
                <div class="type" id="Минивэны" style="font-weight: 600;">Минивэны</div>
                <div style="color: #000000; text-align: center">от 1300 ₽</div>
            </div>
        </a>

<#--        <a href="/carbyclass?carClass=Уникальные авто&numberPage=0&amp;;" class="carLink">-->
        <a href="/carbyclass?carClass=Уникальные авто&amp;" class="carLink">
            <div>
                <img src="/static/img/carClass/unique.png" alt="unique" loading="lazy" class="car-image" style="width: 130px; height: 80px;"/>
            </div>
            <div>
                <div class="type" id="Уникальные авто" style="font-weight: 600;">Уникальные авто</div>
                <div style="color: #000000; text-align: center">от 4000 ₽</div>
            </div>
        </a>
    </div>
    <!--Car classes-->
    <script>
        const urlParamsCarClasses = new URLSearchParams(window.location.search);
        const carClass = urlParamsCarClasses.get('carClass');

        let Element = document.querySelector('#myParam');
        // обращение к интересующему свойству и присвоение нового цвета
        document.getElementById(carClass).style.color = '#00ff00';
        document.getElementById(carClass).style.fontWeight = 600;
    </script>

</#macro>

<#macro createForm>
    <div class="row" style="margin-top: 3%;">
        <div class="form-horizontal">

            <#if carEdit??>
                <input type="hidden" name="id" value="${carEdit.id!''}"/>
            </#if>

            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2" for="WIN_Number">WIN</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="WIN_Number" type="text" value="${(carEdit.WIN_Number)!''}" maxlength="17" minlength="17" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="brand">Марка</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="brand" type="text" value="${(carEdit.brand)!''}" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="model">Модель</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="model" type="text" value="${(carEdit.model)!''}"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="body">Кузов</label>
                    <div class="col-md-10">
                        <select class="form-control" name="body" required>
                            <option value="${(carEdit.body)!''}" selected = "selected">${(carEdit.body)!'Кузов'}</option>
                            <option>Купэ</option>
                            <option>Универсал</option>
                            <option>Кабриолет</option>
                            <option>Седан</option>
                            <option>Лимузин</option>
                            <option>Внедорожник</option>
                            <option>Хетчбэк</option>
                            <option>Пикап</option>
                            <option>Минивэн</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="level">Класс</label>
                    <div class="col-md-10">
                        <select class="form-control" name="level" required>
                            <option value="${(carEdit.level)!''}">${(carEdit.level)!'Класс'}</option>
                            <option>Эконом</option>
                            <option>Комфорт</option>
                            <option>Бизнес</option>
                            <option>Premium</option>
                            <option>Внедорожники</option>
                            <option>Минивэны</option>
                            <option>Уникальные авто</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="year">Год выпуска</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="year" type="number" value="${(carEdit.year?c)!0}" max="2050" min="1800" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="mileage">Пробег</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="mileage" type="number" value="${(carEdit.mileage?c)!0}" max="1000000" min="1000" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="color">Цвет</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="color" type="text" value="${(carEdit.mileage)!""}" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="transmission">КП</label>
                    <div class="col-md-10">
                        <select class="form-control" name="transmission" required>
                            <option value="${(carEdit.transmission)!""}" selected="selected">${(carEdit.transmission)!"Трансмиссия"}</option>
                            <option>Механическая</option>
                            <option>Автоматическая</option>
                            <option>Робот</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="drive">Привод</label>
                    <div class="col-md-10">
                        <select class="form-control" name="drive" required>
                            <option value="${(carEdit.drive)!""}" selected="selected">${(carEdit.drive)!"Привод"}</option>
                            <option>Передний</option>
                            <option>Задний</option>
                            <option>Полный</option>
                        </select>
                    </div>
                </div>

            </div>

            <div class="col-md-6">

                <div class="form-group">
                    <label class="control-label col-md-2" for="power">Мощность</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="power" type="number" value="${(carEdit.power?c)!0}" max="1500" min="30" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="price">Цена в день</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="price" type="number" value="${(carEdit.price?c)!0}" max="250000" min="498" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="status">Состояние</label>
                    <div class="col-md-10">
                        <label for="free">Свободна</label>
                        <input name="status" id="free" type="radio" value="Свободна" required/>
                        <label for="bussy">Забронирована</label>
                        <input name="status" id="bussy" type="radio" value="Забронирована"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="description">Описание</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="description" type="text" value="${(carEdit.description)!''}" required/>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2" for="image">Фото</label>
                    <div class="col-md-12">
                        <div id="image-preview" style="margin: 10px; height: 300px; width: 620px">
                            <#if carEdit??>
                                <img src="/imageCar/${carEdit.image!''}" style="width: 620px; height: 300px;"/>
                                <input type="hidden" name="image" value="${carEdit.image!''}"/>
                            </#if>
                        </div>
                        <input type="file" name="newImage" id="image-input" accept=".jpg,.jpeg,.png"
                               <#if !carEdit??>required</#if>/>
                    </div>
                </div>

                <script>
                    const imageInput = document.getElementById('image-input');
                    const imagePreview = document.getElementById('image-preview');

                    imageInput.addEventListener('change', function() {
                        const file = this.files[0];
                        const reader = new FileReader();

                        reader.addEventListener('load', function() {
                            const image = new Image();
                            image.src = reader.result;
                            image.width = 620;
                            image.height = 300;
                            imagePreview.innerHTML = '';
                            imagePreview.appendChild(image);
                        });

                        reader.readAsDataURL(file);
                    });
                </script>

            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-offset-2 col-md-10">
            <input type="submit" value="Save" class="btn btn-default" />
        </div>
    </div>

</#macro>

<#macro filter>
    <form action="/filterCars" method="post">
        <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>"/>
        <input type="hidden" name="carsList" value="${cars}"/>

        <div class="form-group" style="width: 25%; text-align: left">
            <label for="inputState">State</label>
            <select id="inputState" class="form-control" name="filterByPrice">
                <option selected = "">По умолчанию</option>
                <option>По возрастанию</option>
                <option>По убыванию</option>
            </select>
        </div>
        <div class="form-group" style="width: 25%; text-align: left">
            <button type="submit">Применить</button>
        </div>
    </form>
</#macro>

<#macro carCardForMainPage car>
    <div class="col-xl-3 col-lg-4" data-id="${car.id}">
        <div class="bg-info img-rounded shadow-sm">

            <div style="padding: 15px; margin: 10px">
                <img src="/imageCar/${car.image}" width="100%" height="220px" />
                <p>
                <h4>
                    <b>
                        ${car.brand} ${car.model}
                        , ${car.year?c}
                    </b>
                </h4>
                <h4>
                    <b style="color: #5394FD; font-weight: 600">
                        <a href="/carbyclass?carClass=${car.level}&numberPage=0">${car.level}</a>
                    </b>
                </h4>
                </p>
                <hr />

                <div class="auto-description-start" style=" vertical-align: top; font-size: 14px; width: 30%; display: inline-block; margin-right: 50px;">
                    <p class="auto-description">Коробка</p>
                    <p class="auto-description">Привод</p>
                    <p class="auto-description">Пробег</p>
                    <p class="auto-description">Мощность</p>
                    <p class="auto-description">Тип кузова</p>
                </div>

                <div class="auto-description-edn" style=" vertical-align: top; font-size: 14px; width: 47%; display: inline-block; text-align: right;">
                    <p class="auto-description">${car.transmission}</p>
                    <p class="auto-description">${car.drive}</p>
                    <p class="auto-description">&gt;${car.mileage?c}</p>
                    <p class="auto-description">${car.power?c} лс.</p>
                    <p class="auto-description">${car.body}</p>
                </div>

                <div class="bg-info">
                    <h4><b>от ${car.price?c}</b> / сутки</h4>
                </div>

                <h4 class="text-success text-uppercase" style="text-align: center"></h4>
                <div style="width:100%; height:100%; text-align:center;">
                    <a class="btn-details" href="/car/details?id=${car.id}">Подробнее</a>
                </div>
            </div>
        </div>
    </div>
</#macro>

<#macro carCard car>
    <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
        <div class="bg-info img-rounded shadow-lg">

            <div style="padding: 15px; margin: 10px">
                <img src="/imageCar/${car.image}" width="100%" height="220px" alt="carImg"/>
                <p>
                <h4>
                    <b>
                        ${car.brand}
                        ${car.model}
                        ,
                        ${car.year?c}
                    </b>
                </h4>
                <h4>
                    <b style="color: #5394FD; font-weight: 600">
                        <a href="/carbyclass?carClass=${car.level}&numberPage=0">${car.level}</a>
                    </b>
                </h4>
                <hr />

                <div class="auto-description-start">
                    <p class="auto-description flat">Коробка</p>
                    <p class="auto-description flat">Привод</p>
                    <p class="auto-description flat">Пробег</p>
                    <p class="auto-description flat">Мощность</p>
                    <p class="auto-description flat">Тип кузова</p>
                </div>

                <div class="auto-description-edn">
                    <p class="auto-description">${car.transmission}</p>
                    <p class="auto-description">${car.drive}</p>
                    <p class="auto-description">&gt;${car.mileage?c}</p>
                    <p class="auto-description">${car.power?c} лс.</p>
                    <p class="auto-description">${car.body}</p>
                </div>

                <div class="bg-info">
                    <h4 class="carPrice"><b>от ${car.price?c}</b> / сутки</h4>
                </div>

                <h4 class="text-success text-uppercase" style="text-align: center">
                    <#if car.status == "Забронирована">
                        <b style="color: red">${car.status}</b>
                    <#else >
                        <b style="color: green">${car.status}</b>
                    </#if>
                </h4>

                <div style="width:100%; height:100%; text-align:center;">
                    <a class="btn-details" href="/car/details?id=${car.id?c}">Подробнее</a>
                </div>
            </div>
        </div>
    </div>
</#macro>
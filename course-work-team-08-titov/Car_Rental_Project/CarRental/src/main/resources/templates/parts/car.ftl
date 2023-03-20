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
                <select class="inputCar" id="ListBrand" name="ListBrand">
                    <option value="">Марка авто</option>
                    <#list carsBrand as carBrand>
                        <option value="${carBrand}">${carBrand}</option>
                    </#list>
                </select>

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
    </form>
    <!-- End search -->

</#macro>

<#macro classes>

    <!--Car classes-->
    <div style="display: flex; width: 100%; justify-content:center; margin-top: 2%;">

        <a class="carLink" href="/carbyclass?carClass=Эконом&numberPage=0">
            <div>
                <img src="/static/img/carClass/economy.png" alt="economy" loading="lazy" class="car-image" style="width: 130px; height: 80px;">
            </div>
            <div>
                <div class="type" id="Эконом" style="font-weight: 600;">Эконом</div>
                <div style="color: #000000; text-align: center">1000 ₽ - 2999 ₽</div>
            </div>
        </a>

        <a href="/carbyclass?carClass=Комфорт&numberPage=0" class="carLink">
            <div>
                <img src="/static/img/carClass/comfort.png" alt="comfort" loading="lazy" class="car-image" style="width: 130px; height: 80px;">
            </div>
            <div>
                <div class="type" id="Комфорт" style="font-weight: 600;">Комфорт</div>
                <div style="color: #000000; text-align: center">3000 ₽ - 4999 ₽</div>
            </div>
        </a>

        <a href="/carbyclass?carClass=Бизнес&numberPage=0" class="carLink">
            <div>
                <img src="/static/img/carClass/business.png" alt="business" loading="lazy" class="car-image" style="width: 130px; height: 80px;">
            </div>
            <div>
                <div class="type" id="Бизнес" style="font-weight: 600;">Бизнес</div>
                <div style="color: #000000; text-align: center">от 5000 ₽</div>
            </div>
        </a>

        <a href="/carbyclass?carClass=Premium&numberPage=0" class="carLink">
            <div>
                <img src="/static/img/carClass/premium.png" alt="premium" loading="lazy" class="car-image" style="width: 130px; height: 80px;">
            </div>
            <div>
                <div class="type" id="Premium" style="font-weight: 600;">Premium</div>
                <div style="color: #000000; text-align: center">от 9000 ₽</div>
            </div>
        </a>

        <a href="/carbyclass?carClass=Внедорожники&numberPage=0" class="carLink">
            <div>
                <img src="/static/img/carClass/suvs.png" alt="suvs" loading="lazy" class="car-image" style="width: 130px; height: 80px;">
            </div>
            <div>
                <div class="type" id="Внедорожники" style="font-weight: 600;">Внедорожники</div>
                <div style="color: #000000; text-align: center">от 1600 ₽</div>
            </div>
        </a>

        <a href="/carbyclass?carClass=Минивэны&numberPage=0" class="carLink">
            <div>
                <img src="/static/img/carClass/minivans.png" alt="minivans" loading="lazy" class="car-image" style="width: 130px; height: 80px;">
            </div>
            <div>
                <div class="type" id="Минивэны" style="font-weight: 600;">Минивэны</div>
                <div style="color: #000000; text-align: center">от 1300 ₽</div>
            </div>
        </a>

        <a href="/carbyclass?carClass=Уникальные авто&numberPage=0" class="carLink">
            <div>
                <img src="/static/img/carClass/unique.png" alt="unique" loading="lazy" class="car-image" style="width: 130px; height: 80px;">
            </div>
            <div>
                <div class="type" id="Уникальные авто" style="font-weight: 600;">Уникальные авто</div>
                <div style="color: #000000; text-align: center">от 4000 ₽</div>
            </div>
        </a>
    </div>
    <!--Car classes-->

</#macro>

<#macro createForm>
    <div class="row" style="margin-top: 3%;">
        <div class="form-horizontal">

            <#if carEdit??>
                <input type="hidden" name="id" value="${carEdit.id!''}">
            </#if>
            <input type="hidden" name="_csrf" value="${_csrf.token}">

            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2" for="WIN_Number">WIN</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="WIN_Number" type="text" value="${(carEdit.WIN_Number)!''}"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="brand">Марка</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="brand" type="text" value="${(carEdit.brand)!''}"/>
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
                        <select class="form-control" name="body">
                            <option value="${(carEdit.body)!''}" selected="selected">${(carEdit.body)!'Кузов'}</option>
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
                        <select class="form-control" name="level">
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
                        <input class="form-control text-box single-line" name="year" type="number" value="${(carEdit.year?c)!0}"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="mileage">Пробег</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="mileage" type="number" value="${(carEdit.mileage?c)!0}"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="color">Цвет</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="color" type="text" value="${(carEdit.mileage)!""}"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="transmission">КП</label>
                    <div class="col-md-10">
                        <select class="form-control" name="transmission">
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
                        <select class="form-control" name="drive">
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
                        <input class="form-control text-box single-line" name="power" type="number" value="${(carEdit.power)!0}"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="price">Цена в день</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="price" type="number" value="${(carEdit.price?c)!0}"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="status">Состояние</label>
                    <div class="col-md-10">
                        <label for="free">Свободна</label>
                        <input name="status" id="free" type="radio" value="Свободна"/>
                        <label for="bussy">Забронирована</label>
                        <input name="status" id="bussy" type="radio" value="Забронирована"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-md-2" for="description">Описание</label>
                    <div class="col-md-10">
                        <input class="form-control text-box single-line" name="description" type="text" value="${(carEdit.description)!''}"/>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label class="control-label col-md-2" for="image">Фото</label>
                    <div class="col-md-12">
                        <div id="image-preview" style="margin: 10px; height: 300px; width: 620px">
                            <#if carEdit??>
                                <img src="/imageCar/${carEdit.image!''}" style="width: 620px; height: 300px;">
                                <input type="hidden" name="image" value="${carEdit.image!''}">
                            </#if>
                        </div>
                        <input type="file" name="newImage" id="image-input" accept=".jpg,.jpeg,.png"/>
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
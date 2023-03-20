<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>

<@c.page>

    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 100%;">

        <form action="/car" enctype="multipart/form-data" method="post">
            <div class="row" style="margin-top: 3%;">
                <div class="form-horizontal">

                    <input type="hidden" name="_csrf" value="${_csrf.token}">

                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2" for="WIN_Number">WIN</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line <#if (map['WIN_NumberError'])??>is-invalid</#if>"
                                       value="<#if car??>${car.getWIN_Number()}</#if>" name="WIN_Number" type="text"/>

                                <#if map['WIN_NumberError']??>
                                    <div class="invalid-feedback">
                                        ${map['WIN_NumberError']}
                                    </div>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="brand">Марка</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line" name="brand" type="text"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="model">Модель</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line" name="model" type="text" value="" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="body">Кузов</label>
                            <div class="col-md-10">
                                <select class="form-control" name="body"><option value="">Кузов</option>
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
                                <select class="form-control" name="level"><option value="">Кузов</option>
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
                                <input class="form-control text-box single-line" name="year" type="number" value="" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="mileage">Пробег</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line <#if (map['mileageError'])??>is-invalid</#if>"
                                       value="<#if car??>${car.getMileage()}</#if>" name="mileage" type="number"/>
                                <#if map['mileageError']??>
                                    <div class="invalid-feedback">
                                        ${map['mileageError']}
                                    </div>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="color">Цвет</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line" name="color" type="text" value="" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="transmission">КП</label>
                            <div class="col-md-10">
                                <select class="form-control" name="transmission"><option value="">Трансмиссия</option>
                                    <option>Механическая</option>
                                    <option>Автоматическая</option>
                                    <option>Робот</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="drive">Привод</label>
                            <div class="col-md-10">
                                <select class="form-control" name="drive"><option value="">Привод</option>
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
                                <input class="form-control text-box single-line" name="power" type="number" value="0"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="price">Цена в день</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line" name="price" type="number" value="0"/>
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
                                <input class="form-control text-box single-line" name="description" type="text" value=""/>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2" for="image">Фото</label>
                            <div class="col-md-12">
                                <div id="image-preview" style="margin: 10px; height: 300px; width: 620px"></div>
                                <input type="file" name="image" id="image-input" accept=".jpg,.jpeg,.png"/>
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
                    <input type="submit" value="Добавить" class="btn btn-default" />
                </div>
            </div>
        </form>

        <br />

    </div>

</@c.page>

<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>

<@c.page>

    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 100%; margin-top: 3%">

        <form action="/car" enctype="multipart/form-data" method="post">
            <div class="row" style="margin-top: 3%;">
                <div class="form-horizontal">

                    <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">

                    <div class="col-md-6">

                        <div class="form-group">
                            <label class="control-label col-md-2" for="WIN_Number">WIN</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line custom-input"
                                       value="<#if car??>${car.getWIN_Number()}</#if>" name="WIN_Number" type="text" required/>
                                <#if map??>
                                    <#if map['WIN_Number']??>
                                        <div class="invalid-feedback">
                                            <#list map['WIN_Number'] as error>
                                                ${error}
                                            </#list>
                                        </div>
                                    </#if>
                                </#if>
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="control-label col-md-2" for="brand">Марка</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line" value="<#if car??>${car.getBrand()}</#if>" name="brand" type="text" required/>
                                <#if map??>
                                    <#if map['brand']??>
                                        <div class="invalid-feedback">
                                            <#list map['brand'] as error>
                                                ${error}
                                            </#list>
                                        </div>
                                    </#if>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="model">Модель</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line" value="<#if car??>${car.getModel()}</#if>" name="model" type="text"/>
                                <#if map??>
                                    <#if map['model']??>
                                        <div class="invalid-feedback">
                                            <#list map['model'] as error>
                                                ${error}
                                            </#list>
                                        </div>
                                    </#if>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="body">Кузов</label>
                            <div class="col-md-10">
                                <select class="form-control" onselect="<#if car??>${car.getBody()}</#if>" name="body" required><option value="">Кузов</option>
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
                                <#if map??>
                                    <#if map['body']??>
                                        <div class="invalid-feedback">
                                            <#list map['body'] as error>
                                                ${error}
                                            </#list>
                                        </div>
                                    </#if>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="level">Класс</label>
                            <div class="col-md-10">
                                <select class="form-control" onselect="<#if car??>${car.getLevel()}</#if>" name="level" required><option value="">Кузов</option>
                                    <option>Эконом</option>
                                    <option>Комфорт</option>
                                    <option>Бизнес</option>
                                    <option>Premium</option>
                                    <option>Внедорожники</option>
                                    <option>Минивэны</option>
                                    <option>Уникальные авто</option>
                                </select>
                                <#if map??>
                                    <#if map['level']??>
                                        <div class="invalid-feedback">
                                            <#list map['level'] as error>
                                                ${error}
                                            </#list>
                                        </div>
                                    </#if>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="year">Год выпуска</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line" value="<#if car??>${car.getYear()}</#if>" name="year" type="number" required/>
                                <#if map??>
                                    <#if map['year']??>
                                        <div class="invalid-feedback">
                                            <#list map['year'] as error>
                                                ${error}
                                            </#list>
                                        </div>
                                    </#if>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="mileage">Пробег</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line"
                                       value="<#if car??>${car.getMileage()}</#if>" name="mileage" type="number" required/>
                                <#if map??>
                                    <#if map['mileage']??>
                                        <div class="invalid-feedback">
                                            <#list map['mileage'] as error>
                                                ${error}
                                            </#list>
                                        </div>
                                    </#if>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="color">Цвет</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line" value="<#if car??>${car.getColor()}</#if>" name="color" type="text" required/>
                                <#if map??>
                                    <#if map['color']??>
                                        <div class="invalid-feedback">
                                            <#list map['color'] as error>
                                                ${error}
                                            </#list>
                                        </div>
                                    </#if>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="transmission">КП</label>
                            <div class="col-md-10">
                                <select class="form-control" name="transmission" onselect="<#if car??>${car.getTransmission()}</#if>" required>
                                    <option value="">Трансмиссия</option>
                                    <option>Механическая</option>
                                    <option>Автоматическая</option>
                                    <option>Робот</option>
                                </select>
                                 <#if map??>
                                    <#if map['transmission']??>
                                        <div class="invalid-feedback">
                                            <#list map['transmission'] as error>
                                                ${error}
                                            </#list>
                                        </div>
                                    </#if>
                                 </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="drive">Привод</label>
                            <div class="col-md-10">
                                <select class="form-control" name="drive" onselect="<#if car??>${car.getDrive()}</#if>" required>
                                    <option value="">Привод</option>
                                    <option>Передний</option>
                                    <option>Задний</option>
                                    <option>Полный</option>
                                </select>
                                <#if map??>
                                    <#if map['drive']??>
                                        <div class="invalid-feedback">
                                            <#list map['drive'] as error>
                                                ${error}
                                            </#list>
                                        </div>
                                    </#if>
                                </#if>
                            </div>
                        </div>

                    </div>

                    <div class="col-md-6">

                        <div class="form-group">
                            <label class="control-label col-md-2" for="power">Мощность</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line" name="power" value="<#if car??>${car.getPower()}</#if>" type="number" required/>
                                <#if map??>
                                    <#if map['power']??>
                                        <div class="invalid-feedback">
                                            <#list map['power'] as error>
                                                ${error}
                                            </#list>
                                        </div>
                                    </#if>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="price">Цена в день</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line" name="price" value="<#if car??>${car.getPrice()}</#if>" type="number" required/>
                                <#if map??>
                                    <#if map['price']??>
                                        <div class="invalid-feedback">
                                            <#list map['price'] as error>
                                                ${error}
                                            </#list>
                                        </div>
                                    </#if>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="status">Состояние</label>
                            <div class="col-md-10">
                                <label for="free">Свободна</label>
                                <input name="status" id="free" type="radio" value="Свободна"/>
                                <label for="bussy">Забронирована</label>
                                <input name="status" id="bussy" type="radio" value="Забронирована"/>
                                <#if map??>
                                    <#if map['status']??>
                                        <div class="invalid-feedback">
                                            <#list map['status'] as error>
                                                ${error}
                                            </#list>
                                        </div>
                                    </#if>
                                </#if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-2" for="description">Описание</label>
                            <div class="col-md-10">
                                <input class="form-control text-box single-line" value="<#if car??>${car.getDescription()}</#if>" name="description" type="text" required/>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-2" for="image">Фото</label>
                            <div class="col-md-12">
                                <div id="image-preview" style="margin: 10px; height: 300px; width: 620px"></div>
                                <input type="file" name="newImage" id="newImage" accept=".jpg,.jpeg,.png" required/>
                            </div>
                        </div>

                        <script>
                            const imageInput = document.getElementById('newImage');
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

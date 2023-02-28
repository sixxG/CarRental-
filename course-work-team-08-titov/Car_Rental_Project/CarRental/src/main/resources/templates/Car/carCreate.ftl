<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>

<@c.page>

    <@nav_bar.nav_bar></@nav_bar.nav_bar>
    Add Car

    <form action="/car" enctype="multipart/form-data" method="post">
        <div class="row" style="margin-top: 3%;">
            <div class="form-horizontal">

                <input type="hidden" name="_csrf" value="${_csrf.token}">

                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-2" for="WIN_Number">WIN</label>
                        <div class="col-md-10">
                            <input class="form-control text-box single-line" name="WIN_Number" type="text"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2" for="brand">Марка</label>
                        <div class="col-md-10">
                            <input name="brand" type="text" value="" />
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
                                <option>Мини-вэн</option>
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
                            <input class="form-control text-box single-line" name="year" type="number" value="0" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-2" for="mileage">Пробег</label>
                        <div class="col-md-10">
                            <input class="form-control text-box single-line" name="mileage" type="number" value="0" />
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
                            <label>Свободна</label>
                            <input name="status" type="radio" value="Свободна"/>
                            <label>Забронирована</label>
                            <input name="status" type="radio" value="Забронирована"/>
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
                            <input type="text" name="image"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <input type="submit" value="Добавить" class="btn btn-default" />
            </div>
        </div>
    </form>

</@c.page>

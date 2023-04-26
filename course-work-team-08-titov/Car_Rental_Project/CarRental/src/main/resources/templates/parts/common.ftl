<#import "nav-bar.ftl" as nav_bar>

<#macro page>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <link rel="icon" href="../../static/img/logo.png"/>

    <title>CarFY</title>

    <link href="/static/css/bootstrap.css" rel="stylesheet"/>
    <link href="/static/css/Site.css" rel="stylesheet"/>
    <link href="/static/css/Foother.css" rel="stylesheet" />
    <link href="/static/css/Button.css" rel="stylesheet" />
</head>
<body style="padding-bottom: 0px">
<@nav_bar.nav_bar></@nav_bar.nav_bar>
    <#nested>

<a href="#" class="back-to-top">
    <img src="/image/car.png" width="50px" height="50px" alt="carUp"/>
</a>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function(){
            $(window).scroll(function(){
                if ($(this).scrollTop() > 100) {
                    $('.back-to-top').fadeIn();
                } else {
                    $('.back-to-top').fadeOut();
                }
            });
            $('.back-to-top').click(function(){
                $("html, body").animate({ scrollTop: 0 }, 600);
                return false;
            });
        });
    </script>

    <script src="../../static/js/bootstrap.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
</body>
</html>
</#macro>
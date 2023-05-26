<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>404 Not Found</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <style>
        body {
            background-image: linear-gradient(to right, rgba(255,255,255, 0.2) 0 100%), url("../img/slider/slider6.jpg");
            background-background-repeat: no-repeat;
            background-position: center center;
            background-attachment: fixed;
            background-color: #2b669a;
            background-size: cover;
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            border-radius: 10%;
            background: #f2f2f2;
            max-width: 800px;
            margin-top: 6%;
            text-align: center;
            padding: 50px 20px;
        }

        h1 {
            font-size: 5em;
            margin: 0;
            line-height: 1.2;
            color: #2a2a2a;
        }

        p {
            font-size: 1.5em;
            margin-top: 20px;
            color: #666666;
        }

        a {
            color: #666666;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            color: #00ff00;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Ooops!</h1>
    <h1 style="font-weight: 600">404</h1>
    <p>Page not found</p>
    <p><a href="/">Назад на главную страницу</a></p>
    <div>
        <p>
            <a class="btn btn-primary" data-bs-toggle="collapse" href="#fullInfo" role="button" aria-expanded="false" aria-controls="collapseExample">
                Нажмите, чтобы увидеть подробную информацию
            </a>
        </p>
        <div class="collapse" id="fullInfo">
            <div class="card card-body">
                <p>Code Status: ${statusCode}<br/>
                    Request URI: ${requestUri}<br/>
                    Servlet name: ${servletName}<br/>
                </p>
                <#--                <p>Exception: ${exception!''}</p>-->
                <#--                <p>Exception type: ${exceptionType}</p>-->
            </div>
        </div>

    </div>
</div>
</body>
</html>
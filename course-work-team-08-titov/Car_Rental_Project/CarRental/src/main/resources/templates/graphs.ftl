<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Chart.js Example</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div>
  <canvas id="myChart"></canvas>
</div>

<script>
  var ctx = document.getElementById('myChart').getContext('2d');
  var myChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: [
        <#list labels as label>
        "${label?html}",
        <#if label_has_next>,</#if>
        </#list>
      ],
      datasets: [{
        label: '${data}',
        data: [
          <#list data as value>
          ${value},
          <#if value_has_next>,</#if>
          </#list>
        ],
        borderColor: 'rgba(255, 99, 132, 1)',
        backgroundColor: 'rgba(255, 99, 132, 0.2)',
        fill: true
      }]
    },
    options: {
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true
          }
        }]
      }
    }
  });
</script>
</body>
</html>
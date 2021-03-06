import { Chart } from 'chart.js';

const generateChart = () => {
    var ctx = document.getElementById('myChart').getContext('2d');

    var myChart = new Chart(ctx, {
      type: "pie",
      data: {
      labels: ["food", "rent", "drink", "tobacco", "utilities", "recreation", "transportation"],
      datasets: [{
        label: 'Price',
        data: updatePizzaPrices(),
        backgroundColor: [
          'rgb(255, 99, 132)',
          'rgb(255, 159, 64)',
          'rgb(255, 205, 86)',
          'rgb(75, 192, 192)',
          'rgb(54, 162, 235)',
          'rgb(153, 102, 255)',
          'rgb(201, 203, 207)',
        ],
        hoverOffset: 4
      }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
      },
    });
    return myChart;
  }

const addData = (chart, data) => {
  chart.data.datasets[0].data = updatePizzaPrices()
  chart.update();
}

const removeData = (chart) => {
  chart.data.datasets[0].data = []
  chart.update();
}

const updatePizzaPrices = () => {
  let selects = document.querySelectorAll('.selects');
  let prices = [];
  const data = JSON.parse(document.getElementById('data').dataset.city).data;
  selects.forEach((select) => {
    for (let category in data) {
      for (let subcategory in data[category]) {
        if (select.value === subcategory && category === select.firstElementChild.label) {
          prices.push(data[category][subcategory]);
        }
      }
    }
  });
  return prices;
}

const pizzaChart = () => {

  let selects = document.querySelectorAll('.selects');
  const data = JSON.parse(document.getElementById('data').dataset.city).data;
  const result = document.querySelector('#result');
  selects.forEach((select) => {
    select.addEventListener("change", (event) => {
      removeData(myChart);
      let newPrices = updatePizzaPrices();
      addData(myChart, newPrices)
      let total = Math.round(updatePizzaPrices().reduce((a, b) => a + b, 0));
      document.getElementById('h4-comparator').innerHTML = `TOTAL: $${total}`;
    });
  });
  let myChart = generateChart();
}

export { pizzaChart };
export { updatePizzaPrices };

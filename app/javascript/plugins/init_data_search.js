import { Chart } from 'chart.js';

const generateChart = () => {
    var ctx = document.getElementById('myChart').getContext('2d');

    var myChart = new Chart(ctx, {
      type: "bar",
      data: {
      labels: ["food", "rent", "drink", "tobacco", "utilities", "recreation", "transportation", "TOTAL"],
      datasets: [{
        label: 'Price',
        data: updatePrices(),
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 159, 64, 0.2)',
          'rgba(255, 205, 86, 0.2)',
          'rgba(75, 192, 192, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(153, 102, 255, 0.2)',
          'rgba(201, 203, 207, 0.2)',
          'rgba(0, 0, 0, 0.4)'
        ],
        borderColor: [
          'rgb(255, 99, 132)',
          'rgb(255, 159, 64)',
          'rgb(255, 205, 86)',
          'rgb(75, 192, 192)',
          'rgb(54, 162, 235)',
          'rgb(153, 102, 255)',
          'rgb(201, 203, 207)',
          'rgba(0, 0, 0)'
        ],
        borderWidth: 1
      }]
    },
      options: {
        scales: {
          y: {
            beginAtZero: true
          }
        }
      },
    });
    return myChart;
  }


const addData = (chart, data) => {
  chart.data.datasets[0].data = updatePrices()
  chart.update();
}

const removeData = (chart) => {
  chart.data.datasets[0].data = []
  chart.update();
}


const updatePrices = () => {
  let selects = document.querySelectorAll('.selects');
  let prices = [];
  const data = JSON.parse(document.getElementById('data').dataset.data);
  selects.forEach((select) => {
    for (let category in data) {
      for (let subcategory in data[category]) {
        if (select.value === subcategory && category === select.firstElementChild.label) {
          prices.push(data[category][subcategory]);
        }
      }
    }
  });
  prices.push(prices.reduce((a, b) => a + b, 0))
  return prices;
}


const initDataSearch = () => {

  let selects = document.querySelectorAll('.selects');
  const data = JSON.parse(document.getElementById('data').dataset.data);
  const result = document.querySelector('#result');
  selects.forEach((select) => {
    for (let category in data) {
      for (let subcategory in data[category]) {
        if (select.value === subcategory && category === select.firstElementChild.label) {
          result.insertAdjacentHTML('beforeend', `<p id="${category}"> ${category.toUpperCase()}: ${subcategory} | $${data[category][subcategory]}</p>`);
        }
      }
    }

    select.addEventListener("change", (event) => {

      let category = event.target.firstElementChild.label
      let subcategory = event.currentTarget.value
      document.getElementById(category).innerText = `${category.toUpperCase()}: ${subcategory} | $${data[category][subcategory]}`;

      removeData(myChart);
      let newPrices = updatePrices();
      addData(myChart, newPrices)

    });
  });
  let myChart = generateChart();
}

export { initDataSearch };

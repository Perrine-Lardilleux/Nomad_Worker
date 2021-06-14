import { Chart } from 'chart.js';

const generateChart = () => {
    var ctx = document.getElementById('myChart').getContext('2d');
    const data = JSON.parse(document.getElementById('data').dataset.data);

    var myChart = new Chart(ctx, {
      type: "bar",
      data: {
        labels: ["food", "rent", "drink", "tobacco", "utilities", "recreation", "transportation", "TOTAL"],
        datasets: [
          {
            label: 'Price',
            data: updatePrices(data),
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgb(255, 99, 132)',
            borderWidth: 1
          }
        ]
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
  chart.data.datasets[0].data = data
  chart.update();
}

const removeData = (chart) => {
  chart.data.datasets[0].data = []
  chart.update();
}

const addCityComparator = (chart, data) => {
  chart.data.datasets.push(data);
  chart.update();
}

const updatePrices = (data) => {
  let selects = document.querySelectorAll('.selects');
  let prices = [];
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
  let comparator = document.getElementById('comparator');
  console.log(comparator.value);
  selects.forEach((select) => {
    for (let category in data) {
      for (let subcategory in data[category]) {
        if (select.value === subcategory && category === select.firstElementChild.label) {
          result.insertAdjacentHTML('beforeend', `<p id="${category}"> ${category.toUpperCase()}: ${subcategory} | $${data[category][subcategory]}</p>`);
        }
      }
    }

    select.addEventListener("change", (event) => {

      let category = event.target.firstElementChild.label;
      let subcategory = event.currentTarget.value;
      document.getElementById(category).innerText = `${category.toUpperCase()}: ${subcategory} | $${data[category][subcategory]}`;

      removeData(myChart);
      let newPrices = updatePrices(data);
      addData(myChart, newPrices);

    });
  });
  let myChart = generateChart();
  const test = JSON.parse(document.getElementById('test').dataset.test);
  comparator.addEventListener("change", (event) => {
    console.log(comparator.value);
    const x = {
      label: 'Price',
      data: updatePrices(test),
      backgroundColor: 'rgba(255, 159, 64, 0.2)',
      borderColor: 'rgb(255, 159, 64)',
      borderWidth: 1
    }
    addCityComparator(myChart, x);
  });
}

export { initDataSearch };

import { Chart } from 'chart.js';
import { pizzaChart } from '../plugins/pizza_chart';

const generateChart = () => {
    var ctx = document.getElementById('myChart').getContext('2d');
    const city = JSON.parse(document.getElementById('data').dataset.city);
    var myChart = new Chart(ctx, {
      type: "bar",
      data: {
        labels: ["food", "rent", "drink", "tobacco", "utilities", "recreation", "transportation", "TOTAL"],
        datasets: [
          {
            label: city.name,
            data: updatePrices(city.data),
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
  if (chart.data.datasets.length > 1) { chart.data.datasets.pop() };
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

const resetSelected = () => {
  // document.getElementById("selectboxID").selectedIndex = -1; option.selected = ''
  let selects = document.querySelectorAll('.selects');
  selects.forEach((select) => {
    // console.log(select.getElementsByTagName('option').selectedIndex); //.forEach((option) => { option.selectedIndex = -1 })
    select.getElementsByTagName('option').forEach((option) => { option.selectedIndex = -1 })
  });
}

const economicalSearch = () => {
  const button = document.getElementById('economical-search');
  button.addEventListener("click", (event) => {
    resetSelected();
    let selects = document.querySelectorAll('.selects');
    selects.forEach((select) => {
      // console.log(select)
      select.getElementsByTagName('option')[select.getElementsByTagName('option').length - 1].selected = 'selected'
    });
  });
}

const activatePizza = () => {
  const button = document.getElementById('pizza-chart');
  button.addEventListener('click', (event) => {
    pizzaChart();
  });
}

const compareCities = (myChart, comparator) => {
  if (comparator.value === "none") {
    myChart.data.datasets.pop();
    myChart.update();
  } else {
    fetch(`/cities/${comparator.value}.json`)
      .then(response => response.json())
      .then((data) => {
        let newData = {
          label: data.name,
          data: updatePrices(data.data),
          backgroundColor: 'rgba(255, 159, 64, 0.2)',
          borderColor: 'rgb(255, 159, 64)',
          borderWidth: 1
        }
        addCityComparator(myChart, newData);
      })
  }
}

const initDataSearch = () => {
  let selects = document.querySelectorAll('.selects');
  const data = JSON.parse(document.getElementById('data').dataset.city).data;
  const result = document.querySelector('#result');
  let comparator = document.getElementById('comparator');
  selects.forEach((select) => {
    select.addEventListener("change", (event) => {
      removeData(myChart);
      let newPrices = updatePrices(data);
      addData(myChart, newPrices);
      if (myChart.data.datasets.length > 1) { compareCities(myChart, comparator) };

    });
  });
  let myChart = generateChart();
  comparator.addEventListener("change", (event) => {
    compareCities(myChart, comparator);
  });
  // economicalSearch();
}

export { initDataSearch };

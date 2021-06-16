import { Chart } from 'chart.js';
import { pizzaChart, updatePizzaPrices } from '../plugins/pizza_chart';

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

const economicalSearch = () => {
  const button = document.getElementById('economical-search');
  const myClick = new Event("change");
  button.addEventListener("click", (event) => {
    event.preventDefault();
    let selects = document.querySelectorAll('.selects');
    selects.forEach((select) => {
      select.selectedIndex = select.length - 1;
    });
    selects[0].dispatchEvent(myClick);
  });
}

const expensiveSearch = () => {
  const button = document.getElementById('expensive-search');
  const myClick = new Event("change");
  button.addEventListener("click", (event) => {
    event.preventDefault();
    let selects = document.querySelectorAll('.selects');
    selects.forEach((select) => {
      select.selectedIndex = 0;
    });
    selects[0].dispatchEvent(myClick);
  });
}

const chartToggle = (myChart) => {
  const button = document.getElementById('chart-toggle');
  let comparator = document.getElementById('toggle-comparator');
  button.addEventListener('click', (event) => {
    event.preventDefault();
    event.currentTarget.classList.toggle('pizza');
    if (event.currentTarget.classList[event.currentTarget.classList.length - 1] === 'pizza') {
      myChart.destroy();
      myChart = pizzaChart();
      event.currentTarget.innerText = "Bar Chart";
      comparator.innerHTML = "";
      let total = Math.round(updatePizzaPrices().reduce((a, b) => a + b, 0));
      document.getElementById('h4-comparator').innerHTML = `TOTAL: $${total}`;
    } else {
      location.reload();
    }
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
          backgroundColor: 'rgba(23, 190, 187, 0.2)',
          borderColor: 'rgb(23, 190, 187)',
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
      if (myChart.ctx) {
        removeData(myChart);
        let newPrices = updatePrices(data);
        addData(myChart, newPrices);
        if (myChart.data.datasets.length > 1) { compareCities(myChart, comparator) };
      }
    });
  });
  let myChart = generateChart();
  comparator.addEventListener("change", (event) => {
    compareCities(myChart, comparator);
  });
  economicalSearch();
  chartToggle(myChart);
  expensiveSearch();
}

export { initDataSearch };

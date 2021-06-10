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
    });
  });
}

export { initDataSearch };

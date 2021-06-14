fetch('/cities/:id') // Change this!
        .then(response => response.json())
        .then((data) => {
        console.log(data)
        // Do something
      });

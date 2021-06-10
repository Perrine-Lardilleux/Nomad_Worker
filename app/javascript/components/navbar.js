const initUpdateNavbarOnScroll = () => {
  const trigger = document.querySelector('.navbar-trigger');
  if (trigger) {
	  const navbar = document.querySelector('.navbar-lewagon');
	  if (navbar) {
      navbar.style.background = 'transparent';
	    window.addEventListener('scroll', () => {
	      if (window.scrollY >= (window.innerHeight/2)) {
	        navbar.style.background = '#17bebb';
	      } else {
	        navbar.style.background = 'transparent';
	      }
	    });
	  }
  }
}

export { initUpdateNavbarOnScroll };
